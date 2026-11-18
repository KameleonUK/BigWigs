
local module, L = BigWigs:ModuleDeclaration("Ragnaros", "Molten Core")

module.revision = 30081
module.enabletrigger = module.translatedName
module.toggleoptions = {"emerge", "wrathofragnaros", "lava", "adds", "melt", "elementalfire", -1, "tankalert", "tankwrathhit", "tankwrathresist", "tankmark", "bosskill"}
module.wipemobs = {"Son of Flame"}
module.combatLog = true -- triggers come from the combat log (yells stay on chat); boss death from UNIT_DIED
module.defaultDB = {
	adds = false,
	elementalfire = false,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Ragnaros",

	emerge_cmd = "emerge",
	emerge_name = "Emerge Alert",
	emerge_desc = "Warn for Ragnaros Emerge",
	
	wrathofragnaros_cmd = "wrathofragnaros",
	wrathofragnaros_name = "Wrath of Ragnaros (Knockback) Alert",
	wrathofragnaros_desc = "Warn for Wrath of Ragnaros Knockback",
	
	lava_cmd = "lava",
	lava_name = "Touching Lava Alert",
	lava_desc = "Warn for Touching Lava",
	
	adds_cmd = "adds",
	adds_name = "Son of Flame Dies Alert",
	adds_desc = "Warn for Son of Flame Deaths",
	
	melt_cmd = "melt",
	melt_name = "Melt Weapon Alert",
	melt_desc = "Warn for Melt Weapon",

	elementalfire_cmd = "elementalfire",
	elementalfire_name = "Elemental Fire Bars",
	elementalfire_desc = "Show a duration bar for all current victims of Elemental Fire",

	tankalert_cmd = "tankalert",
	tankalert_name = "Tank Swap Alert",
	tankalert_desc = "Warning message whenever the character receiving melee hits changes",

	tankwrathhit_cmd = "tankwrathhit",
	tankwrathhit_name = "Tank Knockback Alert",
	tankwrathhit_desc = "Warns when the current tank gets knocked back by Wrath of Ragnaros",

	tankwrathresist_cmd = "tankwrathresist",
	tankwrathresist_name = "Tank Knockback Resist",
	tankwrathresist_desc = "Confirms that the current tank resisted Wrath of Ragnaros' knockback",

	tankmark_cmd = "tankmark",
	tankmark_name = "Tank Mark",
	tankmark_desc = "Marks the current tank with Skull, clears mark on knockback",


		--74.137
	trigger_domoStart1 = "Imprudent whelps! You've rushed headlong to your own deaths! See now, the master stirs!", --CHAT_MSG_MONSTER_YELL
	bar_domoStart = "Ragnaros Engage",
	msg_domoStart = "Ragnaros RP has started - Tanks, equip your Fire Resist!",
		--58.792
	trigger_domoStart2 = "Behold Ragnaros, the Firelord! He who was ancient when this world was young! Bow before him, mortals! Bow before your ending!", --CHAT_MSG_MONSTER_YELL
		--45.457
	trigger_domoStart3 = "TOO SOON! YOU HAVE AWAKENED ME TOO SOON, EXECUTUS! WHAT IS THE MEANING OF THIS INTRUSION???", --CHAT_MSG_MONSTER_YELL
		--32.144
	trigger_domoStart4 = "These mortal infidels, my lord! They have invaded your sanctum and seek to steal your secrets!", --CHAT_MSG_MONSTER_YELL
		--23.9
	trigger_domoStart5 = "FOOL! YOU ALLOWED THESE INSECTS TO RUN RAMPANT THROUGH THE HALLOWED CORE, AND NOW YOU LEAD THEM TO MY VERY LAIR? YOU HAVE FAILED ME, EXECUTUS! JUSTICE SHALL BE MET, INDEED!", --CHAT_MSG_MONSTER_YELL
		--19:44:21.439
	trigger_engage = "NOW FOR YOU, INSECTS! BOLDLY, YOU SOUGHT THE POWER OF RAGNAROS. NOW YOU SHALL SEE IT FIRSTHAND!", --CHAT_MSG_MONSTER_YELL
	
	trigger_submerge = "COME FORTH, MY SERVANTS! DEFEND YOUR MASTER!", --CHAT_MSG_MONSTER_YELL (to be confirmed)
	trigger_submerge2 = "YOU CANNOT DEFEAT THE LIVING FLAME! COME YOU MINIONS OF FIRE! COME FORTH YOU CREATURES OF HATE! YOUR MASTER CALLS!", --CHAT_MSG_MONSTER_YELL (to be confirmed)
	bar_nextEmerge = "Emerge",
	msg_submerge = "Ragnaros Submerged - Incoming Sons of Flame!",
	
	msg_emergeSoon = "Emerge in 10 seconds!",
	msg_emerge = "Ragnaros Emerged!",
	
		--melee knockback
	trigger_knockback = "TASTE THE FLAMES OF SULFURON!", --CHAT_MSG_MONSTER_YELL
	bar_knockbackCd = "Knockback CD",
	bar_knockbackSoon = "Knockback Soon...",
	msg_knockbackSoon = "Knockback Soon - Melee Out!",
	msg_knockback = "Knockback - Melee In!",
	
	trigger_lavaYou = "You lose (.+) health for swimming in lava.", --CHAT_MSG_COMBAT_SELF_HITS
	msg_lavaYou = "You're standing in lava!",

	msg_addDead = "/10 Son of Flame Dead",
	
	trigger_meltWeapon = "Ragnaros casts Melt Weapon on you: (.+) damaged.", --CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE
	bar_melt = "Melt Damage: ",

	trigger_elementalFireYou = "You are afflicted by Elemental Fire.", --CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_elementalFireOther = "(.+) is afflicted by Elemental Fire.", --CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE //CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
	trigger_elementalFireFade = "Elemental Fire fades from (.+).", --CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_elementalFire = "%s - Elemental Fire",

	trigger_hitCrit = "Ragnaros .-its (.+) for",
	trigger_miss = "Ragnaros misses (.+)%.",
	trigger_dodgeParry = "Ragnaros attacks. (.+) .-%.$",
	msg_newTank = "%s is tanking",
	msg_youTank = "YOU are tanking",

	trigger_wrathHit = "Wrath of Ragnaros hits (.+) for",
	trigger_wrathResist = "Wrath of Ragnaros was resisted by (.+)%.",
	trigger_wrathResistYou = "Wrath of Ragnaros was resisted%.",
	msg_tankWrathHit = "Knockback on Tank! %s is flying.",
	msg_tankWrathResist = "Resisted Knockback. %s still tanking.",
} end)

