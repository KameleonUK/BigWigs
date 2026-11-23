
local module, L = BigWigs:ModuleDeclaration("Death Talon Wyrmguard", "Blackwing Lair")

module.revision = 20041
module.enabletrigger = module.translatedName
module.toggleoptions = {"vulnerability", "warstomp"}
module.trashMod = true
module.combatLog = true -- triggers come from the combat log

L:RegisterTranslations("enUS", function() return {
	cmd = "Wyrmguard",

	warstomp_cmd = "warstomp",
	warstomp_name = "War Stomp Alert",
	warstomp_desc = "Warn for War Stomp",

	vulnerability_cmd = "vulnerability",
	vulnerability_name = "Vulnerability",
	vulnerability_desc = "Warn for Vulnerability changes.",

	vuln_bar = "%s Vulnerability",
	noMark = "No Icon",
	-- the voice lines match "<mark> wyrmguard" and "<school> vulnerability" (Plugins\Sound.lua)
	msg_vuln = "%s Wyrmguard: %s Vulnerability",
	msg_vulnNoMark = "Wyrmguard: %s Vulnerability",

	warstomp_spell = "War Stomp",
	warstomp_bar = "War Stomp CD",

	fire = "Fire",
	frost = "Frost",
	shadow = "Shadow",
	nature = "Nature",
	arcane = "Arcane",

	curseofdoom = "Curse of Doom",
	ignite = "Ignite",
	starfire = "Starfire",
	thunderfury = "Thunderfury",
} end )

local timer = {
	warstomp = {8.5, 12.5},
	vulnerability = 599,
}

local icon = {
	warstomp = "Ability_WarStomp",
	vulnerability = "Spell_Shadow_BlackPlague",
	shadow = "spell_shadow_shadowbolt",
	fire = "Spell_Fire_Fire",
	frost = "Spell_Frost_ChillingBlast",
	nature = "spell_nature_healingtouch",
	arcane = "spell_nature_starfall",
}

local barColor = {
	nature = "green",
	frost = "blue",
	fire = "red",
	arcane = "pink",
	shadow = "black",
}

local syncName = {
	warstomp = "WyrmguardWarstomp"..module.revision,
	vuln = "WyrmguardVuln"..module.revision, -- "<guid> <school> <mark 0-8>"
}

local raidMarkNames = {
	[1] = "Star",
	[2] = "Circle",
	[3] = "Diamond",
	[4] = "Triangle",
	[5] = "Moon",
	[6] = "Square",
	[7] = "Cross",
	[8] = "Skull",
}

-- combat log school bits
local schoolByBit = {
	[4] = "fire",
	[8] = "nature",
	[16] = "frost",
	[32] = "shadow",
	[64] = "arcane",
}

-- each Wyrmguard carries one "Double received damage" aura for its school (no icon)
local vulnAura = {
	[33001] = "fire",
	[33002] = "nature",
	[33003] = "shadow",
	[33004] = "frost",
	[33005] = "arcane",
	-- "Elemental Shield", what the server script (npc_death_talon) applies: -75% magic damage taken,
	-- +1100% for one school, so the vulnerable school takes 3x and the others a quarter
	[22277] = "fire",
	[22278] = "frost",
	[22279] = "shadow",
	[22280] = "nature",
	[22281] = "arcane",
}

-- A hit from the same caster with the same spell on two Wyrmguards: the vulnerable one takes double,
-- so this ratio (well above what debuffs like Scorch or Shadow Weaving add) decides it.
local relativeRatio = 1.6

-- The old fixed thresholds, used only when there is nothing to compare: {hit, crit} for direct
-- damage, one number for a damage-over-time tick.
local threshold = {
	direct = {
		arcane = {600, 1200},
		fire = {1300, 2600},
		frost = {800, 1600},
		nature = {900, 1800},
		shadow = {1700, 3400},
	},
	directSpell = {
		[L["starfire"]] = {800, 1200},
		[L["thunderfury"]] = {800, 1200},
	},
	periodic = {
		arcane = 250,
		fire = 400,
		nature = 300,
		shadow = 500,
	},
	periodicSpell = {
		[L["curseofdoom"]] = 3000,
	},
	-- Ignite's ticks follow the mage's crits, not the target
	ignore = {
		[L["ignite"]] = true,
	},
}

