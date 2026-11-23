
local module, L = BigWigs:ModuleDeclaration("Chromaggus", "Blackwing Lair")

module.revision = 30141
module.enabletrigger = module.translatedName
module.toggleoptions = {"frenzy", "enrage", -1, "breath", "vulnerability", "affliction", "bosskill"}
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED

L:RegisterTranslations("enUS", function() return {
	cmd = "Chromaggus",

	frenzy_cmd = "frenzy",
	frenzy_name = "Frenzy Alert",
	frenzy_desc = "Warn for Frenzy",

	enrage_cmd = "enrage",
	enrage_name = "Enrage Alert",
	enrage_desc = "Warn for Enrage",

	breath_cmd = "breath",
	breath_name = "Breaths Alert",
	breath_desc = "Warn for Breaths",

	vulnerability_cmd = "vulnerability",
	vulnerability_name = "Vulnerability Alert",
	vulnerability_desc = "Warn for Vulnerability",

	affliction_cmd = "affliction",
	affliction_name = "Afflictions Alert",
	affliction_desc = "Warn for Afflictions",


	bar_frenzyCd = "Frenzy CD",
	bar_frenzyDur = "Frenzy!",
	msg_frenzy = "Frenzy - Tranq now!",

	msg_lowHp = "Chromaggus under 25% - Enrages soon (at 20%)!",

	msg_enrage = "Chromaggus is Enraged!",


	--5 breaths, 2sec cast time, 30sec between and from start
		--Incinerate
			--3675 Fire Dmg
		--Corrosive Acid
			--875 - 1125 Nature dmg /3sec, -4500 armor, 15sec
		--Frost Burn
			--1750 Frost Dmg, -400% atk speed, 15sec
		--Ignite Flesh
			--657 Fire dmg /3sec, stacks, 60sec
		--Time Lapse
			--Stunned and loses aggro, 8sec (or 6?)

	bar_breathCast = "Casting ",
	bar_breathCd = " CD",
	msg_breathSoon5 = " in 5 seconds",
	msg_breathCast = "Casting ",


	trigger_vulnerabilityChanged = "flinches as its skin shimmers.", --CHAT_MSG_MONSTER_EMOTE
	msg_vulnerability = "Current Vulnerability - ",
	bar_vulnerability = " Vulnerability",


	--5 afflictions
		--Black
			--inv_misc_head_dragon_black
			--Curse, +100% fire damage taken, 10min
				--if not Ignite Flesh and not Incinerate, don't bother!
		--Blue
			--inv_misc_head_dragon_blue
			--Magic, Burns Mana, 50% slow cast, 30% slow move, 10min
		--Bronze
			--inv_misc_head_dragon_bronze
			--N/A, Random 4sec Stun, 10min
		--Green
			--inv_misc_head_dragon_green
			--Poison, 250dmg/5sec, -50% healing, 10min
		--Red
			--inv_misc_head_dragon_01
			--Disease, 50dmg/3sec, Heals Chromag 150k on death, 10min

	msg_bronzeYou = "Brood Affliction: Bronze - Consider using Hourglass Sand",
} end )