local timer = {
	domoStart1 = 74.137,
	domoStart2 = 58.792,
	domoStart3 = 45.457,
	domoStart4 = 32.144,
	domoStart5 = 23.9,

	nextEmerge = 90,

	knockbackCd = 25, --supposed to be 25,30
	knockbackSoon = 8,

	elementalFire = 8,
}
local icon = {
	domoStart = "inv_misc_pocketwatch_01",

	emerge = "ability_stealth",

	knockback = "ability_smash",

	lava = "spell_fire_fire",

	elementalFire = "spell_fire_flametongue",

	melt = "inv_sword_36",
}
local color = {
	domoStart = "White",

	emerge = "White",

	knockbackCd = "Black",
	knockbackSoon = "Cyan",

	elementalFire = "Red",

	melt = "Yellow",
}
local syncName = {
	submerge = "RagnarosSubmerge"..module.revision,
	emerge = "RagnarosEmerge"..module.revision,

	knockback = "RagnarosKnockback"..module.revision,

	addDead = "RagnarosSonDead"..module.revision,

	elementalFire = "RagnarosElementalFire"..module.revision,
	elementalFireFade = "RagnarosElementalFireFade"..module.revision,
	newTank = "RagnarosNewTank"..module.revision,
	tankWrathHit = "RagnarosTankWrathHit"..module.revision,
	tankWrathResist = "RagnarosTankWrathResist"..module.revision,
}