local friendlyMask = COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_RAID
	+ COMBATLOG_OBJECT_AFFILIATION_OUTSIDER + COMBATLOG_OBJECT_REACTION_FRIENDLY
	+ COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_CONTROL_NPC
	+ COMBATLOG_OBJECT_TYPE_PLAYER + COMBATLOG_OBJECT_TYPE_PET + COMBATLOG_OBJECT_TYPE_GUARDIAN

local units = {}     -- [guid] = { mark, school, shownAt, barText, dead }
local pairHits = {}  -- ["<caster guid>:<spell id>"] = { [wyrmguard guid] = highest non-crit hit }
local stompNumber = 1
local deathCount = 0

local function Reset()
	units = {}
	pairHits = {}
end

function module:OnEnable()
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE", "RANGE_DAMAGE"}, nil, "DamageEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {33001, 33002, 33003, 33004, 33005, 22277, 22278, 22279, 22280, 22281}, "AuraEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, {L["warstomp_spell"]}, "WarStompEvent")

	-- the aura, read straight from any token that shows a Wyrmguard
	self:RegisterEvent("UNIT_AURA")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	self:RegisterEvent("RAID_TARGET_UPDATE")

	self:ThrottleSync(0.5, syncName.warstomp)
	self:ThrottleSync(0, syncName.vuln) -- one sync per Wyrmguard; several can come at once
	self:StartScan()
end

function module:OnSetup()
	stompNumber = 1
	deathCount = 0
	Reset()
	self:StartScan()
end

function module:OnEngage()
	self:StartScan()
end

function module:OnDisengage()
end

------------------------------
--      Unit tracking       --
------------------------------

local function MarkName(mark)
	return mark and raidMarkNames[mark] or L["noMark"]
end

function module:Unit(guid)
	local unit = units[guid]
	if not unit then
		unit = {}
		units[guid] = unit
	end
	return unit
end

function module:BarText(unit)
	return MarkName(unit.mark) .. " " .. string.format(L["vuln_bar"], L[unit.school])
end

function module:ShowBar(unit)
	if unit.barText then
		self:RemoveBar(unit.barText)
		unit.barText = nil
	end
	if unit.dead or not unit.school or not self.db.profile.vulnerability then
		return
	end
	local left = timer.vulnerability - (GetTime() - unit.shownAt)
	if left > 1 then
		unit.barText = self:BarText(unit)
		self:Bar(unit.barText, left, icon[unit.school], true, barColor[unit.school])
	end
end

-- the raid leader can move a mark at any time; the bar follows its unit
function module:SetMark(unit, mark)
	if mark == 0 then
		mark = nil
	end
	if unit.mark ~= mark then
		unit.mark = mark
		if unit.school then
			self:ShowBar(unit)
		end
	end
end

-- Found a Wyrmguard's school: tell the raid. Everyone (us too) shows it from the sync.
function module:Decide(guid, school, mark)
	local unit = self:Unit(guid)
	if unit.school or unit.dead then
		return
	end
	if mark and mark > 0 then
		self:SetMark(unit, mark)
	end
	self:Sync(syncName.vuln .. " " .. guid .. " " .. school .. " " .. (unit.mark or 0))
end

function module:ShowVulnerability(guid, school, mark)
	if not barColor[school] then
		return
	end
	local unit = self:Unit(guid)
	if not unit.mark and mark and mark > 0 then
		unit.mark = mark
	end
	if unit.school or unit.dead then
		return
	end
	unit.school = school
	unit.shownAt = GetTime()
	if self.db.profile.vulnerability then
		self:ShowBar(unit)
		local text
		if unit.mark then
			text = string.format(L["msg_vuln"], MarkName(unit.mark), L[school])
		else
			text = string.format(L["msg_vulnNoMark"], L[school])
		end
		self:Message(text, "Attention", true)
	end