-- Timings match the server script (boss_chromaggus.cpp): each breath repeats every 60s, the first at 30s
-- and the second at 60s, so they alternate every 30s; Frenzy every 15s; the vulnerability changes every
-- 20s with the shimmer emote; Enrage below 20%.
local timer = {
	frenzyCd = {14.8,17}, --saw 14.829 to 16.995
	frenzyDur = 8,

	breathFirstCd = 30,
	breathCd = 28, --30 - 2sec cast
	breathCast = 2,

	vulnerability = 20,--was 45, changed to 20 in early dec 2023 patch
	vulnerabilityGrace = 3, -- hits this soon after a shimmer may have been cast before it, so they're ignored
}
local icon = {
	frenzy = "Ability_Druid_ChallangingRoar",
	tranquil = "Spell_Nature_Drowsy",

	enrage = "Spell_Shadow_UnholyFrenzy",

	breath1 = "INV_Misc_QuestionMark",
	breath2 = "INV_Misc_QuestionMark",
	breath_corrosiveAcid = "spell_nature_acid_01",
	breath_frostBurn = "spell_frost_chillingblast",
	breath_igniteFlesh = "spell_fire_fire",
	breath_incinerate = "spell_fire_flameshock",
	breath_timeLapse = "spell_arcane_portalorgrimmar",

	vulnerability_arcane = "spell_nature_starfall",
	vulnerability_fire = "spell_fire_flamebolt",
	vulnerability_frost = "spell_frost_frostbolt02",
	vulnerability_nature = "spell_nature_protectionformnature",
	vulnerability_shadow = "spell_shadow_shadowbolt",

	affliction_black = "inv_misc_head_dragon_black",
	affliction_blue = "inv_misc_head_dragon_blue",
	affliction_bronze = "inv_misc_head_dragon_bronze",
	affliction_green = "inv_misc_head_dragon_green",
	affliction_red = "inv_misc_head_dragon_red",
}
local color = {
	frenzyCd = "Black",
	frenzyDur = "Magenta",

	breath1 = "White",
	breath2 = "White",
	breath_corrosiveAcid = "Green",
	breath_frostBurn = "Blue",
	breath_igniteFlesh = "Orange",
	breath_incinerate = "Red",
	breath_timeLapse = "Yellow",

	vulnerability_arcane = "Magenta",
	vulnerability_fire = "Red",
	vulnerability_frost = "Blue",
	vulnerability_nature = "Green",
	vulnerability_shadow = "Black",

	affliction = "White",
}
local syncName = {
	frenzy = "ChromaggusFrenzyStart"..module.revision,
	frenzyFade = "ChromaggusFrenzyStop"..module.revision,
	lowHp = "ChromaggusLowHp"..module.revision,
	enrage = "ChromaggusEnrage"..module.revision,

	breath = "ChromaggusBreath2"..module.revision,

	vulnerability = "ChromaggusVulnerability2"..module.revision,

	affliction = "ChromaggusAffliction"..module.revision,
}

-- spell IDs (from the server script), with the English name as a fallback match (see RegisterCombatLog in Core.lua)
local spell = {
	frenzy = {23128, "Frenzy"},
	enrage = {28747, "Enrage"},
	bronze = {23170, "Brood Affliction: Bronze"},
	-- "Elemental Shield": -75% magic damage taken, +1100% for one school; hidden from the combat log
	-- on most servers, but if it does show up it decides the vulnerability at once
	shield = {22277, 22278, 22279, 22280, 22281},
}

-- the five breaths; the English name is what the breath sync carries, so other builds understand it
local breathName = {
	[23308] = "Incinerate",
	[23310] = "Time Lapse",
	[23313] = "Corrosive Acid",
	[23315] = "Ignite Flesh",
	[23187] = "Frost Burn",
}
local breathSpells = {23308, 23310, 23313, 23315, 23187, "Incinerate", "Time Lapse", "Corrosive Acid", "Ignite Flesh", "Frost Burn"}

local shieldSchool = {
	[22277] = "Fire",
	[22278] = "Frost",
	[22279] = "Shadow",
	[22280] = "Nature",
	[22281] = "Arcane",
}

local schoolByBit = {
	[4] = "Fire",
	[8] = "Nature",
	[16] = "Frost",
	[32] = "Shadow",
	[64] = "Arcane",
}

-- The vulnerable school takes 3x damage and the others a quarter (a 12x gap). The same caster's same
-- spell hitting this hard, or harder, compared with an earlier vulnerability window decides it; far
-- above what spell power procs, crits being left out, Scorch or Shadow Weaving can add.
local relativeRatio = 4