-- spell IDs, with the English name as a fallback match (see RegisterCombatLog in Core.lua)
local spell = {
	wrath = {20566, "Wrath of Ragnaros"},
	elementalFire = {20564, "Elemental Fire"},
}

local addDead = 0

local melt1 = nil
local melt2 = nil
local melt3 = nil

local meltCount1 = 50
local meltCount2 = 50
local meltCount3 = 50

local phase = nil

local lastKnockTime = 0
local submergeTime = 0

local knownTank = nil

function module:OnRegister()
	self:RegisterEvent("MINIMAP_ZONE_CHANGED")
end

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") --trigger_domoStart1, 2, 3, 4, 5, trigger_engage

	self:RegisterCombatLog("ENVIRONMENTAL_DAMAGE", nil, "LavaEvent")
	self:RegisterCombatLog("SPELL_DURABILITY_DAMAGE", nil, "MeltEvent")
	self:RegisterCombatLog("SPELL_DAMAGE", spell.wrath, "WrathHitEvent")
	self:RegisterCombatLog("SPELL_MISSED", spell.wrath, "WrathMissEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", spell.elementalFire, "ElementalFireEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", spell.elementalFire, "ElementalFireFadeEvent")
	self:RegisterCombatLog({"SWING_DAMAGE", "SWING_MISSED"}, nil, "MeleeEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")


	self:ThrottleSync(5, syncName.knockback)
	self:ThrottleSync(5, syncName.submerge)
	self:ThrottleSync(5, syncName.emerge)
	self:ThrottleSync(0.5, syncName.addDead)
	self:ThrottleSync(1, syncName.elementalFire)
	self:ThrottleSync(0.1, syncName.elementalFireFade)
	self:ThrottleSync(1, syncName.newTank)
	self:ThrottleSync(5, syncName.tankWrathHit)
	self:ThrottleSync(5, syncName.tankWrathResist)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	self:RemoveBar(L["bar_domoStart"])
	
	addDead = 0
	
	melt1 = nil
	melt2 = nil
	melt3 = nil

	meltCount1 = 50
	meltCount2 = 50
	meltCount3 = 50
	
	phase = "emerged"
	
	lastKnockTime = 0
	submergeTime = 0

	knownTank = nil
end

function module:OnDisengage()
	self:ClearKnownTank()
end

function module:MINIMAP_ZONE_CHANGED(msg)
	if GetMinimapZoneText() ~= "Ragnaros' Lair" or self.core:IsModuleActive(module.translatedName) then
		return
	end
	
	self.core:EnableModule(module.translatedName)
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
local function IsMe(guid)
	return guid and guid == UnitGUID("player")
end

function module:UnitDied(ev)
	local name = ev.destName
	if name == "Son of Flame" then
		addDead = addDead + 1
		if addDead <= 10 then
			self:Sync(syncName.addDead .. " " .. addDead)
		end
	elseif name and BigWigs:IsGroupMember(ev.destFlags) then
		-- remove Elemental Fire bar when a player dies
		self:ElementalFireFade(name)
		-- clear mark and variable if tank dies
		if name == knownTank then
			self:ClearKnownTank()
		end
	end
end

function module:LavaEvent(ev)
	if ev.environmentalType == "LAVA" and IsMe(ev.destGUID) and self.db.profile.lava then
		self:LavaYou()
	end
end

function module:MeltEvent(ev)
	if ev.sourceName == self.translatedName and IsMe(ev.destGUID) and ev.itemName and self.db.profile.melt then
		self:MeltWeapon(ev.itemName)
	end
end

function module:ElementalFireEvent(ev)
	if ev.destName then
		self:Sync(syncName.elementalFire .. " " .. ev.destName)
	end
end

function module:ElementalFireFadeEvent(ev)
	if ev.destName then
		self:Sync(syncName.elementalFireFade .. " " .. ev.destName)
	end