end

------------------------------
--      Aura detection      --
------------------------------

function module:CheckUnit(token)
	if not UnitExists(token) or UnitName(token) ~= self.translatedName or UnitIsDead(token) then
		return
	end
	local guid = UnitGUID(token)
	if not guid then
		return
	end
	local unit = self:Unit(guid)
	-- a unit token gives its mark for certain, unmarked included
	self:SetMark(unit, GetRaidTargetIndex(token))
	if unit.school or not self.db.profile.vulnerability then
		return
	end
	for spellId, school in pairs(vulnAura) do
		if C_UnitAuras.GetUnitAuraBySpellID(token, spellId) then
			self:Decide(guid, school, unit.mark)
			return
		end
	end
end

function module:UNIT_AURA(unit)
	if unit and (string.find(unit, "^mark") or string.find(unit, "^nameplate") or unit == "target" or unit == "mouseover") then
		self:CheckUnit(unit)
	end
end

function module:PLAYER_TARGET_CHANGED()
	self:CheckUnit("target")
end

function module:UPDATE_MOUSEOVER_UNIT()
	self:CheckUnit("mouseover")
end

function module:NAME_PLATE_UNIT_ADDED(unit)
	self:CheckUnit(unit)
end

function module:RAID_TARGET_UPDATE()
	for i = 1, 8 do
		self:CheckUnit("mark" .. i)
	end
end

-- catches Wyrmguards that came into view without an event we watch
function module:Scan()
	for i = 1, 8 do
		self:CheckUnit("mark" .. i)
	end
	self:CheckUnit("target")
	for i = 1, GetNumRaidMembers() do
		self:CheckUnit("raid" .. i .. "target")
	end
end

function module:StartScan()
	if not self:IsEventScheduled("WyrmguardScan") then
		self:ScheduleRepeatingEvent("WyrmguardScan", self.Scan, 2, self)
	end
end

------------------------------
--    Combat log handlers   --
------------------------------
-- ev is described at RegisterCombatLog in Core.lua

function module:AuraEvent(ev)
	local school = vulnAura[ev.spellId]
	if school and ev.destGUID and ev.destName == self.translatedName and self.db.profile.vulnerability then
		self:Decide(ev.destGUID, school, BigWigs:RaidFlagsToMark(ev.destRaidFlags))
	end
end

-- the same caster's same spell on two Wyrmguards: returns the GUID that took double, if any
local function Compare(key, guid, amount)
	local hits = pairHits[key]
	if not hits then
		hits = {}
		pairHits[key] = hits
	end
	if not hits[guid] or amount > hits[guid] then
		hits[guid] = amount
	end
	local mine = hits[guid]
	for other, theirs in pairs(hits) do
		if other ~= guid and not (units[other] and units[other].dead) then
			if mine >= theirs * relativeRatio then
				return guid
			elseif theirs >= mine * relativeRatio then
				return other
			end
		end
	end
end

function module:DamageEvent(ev)
	local guid = ev.destGUID
	if ev.destName ~= self.translatedName or not guid then
		return
	end
	local unit = self:Unit(guid)
	if ev.destRaidFlags then
		self:SetMark(unit, BigWigs:RaidFlagsToMark(ev.destRaidFlags))
	end
	if unit.dead or not self.db.profile.vulnerability then
		return
	end
	local school = schoolByBit[ev.school or ev.spellSchool or 0]
	if not school or not ev.amount or not CombatLog_Object_IsA(ev.sourceFlags or 0, friendlyMask) then
		return
	end
	local spellName = ev.spellName or ""
	if threshold.ignore[spellName] then
		return
	end
	-- what the hit would have done without a partial resist or an absorb
	local total = ev.amount + (ev.resisted or 0) + (ev.absorbed or 0)

	-- hits on a Wyrmguard already decided still count: they show what the others aren't weak to
	if not ev.critical and ev.sourceGUID and ev.spellId then
		local vulnerable = Compare(ev.sourceGUID .. ":" .. ev.spellId, guid, total)
		if vulnerable then
			self:Decide(vulnerable, school)
			return
		end
	end
	if unit.school then
		return
	end

	local limit
	if ev.subevent == "SPELL_PERIODIC_DAMAGE" then
		limit = threshold.periodicSpell[spellName] or threshold.periodic[school]
	else
		local t = threshold.directSpell[spellName] or threshold.direct[school]
		if t then
			limit = ev.critical and t[2] or t[1]
		end
	end
	if limit and total >= limit then
		self:Decide(guid, school)
	end