-- The old fixed thresholds, used until a caster has hits in two windows to compare: {hit, crit} for
-- direct damage, one number for a damage-over-time tick. Damage resisted or absorbed is added back.
local threshold = {
	direct = {
		Arcane = {600, 1200},
		Fire = {1300, 2600},
		Frost = {800, 1600},
		Nature = {900, 1800},
		Shadow = {1700, 3400},
	},
	directSpell = {
		["Starfire"] = {800, 1200},
		["Thunderfury"] = {800, 1200},
	},
	periodic = {
		Arcane = 250,
		Fire = 400,
		Nature = 300,
		Shadow = 500,
	},
	periodicSpell = {
		["Curse of Doom"] = 3000,
	},
	-- Ignite's ticks follow the mage's crits, not the target
	ignore = {
		["Ignite"] = true,
	},
}

local frenzyStartTime = 0
local frenzyEndTime = 0
local lowHp = nil

local breath1 = "???"
local breath2 = "???"
local breathA = true

local currentVulnerability = "???"
local vulnerabilityResetTime = GetTime()
local vulnerabilityWindow = 0 -- counts shimmers, so hits can be compared across windows
local lastHit = {} -- ["casterGUID:spellId"] = { window = n, total = damage } for non-crit hits

function module:OnEnable()
	self:RegisterEvent("UNIT_HEALTH") --lowHp
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE") --trigger_vulnerabilityChanged

	self:RegisterCombatLog("SPELL_AURA_APPLIED", spell.frenzy, "FrenzyEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", spell.frenzy, "FrenzyFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", spell.enrage, "EnrageEvent")
	self:RegisterCombatLog("SPELL_CAST_START", breathSpells, "BreathEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", spell.bronze, "BronzeEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED"}, spell.shield, "ShieldEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE", "RANGE_DAMAGE"}, nil, "DamageEvent")

	self:ThrottleSync(5, syncName.frenzy)
	self:ThrottleSync(1, syncName.frenzyFade)
	self:ThrottleSync(10, syncName.lowHp)
	self:ThrottleSync(10, syncName.enrage)

	self:ThrottleSync(25, syncName.breath)

	self:ThrottleSync(0.5, syncName.vulnerability)

	self:ThrottleSync(1, syncName.affliction)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	frenzyStartTime = 0
	frenzyEndTime = 0
	lowHp = nil

	breathA = true

	currentVulnerability = "???"
	vulnerabilityResetTime = GetTime()
	vulnerabilityWindow = 0
	lastHit = {}

	if self.db.profile.frenzy then
		self:IntervalBar(L["bar_frenzyCd"], timer.frenzyCd[1], timer.frenzyCd[2], icon.frenzy, true, color.frenzyCd)
	end

	if self.db.profile.breath then
		self:Bar(breath1..L["bar_breathCd"], timer.breathFirstCd, icon.breath1, true, color.breath1)
		self:DelayedMessage(timer.breathFirstCd - 5, breath1..L["msg_breathSoon5"], "Attention", false, nil, false)
		self:DelayedSound(timer.breathFirstCd - 3, "Three")
		self:DelayedSound(timer.breathFirstCd - 2, "Two")
		self:DelayedSound(timer.breathFirstCd - 1, "One")
	end
end

function module:OnDisengage()
end

function module:UNIT_HEALTH( msg )
	if UnitName(msg) == module.translatedName then
		local healthPct = UnitHealth(msg) * 100 / UnitHealthMax(msg)
		if healthPct > 26 and lowHp ~= nil then
			lowHp = nil
		elseif healthPct <= 25 and lowHp == nil then
			self:Sync(syncName.lowHp)
		end
	end
end

function module:CHAT_MSG_MONSTER_EMOTE(msg)
	if string.find(msg, L["trigger_vulnerabilityChanged"]) then
		self:Sync(syncName.vulnerability .. " " .."???")
	end
end

------------------------------
--   Combat log handlers    --
------------------------------
-- ev is described at RegisterCombatLog in Core.lua

function module:FrenzyEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzy)
	end
end

