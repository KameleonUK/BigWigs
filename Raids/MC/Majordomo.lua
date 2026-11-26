local module, L = BigWigs:ModuleDeclaration("Majordomo Executus", "Molten Core")

module.revision = 30075
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = { "magicreflect", "physicalreflect", "adds", "firepit", "bosskill" }
module.wipemobs = { "Flamewaker Elite", "Flamewaker Healer" }

L:RegisterTranslations("enUS", function()
	return {
		cmd = "Majordomo",

		magicreflect_cmd = "magicreflect",
		magicreflect_name = "Magic Reflection Alert",
		magicreflect_desc = "Warn for Magic Reflection",

		physicalreflect_cmd = "physicalreflect",
		physicalreflect_name = "Physical Reflection Alert",
		physicalreflect_desc = "Warn for Physical Reflection",

		adds_cmd = "adds",
		adds_name = "Add Dies Alert",
		adds_desc = "Warn for Adds Deaths",

		firepit_cmd = "firepit",
		firepit_name = "Fire Damage from Fire Pit Alert",
		firepit_desc = "Warn for Fire Damage from Fire Pit",


		trigger_engage = "Reckless mortals, none may challenge the sons of the living flame!", --CHAT_MSG_MONSTER_YELL

		--is MUCH longer than that
		trigger_bossDeath = "Impossible! Stay your attack, mortals... I submit! I submit!", --CHAT_MSG_MONSTER_YELL

		bar_reflectCd = "Reflection CD",

		bar_magicReflect = "Magic Reflection",
		msg_magicReflect = "Magic Reflection - Stop Casting!",

		bar_physicalReflect = "Physical Reflection",
		msg_physicalReflect = "Physical Reflection - Stop Attacking!",

		msg_eliteDead = "/4 Flamewaker Elite Dead",
		msg_healerDead = "/4 Flamewaker Healer Dead",

	}
end)

local timer = {
	reflectFirstCd = 30, --saw 29.816
	reflectCd = 20, --saw 20
	reflectDur = 10, --saw 10
}
local icon = {
	noReflect = "Spell_Shadow_DetectLesserInvisibility",
	magicReflect = "Spell_Frost_FrostShock",
	physicalReflect = "Spell_Shadow_AntiShadow",
	firePit = "spell_fire_lavaspawn"
}
local color = {
	noReflect = "Black",
	magicReflect = "Blue",
	physicalReflect = "Red",
}
local syncName = {
	physicalReflect = "DomoAuraDamage" .. module.revision,
	physicalReflectFade = "DomoAuraDamageFade" .. module.revision,

	magicReflect = "DomoAuraMagic" .. module.revision,
	magicReflectFade = "DomoAuraMagicFade" .. module.revision,

	eliteDead = "DomoEliteDead" .. module.revision,
	healerDead = "DomoHealerDead" .. module.revision,
}