end

function module:WarStompEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.warstomp)
	end
end

-- UNIT_DIED for a Wyrmguard (the core calls this): its bar goes, and the pack is done after three
function module:BossUnitDied(ev)
	if ev.destGUID then
		local unit = self:Unit(ev.destGUID)
		if unit.barText then
			self:RemoveBar(unit.barText)
			unit.barText = nil
		end
		unit.dead = true
	end
	deathCount = deathCount + 1
	if deathCount >= 3 then
		self:SendBossDeathSync()
	end
end

------------------------------
--          Syncs           --
------------------------------

function module:BigWigs_RecvSync( sync, rest, nick )
	if sync == syncName.warstomp and self.db.profile.warstomp then
		self:WarStomp(stompNumber)
		stompNumber = stompNumber + 1
		if stompNumber >= 4 then
			stompNumber = 1
		end
	elseif sync == syncName.vuln and rest then
		local _, _, guid, school, mark = string.find(rest, "^(%S+) (%a+) (%d)$")
		if guid then
			self:ShowVulnerability(guid, school, tonumber(mark))
		end
	end
end

function module:WarStomp(number)
	self:IntervalBar(L["warstomp_bar"]..number, timer.warstomp[1], timer.warstomp[2], icon.warstomp)
end

------------------------------
--          Test            --
------------------------------
-- /run BigWigs:GetModule("Death Talon Wyrmguard"):Test()
-- Fake Wyrmguards: Skull is found from its aura, Cross by comparing one caster's Frostbolts (both
-- below the old fixed threshold), and an unmarked one from a single big Shadow Bolt. Cross is then
-- re-marked Square, and Skull dies.

function module:Test()
	BigWigs:EnableModule(self:ToString())
	local me = UnitGUID("player") or "0xTESTPLAYER"
	local myFlags = COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_REACTION_FRIENDLY + COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_TYPE_PLAYER
	local skull, cross, plain = "0xF1300035850000A1", "0xF1300035850000A2", "0xF1300035850000A3"
	local function Hit(guid, mark, amount, crit)
		return {
			subevent = "SPELL_DAMAGE", sourceGUID = me, sourceFlags = myFlags, destGUID = guid,
			destName = module.translatedName, destRaidFlags = mark and math.pow(2, mark - 1) or 0,
			spellId = 25304, spellName = "Frostbolt", spellSchool = 16, school = 16, amount = amount, critical = crit,
		}
	end
	local steps = {
		{ 1, function() module:AuraEvent({ spellId = 33001, destGUID = skull, destName = module.translatedName, destRaidFlags = 128 }) end },
		{ 4, function() module:DamageEvent(Hit(skull, 8, 360)) end },
		{ 5, function() module:DamageEvent(Hit(cross, 7, 740)) end },
		{ 8, function()
			local ev = Hit(plain, nil, 2000)
			ev.spellId, ev.spellName, ev.spellSchool, ev.school = 25307, "Shadow Bolt", 32, 32
			module:DamageEvent(ev)
		end },
		{ 12, function() module:SetMark(module:Unit(cross), 6) end },
		{ 15, function() module:BossUnitDied({ destGUID = skull, destName = module.translatedName }) end },
		{ 20, function()
			deathCount = 0
			module:Message("Wyrmguard test finished", "Positive", true, false)
		end },
	}
	for i, step in ipairs(steps) do
		self:ScheduleEvent("WyrmguardTest" .. i, step[2], step[1])
	end
	self:Message("Wyrmguard test started", "Positive", true, false)
	return true
end