function module:FrenzyFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzyFade)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end

function module:BreathEvent(ev)
	if ev.sourceName == self.translatedName then
		local name = breathName[ev.spellId] or ev.spellName
		if name then
			self:Sync(syncName.breath .. " " .. name)
		end
	end
end

function module:BronzeEvent(ev)
	if self.db.profile.affliction and ev.destGUID and ev.destGUID == UnitGUID("player") then
		self:BronzeYou()
	end
end

function module:ShieldEvent(ev)
	local school = shieldSchool[ev.spellId]
	if school and (ev.destName == self.translatedName or ev.sourceName == self.translatedName) then
		-- the shield comes with the shimmer emote, whose "???" sync resets the window; the vulnerability
		-- sync is throttled by name, so the school follows a second later
		shieldSchool.seen = school
		self:ScheduleEvent("ChromaggusShield", function() module:SyncShield() end, 1)
	end
end

function module:SyncShield()
	local school = shieldSchool.seen
	shieldSchool.seen = nil
	if school and currentVulnerability ~= school then
		self:Sync(syncName.vulnerability .. " " .. school)
	end
end

function module:DamageEvent(ev)
	if ev.destName ~= self.translatedName or not ev.amount or not BigWigs:IsGroupMember(ev.sourceFlags) then
		return
	end
	if not self.db.profile.vulnerability or GetTime() < vulnerabilityResetTime + timer.vulnerabilityGrace then
		return
	end
	local school = schoolByBit[ev.school or ev.spellSchool or 0]
	if not school then
		return
	end
	local spellName = ev.spellName or ""
	if threshold.ignore[spellName] then
		return
	end
	-- what the hit would have done without a partial resist or an absorb
	local total = ev.amount + (ev.resisted or 0) + (ev.absorbed or 0)

	-- the same caster's same spell in an earlier window: a 12x gap shows which window was vulnerable
	if not ev.critical and ev.sourceGUID and ev.spellId and ev.subevent ~= "SPELL_PERIODIC_DAMAGE" then
		local key = ev.sourceGUID .. ":" .. ev.spellId
		local prev = lastHit[key]
		if prev and prev.window ~= vulnerabilityWindow and currentVulnerability == "???" and total >= prev.total * relativeRatio then
			self:SyncVulnerability(school)
		end
		if not prev then
			prev = {}
			lastHit[key] = prev
		end
		if prev.window ~= vulnerabilityWindow or total > prev.total then
			prev.window = vulnerabilityWindow
			prev.total = total
		end
	end
	if currentVulnerability ~= "???" then
		return
	end

	local limit
	if ev.subevent == "SPELL_PERIODIC_DAMAGE" then
		limit = threshold.periodicSpell[spellName] or threshold.periodic[school]
	else
		local t = threshold.direct[school]
		for name, spellLimit in pairs(threshold.directSpell) do
			if string.find(spellName, name, 1, true) then
				t = spellLimit
			end
		end
		if t then
			limit = ev.critical and t[2] or t[1]
		end
	end
	if limit and total >= limit then
		self:SyncVulnerability(school)
	end
end

function module:SyncVulnerability(school)
	if currentVulnerability == "???" then
		self:Sync(syncName.vulnerability .. " " .. school)
	end
end

------------------------------
--          Syncs           --
------------------------------

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.frenzy and self.db.profile.frenzy then
		self:Frenzy()
	elseif sync == syncName.frenzyFade and self.db.profile.frenzy then
		self:FrenzyFade()

	elseif sync == syncName.lowHp and lowHp == nil then
		self:LowHp()
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()

	elseif sync == syncName.vulnerability and rest and self.db.profile.vulnerability then
		self:Vulnerability(rest)

	elseif sync == syncName.breath and rest and self.db.profile.breath then
		self:Breath(rest)
	end
end