local eliteDead = 0
local healerDead = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") --trigger_engage, trigger_bossDeath

	self:RegisterCombatLog("SPELL_AURA_APPLIED", {20619, "Magic Reflection"}, "MagicReflectEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {20619, "Magic Reflection"}, "MagicReflectFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {21075, "Damage Shield"}, "PhysicalReflectEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {21075, "Damage Shield"}, "PhysicalReflectFadeEvent")
	self:RegisterCombatLog("ENVIRONMENTAL_DAMAGE", nil, "FirePitEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")




	self:ThrottleSync(2, syncName.physicalReflect)
	self:ThrottleSync(2, syncName.physicalReflectFade)

	self:ThrottleSync(2, syncName.magicReflect)
	self:ThrottleSync(2, syncName.magicReflectFade)

	self:ThrottleSync(0.5, syncName.eliteDead)
	self:ThrottleSync(0.5, syncName.healerDead)
end

function module:OnSetup()
	self.started = nil

end

function module:OnEngage()
	eliteDead = 0
	healerDead = 0

	if self.db.profile.magicreflect or self.db.profile.physicalreflect then
		self:Bar(L["bar_reflectCd"], timer.reflectFirstCd, icon.noReflect, true, color.noReflect)
	end
end

function module:OnDisengage()
end

-- UNIT_DIED: the Flamewaker counters
function module:UnitDied(ev)
	if ev.destName == "Flamewaker Elite" then
		eliteDead = eliteDead + 1
		if eliteDead <= 4 then
			self:Sync(syncName.eliteDead .. " " .. eliteDead)
		end
	elseif ev.destName == "Flamewaker Healer" then
		healerDead = healerDead + 1
		if healerDead <= 4 then
			self:Sync(syncName.healerDead .. " " .. healerDead)
		end
	end
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	elseif string.find(msg, L["trigger_bossDeath"]) then
		self:SendBossDeathSync()
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
-- the reflection shields go up on the Flamewakers, not Majordomo, so any unit counts
function module:MagicReflectEvent(ev)
	self:Sync(syncName.magicReflect)
end

function module:MagicReflectFadeEvent(ev)
	self:Sync(syncName.magicReflectFade)
end

function module:PhysicalReflectEvent(ev)
	self:Sync(syncName.physicalReflect)
end

function module:PhysicalReflectFadeEvent(ev)
	self:Sync(syncName.physicalReflectFade)
end

-- standing in a fire pit: environmental fire damage on you
function module:FirePitEvent(ev)
	if ev.environmentalType == "FIRE" and ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.firepit then
		self:FirePit()
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.magicReflect and self.db.profile.magicreflect then
		self:MagicReflect()
	elseif sync == syncName.magicReflectFade and (self.db.profile.magicreflect or self.db.profile.physicalreflect) then
		self:MagicReflectFade()

	elseif sync == syncName.physicalReflect and self.db.profile.physicalreflect then
		self:PhysicalReflect()
	elseif sync == syncName.physicalReflectFade and (self.db.profile.magicreflect or self.db.profile.physicalreflect) then
		self:PhysicalReflectFade()

	elseif sync == syncName.eliteDead and rest and self.db.profile.adds then
		self:EliteDead(rest)
	elseif sync == syncName.healerDead and rest and self.db.profile.adds then
		self:HealerDead(rest)
	end
end

function module:MagicReflect()
	self:RemoveBar(L["bar_reflectCd"])

	self:Bar(L["bar_magicReflect"], timer.reflectDur, icon.magicReflect, true, color.magicReflect)

	if not (BigWigs:PlayerClass() == "WARRIOR" or BigWigs:PlayerClass() == "ROGUE" or BigWigs:PlayerClass() == "HUNTER") then
		self:Message(L["msg_magicReflect"], "Attention", false, nil, false)
		self:Sound("Beware")
		self:WarningSign(icon.magicReflect, 1)
	end
end

function module:MagicReflectFade()
	self:RemoveBar(L["bar_magicReflect"])
	self:Bar(L["bar_reflectCd"], timer.reflectCd, icon.noReflect, true, color.noReflect)
end

function module:PhysicalReflect()
	self:RemoveBar(L["bar_reflectCd"])

	self:Bar(L["bar_physicalReflect"], timer.reflectDur, icon.physicalReflect, true, color.physicalReflect)

	if not (BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "MAGE" or BigWigs:PlayerClass() == "WARLOCK") then
		self:Message(L["msg_physicalReflect"], "Attention", false, nil, false)
		self:Sound("Beware")
		self:WarningSign(icon.physicalReflect, 1)
	end
end

function module:PhysicalReflectFade()
	self:RemoveBar(L["bar_physicalReflect"])
	self:Bar(L["bar_reflectCd"], timer.reflectCd, icon.noReflect, true, color.noReflect)
end

function module:EliteDead(rest)
	self:Message(rest .. L["msg_eliteDead"], "Positive", false, nil, false)
end

function module:HealerDead(rest)
	self:Message(rest .. L["msg_healerDead"], "Positive", false, nil, false)
end

function module:FirePit()
	self:WarningSign(icon.firePit, 0.7)
	self:Sound("Info")
end
