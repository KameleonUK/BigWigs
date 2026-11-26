
local module, L = BigWigs:ModuleDeclaration("Magmadar", "Molten Core")

module.revision = 30073
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"panic", "frenzy", "conflagration", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Magmadar",

	panic_cmd = "panic",
	panic_name = "Fear Alert",
	panic_desc = "Warn when Magmadar casts Panic",

	frenzy_cmd = "frenzy",
	frenzy_name = "Frenzy Alert",
	frenzy_desc = "Warn when Magmadar goes into a Frenzy",
	
	conflagration_cmd = "conflagration",
	conflagration_name = "Conflagration Alert",
	conflagration_desc = "Warn for Conflagration",
	
	
	bar_panicCd = "Fear CD",
	bar_panicSoon = "Fear Soon...",
	msg_panic = "Fear - Dispel!",
	
	bar_frenzyCd = "Frenzy CD",
	bar_frenzyDur = "Frenzy!",
	msg_frenzy = "Frenzy - Tranq now!",
	
} end)

local timer = {
	panicFirstCd = 10,
	panicCd = 30,
	panicSoon = 5,
	
	frenzyCd = {15,20},
	frenzyDur = 8,
}
local icon = {
	panic = "Spell_Shadow_DeathScream",
	berserkerRage = "spell_nature_ancestralguardian",
	tremor = "spell_nature_tremortotem",
	
	frenzy = "Ability_Druid_ChallangingRoar",
	tranquil = "Spell_Nature_Drowsy",
	
	fireProtPot = "inv_potion_24",
}
local color = {
	panicCd = "Cyan",
	panicSoon = "Blue",
	
	frenzyCd = "White",
	frenzyDur = "Red",
}
local syncName = {
	panic = "MagmadarPanic"..module.revision,
	frenzy = "MagmadarFrenzyStart"..module.revision,
	frenzyFade = "MagmadarFrenzyStop"..module.revision,
}

local frenzyStartTime = 0
local frenzyEndTime = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED", "SPELL_MISSED"}, {19408, "Panic"}, "PanicEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {19451, "Frenzy"}, "FrenzyEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {19451, "Frenzy"}, "FrenzyFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {19428, "Conflagration"}, "ConflagrationEvent")
	
	
	


	self:ThrottleSync(15, syncName.panic)
	self:ThrottleSync(5, syncName.frenzy)
	self:ThrottleSync(5, syncName.frenzyFade)
end

function module:OnSetup()
end

function module:OnEngage()
	frenzyStartTime = 0
	frenzyEndTime = 0
	
	if self.db.profile.panic then
		self:Bar(L["bar_panicCd"], timer.panicFirstCd, icon.panic, true, color.panicCd)
		
		if BigWigs:PlayerClass() == "WARRIOR" then
			self:WarningSign(icon.berserkerRage, 0.7)
		elseif BigWigs:PlayerClass() == "SHAMAN" then
			self:DelayedWarningSign(5, icon.tremor, 0.7)
		end
	end
	
	if self.db.profile.frenzy then
		self:IntervalBar(L["bar_frenzyCd"], timer.frenzyCd[1], timer.frenzyCd[2], icon.frenzy, true, color.frenzyCd)
	end
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:PanicEvent(ev)
	if ev.sourceName == self.translatedName or ev.subevent == "SPELL_AURA_APPLIED" then
		self:Sync(syncName.panic)
	end
end

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

function module:ConflagrationEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.conflagration then
		self:Conflagration()
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.panic and self.db.profile.panic then
		self:Panic()
	
	elseif sync == syncName.frenzy and self.db.profile.frenzy then
		self:Frenzy()
	elseif sync == syncName.frenzyFade and self.db.profile.frenzy then
		self:FrenzyFade()
	end
end


function module:Panic()
	self:RemoveBar(L["bar_panicCd"])
	self:CancelDelayedBar(L["bar_panicSoon"])
	self:RemoveBar(L["bar_panicSoon"])
	self:CancelDelayedWarningSign(icon.berserkerRage)
	self:RemoveWarningSign(icon.berserkerRage)
	self:CancelDelayedWarningSign(icon.tremor)
	self:RemoveWarningSign(icon.tremor)
	
	self:Bar(L["bar_panicCd"], timer.panicCd, icon.panic, true, color.panicCd)
	if BigWigs:PlayerClass() == "PRIEST" or  BigWigs:PlayerClass() == "PALADIN" then
		self:Message(L["msg_panic"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.panic, 0.7)
	end
	
	self:DelayedBar(timer.panicCd, L["bar_panicSoon"], timer.panicSoon, icon.panic, true, color.panicSoon)
	
	if BigWigs:PlayerClass() == "WARRIOR" then
		self:DelayedWarningSign(timer.panicCd + timer.panicSoon - 10, icon.berserkerRage, 0.7)
	elseif BigWigs:PlayerClass() == "SHAMAN" then
		self:DelayedWarningSign(timer.panicCd, icon.tremor, 0.7)
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

function module:Conflagration()
	self:WarningSign(icon.fireProtPot, 1)
end