end

function module:WrathHitEvent(ev)
	if ev.destName and ev.destName == knownTank then
		self:Sync(syncName.tankWrathHit .. " " .. ev.destName)
	end
end

function module:WrathMissEvent(ev)
	if ev.missType == "RESIST" and ev.destName and ev.destName == knownTank then
		self:Sync(syncName.tankWrathResist .. " " .. ev.destName)
	end
end

-- whoever Ragnaros swings at (hit, crit, miss, dodge or parry) is the tank
function module:MeleeEvent(ev)
	if ev.sourceName == self.translatedName and ev.destName and ev.destName ~= knownTank then
		self:Sync(syncName.newTank .. " " .. ev.destName)
	end
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_domoStart1"] then
		self:DomoStart1()
	elseif msg == L["trigger_domoStart2"] then
		self:DomoStart2()
	elseif msg == L["trigger_domoStart3"] then
		self:DomoStart3()
	elseif msg == L["trigger_domoStart4"] then
		self:DomoStart4()
	elseif msg == L["trigger_domoStart5"] then
		self:DomoStart5()
	
	elseif msg == L["trigger_knockback"] then
		self:Sync(syncName.knockback)
	
	elseif msg == L["trigger_submerge"] or msg == L["trigger_submerge2"] then
		self:Sync(syncName.submerge)
	
	elseif string.find(msg, L["trigger_engage"]) then
		self:SendEngageSync()
		
			--old (bad) BigWigs will send bad engage syncs, this is the fix for it
		self:TrueEngage()
	end
end

function module:TrueEngage()
	if self.db.profile.wrathofragnaros then
		self:Bar(L["bar_knockbackCd"], timer.knockbackCd, icon.knockback, true, color.knockbackCd)
		self:DelayedBar(timer.knockbackCd, L["bar_knockbackSoon"], timer.knockbackSoon, icon.knockback, true, color.knockbackSoon)
		
		if not (UnitClass("Player") == "Mage" or UnitClass("Player") == "Priest" or UnitClass("Player") == "Warlock") then
			self:DelayedWarningSign(timer.knockbackCd - 3, icon.knockback, 10)
			self:DelayedMessage(timer.knockbackCd - 3, L["msg_knockbackSoon"], "Urgent", false, nil, false)
			self:DelayedSound(timer.knockbackCd - 3, "RunAway")
		end
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.knockback and self.db.profile.wrathofragnaros then
		self:Knockback()

	elseif sync == syncName.submerge then
		self:Submerge()
	elseif sync == syncName.emerge then
		self:Emerge()
	elseif sync == syncName.addDead and rest and self.db.profile.adds then
		self:AddDead(rest)

	elseif sync == syncName.elementalFire and rest then
		self:ElementalFire(rest)
	elseif sync == syncName.elementalFireFade and rest then
		self:ElementalFireFade(rest)

	elseif sync == syncName.newTank and rest then
		self:NewTank(rest)
	elseif sync == syncName.tankWrathHit and rest then
		self:TankKnockbackHit(rest)
	elseif sync == syncName.tankWrathResist and rest then
		self:TankKnockbackResist(rest)
	end
end


function module:DomoStart1()
	self:Bar(L["bar_domoStart"], timer.domoStart1, icon.domoStart, true, color.domoStart)
	self:Message(L["msg_domoStart"])
end

function module:DomoStart2()
	self:Bar(L["bar_domoStart"], timer.domoStart2, icon.domoStart, true, color.domoStart)
end

function module:DomoStart3()
	self:Bar(L["bar_domoStart"], timer.domoStart3, icon.domoStart, true, color.domoStart)
end

function module:DomoStart4()
	self:Bar(L["bar_domoStart"], timer.domoStart4, icon.domoStart, true, color.domoStart)
end

function module:DomoStart5()
	self:Bar(L["bar_domoStart"], timer.domoStart5, icon.domoStart, true, color.domoStart)
end