function module:Frenzy()
	self:RemoveBar(L["bar_frenzyCd"])

	if BigWigs:PlayerClass() == "HUNTER" then
		self:Message(L["msg_frenzy"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.tranquil, 1)
	end

	self:Bar(L["bar_frenzyDur"], timer.frenzyDur, icon.frenzy, true, color.frenzyDur)
	frenzyStartTime = GetTime()
end

function module:FrenzyFade()
	self:RemoveBar(L["bar_frenzyDur"])
	self:RemoveWarningSign(icon.tranquil)

	frenzyEndTime = GetTime()

	self:IntervalBar(L["bar_frenzyCd"], timer.frenzyCd[1] - (frenzyEndTime - frenzyStartTime), timer.frenzyCd[2] - (frenzyEndTime - frenzyStartTime), icon.frenzy, true, color.frenzyCd)
end

function module:LowHp()
	lowHp = true

	if self.db.profile.enrage then
		self:Message(L["msg_lowHp"], "Important", false, nil, false)
	end
end

function module:Enrage()
	self:Message(L["msg_enrage"], "Important", false, nil, false)
	self:Sound("Beware")
	self:WarningSign(icon.enrage, 0.7)
end

local breathStyle = {
	["Corrosive Acid"] = "corrosiveAcid",
	["Frost Burn"] = "frostBurn",
	["Ignite Flesh"] = "igniteFlesh",
	["Incinerate"] = "incinerate",
	["Time Lapse"] = "timeLapse",
}

function module:Breath(rest)
	self:CancelDelayedMessage(breath1..L["msg_breathSoon5"])
	self:CancelDelayedMessage(breath2..L["msg_breathSoon5"])
	self:CancelDelayedSound("Three")
	self:CancelDelayedSound("Two")
	self:CancelDelayedSound("One")
	self:RemoveBar(breath1..L["bar_breathCd"])
	self:RemoveBar(breath2..L["bar_breathCd"])

	if breath1 == "???" and breathA then
		breath1 = rest
		local style = breathStyle[rest]
		if style then
			icon.breath1 = icon["breath_" .. style]
			color.breath1 = color["breath_" .. style]
		end
	elseif breath2 == "???" and not breathA then
		breath2 = rest
		local style = breathStyle[rest]
		if style then
			icon.breath2 = icon["breath_" .. style]
			color.breath2 = color["breath_" .. style]
		end
	end

	if breathA then
		self:Message(L["msg_breathCast"]..breath1, "Attention", false, nil, false)

		self:Bar(L["bar_breathCast"]..breath1, timer.breathCast, icon.breath1, true, color.breath1)

		self:DelayedBar(timer.breathCast, breath2..L["bar_breathCd"], timer.breathCd, icon.breath2, true, color.breath2)
		self:DelayedMessage(timer.breathCast + timer.breathCd - 5, breath2..L["msg_breathSoon5"], "Attention", false, nil, false)
		self:DelayedSound(timer.breathCast + timer.breathCd - 3, "Three")
		self:DelayedSound(timer.breathCast + timer.breathCd - 2, "Two")
		self:DelayedSound(timer.breathCast + timer.breathCd - 1, "One")

		breathA = nil
	else
		self:Message(L["msg_breathCast"]..breath2, "Attention", false, nil, false)

		self:Bar(L["bar_breathCast"]..breath2, timer.breathCast, icon.breath2, true, color.breath2)

		self:DelayedBar(timer.breathCast, breath1..L["bar_breathCd"], timer.breathCd, icon.breath1, true, color.breath1)
		self:DelayedMessage(timer.breathCast + timer.breathCd - 5, breath1..L["msg_breathSoon5"], "Attention", false, nil, false)
		self:DelayedSound(timer.breathCast + timer.breathCd - 3, "Three")
		self:DelayedSound(timer.breathCast + timer.breathCd - 2, "Two")
		self:DelayedSound(timer.breathCast + timer.breathCd - 1, "One")

		breathA = true
	end
end

local vulnerabilityClasses = {
	Arcane = {MAGE = true, DRUID = true},
	Fire = {MAGE = true, WARLOCK = true},
	Frost = {MAGE = true},
	Nature = {SHAMAN = true, DRUID = true},
	Shadow = {WARLOCK = true, PRIEST = true},
}

function module:Vulnerability(rest)
	self:RemoveBar(currentVulnerability..L["bar_vulnerability"])

	if rest == "???" then
		currentVulnerability = rest
		vulnerabilityResetTime = GetTime()
		vulnerabilityWindow = vulnerabilityWindow + 1
		return
	end

	local key = string.lower(rest)
	if rest == currentVulnerability or not icon["vulnerability_" .. key] then
		return
	end
	currentVulnerability = rest
	icon.vulnerability = icon["vulnerability_" .. key]
	color.vulnerability = color["vulnerability_" .. key]
	if vulnerabilityClasses[rest][BigWigs:PlayerClass()] then
		self:WarningSign(icon.vulnerability, 1)
	end

	local remaining = timer.vulnerability - (GetTime() - vulnerabilityResetTime)
	if remaining > 0 then
		self:Bar(currentVulnerability..L["bar_vulnerability"], remaining, icon.vulnerability, true, color.vulnerability)
	end

	self:Message(L["msg_vulnerability"]..currentVulnerability, "Positive", false, nil, false)
end

function module:BronzeYou()
	self:WarningSign(icon.affliction_bronze, 1.5)
	self:Message(L["msg_bronzeYou"], "Personal", false, nil, false)
	self:Sound("Info")
end

------------------------------
--          Test            --
------------------------------
-- /run local m=BigWigs:GetModule("Chromaggus"); BigWigs:SetupModule("Chromaggus"); m:Test()
-- Fake combat log events, 45 seconds: a breath, a Frenzy, a shimmer, a fire vulnerability found by
-- the old threshold, a second shimmer and a frost one found by comparing a mage's Frostbolts.
function module:Test()
	self:Engage()
	local me = UnitGUID("player")
	local boss = { destName = module.translatedName, sourceName = module.translatedName }
	local function Hit(spellId, spellName, school, amount)
		module:DamageEvent({ subevent = "SPELL_DAMAGE", destName = module.translatedName, sourceGUID = me,
			sourceFlags = COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_REACTION_FRIENDLY + COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_TYPE_PLAYER,
			spellId = spellId, spellName = spellName, school = school, amount = amount })
	end
	local events = {
		{ 2, function() print("Test: shimmer"); module:CHAT_MSG_MONSTER_EMOTE("Chromaggus " .. L["trigger_vulnerabilityChanged"]) end },
		{ 6, function() print("Test: Frostbolt for 150 (not vulnerable, remembered)"); Hit(10181, "Frostbolt", 16, 150) end },
		{ 7, function() print("Test: Fireball for 2900 (fire threshold)"); Hit(10151, "Fireball", 4, 2900) end },
		{ 8, function() print("Test: Frenzy"); module:FrenzyEvent(boss) end },
		{ 12, function() print("Test: Incinerate cast"); module:BreathEvent({ sourceName = module.translatedName, spellId = 23308, spellName = "Incinerate" }) end },
		{ 16, function() print("Test: Frenzy fades"); module:FrenzyFadeEvent(boss) end },
		{ 22, function() print("Test: shimmer"); module:CHAT_MSG_MONSTER_EMOTE("Chromaggus " .. L["trigger_vulnerabilityChanged"]) end },
		{ 26, function() print("Test: Frostbolt for 700 (under the threshold, but 4x the earlier one: frost)"); Hit(10181, "Frostbolt", 16, 700) end },
		{ 30, function() print("Test: Brood Affliction: Bronze on you"); module:BronzeEvent({ destGUID = me }) end },
		{ 45, function() print("Test: done"); module:Disengage() end },
	}
	for i, e in ipairs(events) do
		self:ScheduleEvent("ChromaggusTest" .. i, e[2], e[1])
	end
end
