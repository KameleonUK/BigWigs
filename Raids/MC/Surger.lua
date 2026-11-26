
local module, L = BigWigs:ModuleDeclaration("Lava Surger", "Molten Core")

module.revision = 30073
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"surge"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Molten Core"],
	AceLibrary("Babble-Zone-2.2")["Molten Core"],
}
module.defaultDB = {
	bosskill = nil,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "LavaSurger",

	surge_cmd = "surge",
	surge_name = "Surge Alert",
	surge_desc = "Warn for Surge",
	
	
	msg_surge = " failed to stack on the Surger",
	msg_surgeYou = "S T A C K on the Surger",
} end )

local timer = {
}
local icon = {
	surge = "ability_warrior_charge",
}
local color = {
}
local syncName = {
	surge = "LavaSurgerSurge"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog("SPELL_DAMAGE", {19196, "Surge"}, "SurgeEvent")
	
	self:ThrottleSync(3, syncName.surge)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:SurgeEvent(ev)
	if ev.sourceName == self.translatedName and ev.destName then
		self:Sync(syncName.surge .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.surge and self.db.profile.surge then
		self:Surge(rest)
	end
end


function module:Surge(rest)
	if rest == UnitName("Player") then
		self:Message(L["msg_surgeYou"], "Personal", false, nil, false)
		self:Sound("Beware")
		self:WarningSign(icon.surge, 0.7)
	else
		self:Message(rest..L["msg_surge"], "Important", false, nil, false)
	end
end