function module:Knockback()
	self:RemoveBar(L["bar_knockbackCd"])
	self:CancelDelayedBar(L["bar_knockbackSoon"])
	self:RemoveBar(L["bar_knockbackSoon"])
	self:CancelDelayedWarningSign(icon.knockback)
	self:RemoveWarningSign(icon.knockback)
	self:CancelDelayedMessage(L["msg_knockbackSoon"])
	self:CancelDelayedSound("RunAway")
	
	self:Message(L["msg_knockback"], "Important", false, nil, false)
	
	self:Bar(L["bar_knockbackCd"], timer.knockbackCd, icon.knockback, true, color.knockbackCd)
	self:DelayedBar(timer.knockbackCd, L["bar_knockbackSoon"], timer.knockbackSoon, icon.knockback, true, color.knockbackSoon)
	
	if not (UnitClass("Player") == "Mage" or UnitClass("Player") == "Priest" or UnitClass("Player") == "Warlock") then
		self:DelayedWarningSign(timer.knockbackCd - 3, icon.knockback, 12)
		self:DelayedMessage(timer.knockbackCd - 3, L["msg_knockbackSoon"], "Urgent", false, nil, false)
		self:DelayedSound(timer.knockbackCd - 3, "RunAway")
	end
	
	lastKnockTime = GetTime()
end

function module:Submerge()
	phase = "submerged"
	self:ClearKnownTank()

		--knockback stuff
	self:RemoveBar(L["bar_knockbackCd"])
	self:CancelDelayedBar(L["bar_knockbackSoon"])
	self:RemoveBar(L["bar_knockbackSoon"])
	self:CancelDelayedWarningSign(icon.knockback)
	self:RemoveWarningSign(icon.knockback)
	self:CancelDelayedMessage(L["msg_knockbackSoon"])
	self:CancelDelayedSound("RunAway")
	
	submergeTime = GetTime()

	if self.db.profile.emerge then
		self:Message(L["msg_submerge"], "Attention", false, nil, false)

		self:Bar(L["bar_nextEmerge"], timer.nextEmerge, icon.emerge, true, color.emerge)
		self:DelayedMessage(timer.nextEmerge - 10, L["msg_emergeSoon"], "Attention", false, nil, false)
	end
	
	self:ScheduleRepeatingEvent("CheckForEmerge", self.CheckForEmerge, 1, self)
end

function module:Emerge()	
	self:CancelScheduledEvent("CheckForEmerge")
	
	phase = "emerged"
	addDead = 0
	
	self:RemoveBar(L["bar_nextEmerge"])
	self:CancelDelayedMessage(L["msg_emergeSoon"])
	
	if self.db.profile.emerge then
		self:Message(L["msg_emerge"], "Attention", false, nil, false)
	end
	
	
	if self.db.profile.wrathofragnaros then
			--possibleTime - elapsedTime = timeLeft
		local knockbackTimeLeft = (timer.knockbackCd + timer.knockbackSoon) - (submergeTime - lastKnockTime)
		
			--if timeLeft is before warn, regular bars with remaining time
		if knockbackTimeLeft > timer.knockbackSoon + 3 then
			self:Bar(L["bar_knockbackCd"], knockbackTimeLeft - timer.knockbackSoon, icon.knockback, true, color.knockbackCd)
			self:DelayedBar(knockbackTimeLeft - timer.knockbackSoon, L["bar_knockbackSoon"], timer.knockbackSoon, icon.knockback, true, color.knockbackSoon)
			
			if not (UnitClass("Player") == "Mage" or UnitClass("Player") == "Priest" or UnitClass("Player") == "Warlock") then
				self:DelayedWarningSign(knockbackTimeLeft - timer.knockbackSoon - 3, icon.knockback, 12)
				self:DelayedMessage(knockbackTimeLeft - timer.knockbackSoon - 3, L["msg_knockbackSoon"], "Urgent", false, nil, false)
				self:DelayedSound(knockbackTimeLeft - timer.knockbackSoon - 3, "RunAway")
			end			
			
			--if timeLeft is 0, expect knockback right the hell now
		elseif knockbackTimeLeft <= 0 then
			if not (UnitClass("Player") == "Mage" or UnitClass("Player") == "Priest" or UnitClass("Player") == "Warlock") then
				self:WarningSign(icon.knockback, 12)
				self:Message(L["msg_knockbackSoon"], "Urgent", false, nil, false)
				self:Sound("RunAway")
			end			
			
			--if timeLeft is after warn, warn and only start bar soon
		else
			self:Bar(L["bar_knockbackSoon"], knockbackTimeLeft, icon.knockback, true, color.knockbackSoon)
			
			if not (UnitClass("Player") == "Mage" or UnitClass("Player") == "Priest" or UnitClass("Player") == "Warlock") then
				self:WarningSign(icon.knockback, knockbackTimeLeft + 1)
				self:Message(L["msg_knockbackSoon"], "Urgent", false, nil, false)
				self:Sound("RunAway")
			end
		end
	end
