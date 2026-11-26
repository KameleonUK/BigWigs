
local module, L = BigWigs:ModuleDeclaration("Garr", "Molten Core")

module.revision = 30078
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"pulse", "remove", "adds", "immolate", "bosskill"}
module.wipemobs = {"Firesworn"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Garr",
	
	pulse_cmd = "pulse",
	pulse_name = "Antimagic Pulse Alert",
	pulse_desc = "Warn for Antimagic Pulse",
	
	remove_cmd = "remove",
	remove_name = "Removed Buff Alert",
	remove_desc = "Warn for Removed Buff",
	
	adds_cmd = "adds",
	adds_name = "Add Dies Alert",
	adds_desc = "Warn for Adds Deaths",
	
	immolate_cmd = "immolate",
	immolate_name = "Immolate Alert",
	immolate_desc = "Warn for Immolate",
	
	
	bar_antimagicPulse = "Antimagic Pulse",
	
	msg_remove = "Antimagic Pulse Removed your ",
	
	msg_addDead = "/8 Firesworn Dead",
	
	--not tracking the afflicted since many mobs do immolate, may cause conflict
		--instead only showing the message once to remind dispels on Garr
	msg_immolate = "Immolate - Dispel!",
} end)

local timer = {
	antimagicPulseFirst = 15,
	antimagicPulse = 20,
}
local icon = {
	antimagicPulse = "spell_holy_dispelmagic",
	immolate = "spell_fire_immolation",
}
local color = {
	antimagicPulse = "White",
}
local syncName = {
	antimagicPulse = "GarrAntimagicPulse"..module.revision,
	addDead = "GarrAddDead"..module.revision,
	immolate = "GarrImmolate"..module.revision,
}

local addDead = 0
local fightningGarr = nil


function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog("SPELL_CAST_SUCCESS", {19492, "Antimagic Pulse"}, "PulseEvent")
	self:RegisterCombatLog("SPELL_DISPEL", {19492, "Antimagic Pulse"}, "RemoveEvent")
	self:RegisterCombatLog({"SPELL_PERIODIC_DAMAGE", "SPELL_AURA_APPLIED"}, {15733, "Immolate"}, "ImmolateEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
	
	
	
	self:ThrottleSync(5, syncName.antimagicPulse)
	self:ThrottleSync(0.5, syncName.addDead)
	self:ThrottleSync(60, syncName.immolate)
end

function module:OnSetup()
	self.started = nil

end

function module:OnEngage()
	addDead = 0
	fightningGarr = true
	
	if self.db.profile.pulse then
		self:Bar(L["bar_antimagicPulse"], timer.antimagicPulseFirst, icon.antimagicPulse, true, color.antimagicPulse)
	end
end

function module:OnDisengage()
	fightningGarr = false
end

-- UNIT_DIED: the Firesworn counter (Garr's own death comes from the core)
function module:UnitDied(ev)
	if ev.destName == "Firesworn" then
		addDead = addDead + 1
		if addDead <= 8 then
			self:Sync(syncName.addDead .. " " .. addDead)
		end
	elseif ev.destName == self.translatedName then
		fightningGarr = false
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:PulseEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.antimagicPulse)
	end
end

-- a buff of yours removed by the pulse
function module:RemoveEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and fightningGarr == true and self.db.profile.remove then
		if ev.extraSpellName and ev.extraSpellName ~= "Immolate" then
			self:Remove(ev.extraSpellName)
		end
	end
end

function module:ImmolateEvent(ev)
	if ev.sourceName == "Firesworn" then
		self:Sync(syncName.immolate)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.antimagicPulse and self.db.profile.pulse then
		self:AntimagicPulse()
		
	elseif sync == syncName.addDead and rest and self.db.profile.adds then
		self:AddDead(rest)
		
	elseif sync == syncName.immolate and self.db.profile.immolate then
		self:Immolate()
	end
end


function module:AntimagicPulse()
	self:Bar(L["bar_antimagicPulse"], timer.antimagicPulse, icon.antimagicPulse, true, color.antimagicPulse)
end

function module:Remove(rest)
	self:Message(L["msg_remove"]..rest, "Attention", false, nil, false)
end

function module:AddDead(rest)
	self:Message(rest..L["msg_addDead"], "Positive", false, nil, false)
end

function module:Immolate()
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "PALADIN" then
		self:Message(L["msg_immolate"], "Urgent", false, nil, false)
		self:WarningSign(icon.immolate, 1)
	end
end