end

function module:CheckForEmerge()
	if UnitExists("Target") and UnitName("Target") == module.translatedName and UnitExists("TargetTarget") and UnitName("TargetTarget") ~= "Majordomo Executus" then
		self:Sync(syncName.emerge)
	else
		for i=1,GetNumRaidMembers() do
			if UnitExists("raid"..i.."Target") and UnitName("raid"..i.."Target") == module.translatedName and UnitExists("raid"..i.."TargetTarget") and UnitName("raid"..i.."TargetTarget") ~= "Majordomo Executus" then
				self:Sync(syncName.emerge)
				break
			end
		end
	end
end

function module:LavaYou()
	self:Message(L["msg_lavaYou"])
	self:WarningSign(icon.lava, 0.7)
	self:Sound("Info")
end

function module:AddDead(rest)
	self:Message(rest..L["msg_addDead"], "Positive", false, nil, false)
	
	if tonumber(rest) == 10 and phase == "submerged" then
		self:Sync(syncName.emerge)
	end
end

function module:MeltWeapon(rest)
	if melt1 == nil then
		self:TriggerEvent("BigWigs_StartCounterBar", self, L["bar_melt"]..rest, 50, "Interface\\Icons\\"..icon.melt, true, color.melt)
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..rest, (50 - 0.1))
		melt1 = rest
	elseif rest ~= melt1 and melt2 == nil then
		self:TriggerEvent("BigWigs_StartCounterBar", self, L["bar_melt"]..rest, 50, "Interface\\Icons\\"..icon.melt, true, color.melt)
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..rest, (50 - 0.1))
		melt2 = rest
	elseif rest ~= melt1 and rest ~= melt2 and melt3 == nil then
		self:TriggerEvent("BigWigs_StartCounterBar", self, L["bar_melt"]..rest, 50, "Interface\\Icons\\"..icon.melt, true, color.melt)
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..rest, (50 - 0.1))
		melt3 = rest
	end
		
	if rest == melt1 then
		meltCount1 = meltCount1 - 1
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..melt1, meltCount1)
	elseif rest == melt2 then
		meltCount2 = meltCount2 - 1
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..melt2, meltCount2)
	elseif rest == melt3 then
		meltCount3 = meltCount3 - 1
		self:TriggerEvent("BigWigs_SetCounterBar", self, L["bar_melt"]..melt3, meltCount3)
	end
end

function module:ElementalFire(player)
	if self.db.profile.elementalfire then
		self:Bar(string.format(L["bar_elementalFire"], player), timer.elementalFire, icon.elementalFire, true, color.elementalFire)
	end
end

function module:ElementalFireFade(player)
	self:RemoveBar(string.format(L["bar_elementalFire"], player))
end

function module:NewTank(newTank)
	-- sanity check in case remote player has a different knownTank
	if newTank == knownTank then return end

	if self.db.profile.tankalert then
		if newTank == UnitName("player") then
			-- infer whether player is a tank from fire resist
			local _, FR = UnitResistance("player",2)

			if FR < 200 then -- warn for aggro pull
				self:Message(L["msg_youTank"], "Important", true, "Beware")
			else -- player is tanking
				self:Message(L["msg_youTank"], "Positive", true, "Long")
			end
		else
			self:Message(string.format(L["msg_newTank"], newTank), "Attention", true, "Alarm")
		end
	end

	self:ClearKnownTank()
	knownTank = newTank

	if self.db.profile.tankmark then
		self:SetRaidTargetForPlayer(newTank, 8)
	end
end

function module:ClearKnownTank()
	if self.db.profile.tankmark and knownTank then
		self:RestorePreviousRaidTargetForPlayer(knownTank)
	end

	knownTank = nil
end

function module:TankKnockbackHit(player)
	-- sanity check in case remote player has a different knownTank
	if player ~= knownTank then return end

	if self.db.profile.tankwrathhit then
		self:Message(string.format(L["msg_tankWrathHit"], knownTank), "Urgent", true, "Beware")
	end

	self:ClearKnownTank()
end

function module:TankKnockbackResist(player)
	-- sanity check in case remote player has a different knownTank
	if player ~= knownTank then return end

	if self.db.profile.tankwrathresist then
		self:Message(string.format(L["msg_tankWrathResist"], knownTank), "Positive", true, "Long")
	end
end

function module:Test()
	-- Initialize module state
	self:Engage()

	local events = {
		-- Knockback test
		{ time = 2, func = function()
			local msg = L["trigger_knockback"]
			print("Test: Knockback - " .. msg)
			module:CHAT_MSG_MONSTER_YELL(msg)
		end },

		-- Lava test
		{ time = 5, func = function()
			print("Test: Lava")
			module:LavaEvent({ environmentalType = "LAVA", destGUID = UnitGUID("player") })
		end },

		-- Melt Weapon test
		{ time = 8, func = function()
			print("Test: Melt Weapon - Thunderfury")
			module:MeltEvent({ sourceName = module.translatedName, destGUID = UnitGUID("player"), itemName = "Thunderfury" })
		end },
		{ time = 9, func = function()
			print("Test: Melt Weapon (2nd hit) - Thunderfury")
			module:MeltEvent({ sourceName = module.translatedName, destGUID = UnitGUID("player"), itemName = "Thunderfury" })
		end },

		-- Second knockback
		{ time = 12, func = function()
			local msg = L["trigger_knockback"]
			print("Test: Knockback 2 - " .. msg)
			module:CHAT_MSG_MONSTER_YELL(msg)
		end },

		-- Submerge test
		{ time = 15, func = function()
			local msg = L["trigger_submerge"]
			print("Test: Submerge - " .. msg)
			module:CHAT_MSG_MONSTER_YELL(msg)
		end },

		-- Son of Flame deaths
		{ time = 18, func = function()
			print("Test: Son of Flame dies (1)")
			module:UnitDied({ destName = "Son of Flame" })
		end },
		{ time = 19, func = function()
			print("Test: Son of Flame dies (2)")
			module:UnitDied({ destName = "Son of Flame" })
		end },

		-- Emerge test (simulate via sync)
		{ time = 22, func = function()
			print("Test: Emerge (via sync)")
			module:Sync(syncName.emerge)
		end },

		-- Knockback after emerge
		{ time = 25, func = function()
			local msg = L["trigger_knockback"]
			print("Test: Knockback after emerge - " .. msg)
			module:CHAT_MSG_MONSTER_YELL(msg)
		end },

		-- End of Test
		{ time = 30, func = function()
			print("Test: Disengage")
			module:Disengage()
		end },
	}

	-- Schedule each event at its absolute time
	for i, event in ipairs(events) do
		self:ScheduleEvent("RagnarosTest" .. i, event.func, event.time)
	end

	self:Message("Ragnaros test started", "Positive")
	return true
end

-- Test command:
-- /run local m=BigWigs:GetModule("Ragnaros"); BigWigs:SetupModule("Ragnaros");m:Test();
