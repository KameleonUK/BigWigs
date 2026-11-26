
local module, L = BigWigs:ModuleDeclaration("Sanctum Supressor", "Emerald Sanctum")

module.revision = 30020
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"emeraldsupression"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Emerald Sanctum"],
	AceLibrary("Babble-Zone-2.2")["Emerald Sanctum"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "SanctumSupressor",

	emeraldsupression_cmd = "emeraldsupression",
	emeraldsupression_name = "Emerald Supression Alert",
	emeraldsupression_desc = "Warn for Emerald Supression",
	
	
	bar_emeraldSupression = " Supression",
	
	["You have slain %s!"] = true,
	
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "SanctumSupressor",

    emeraldsupression_cmd = "emeraldsupression",
    emeraldsupression_name = "翡翠镇压警报",
    emeraldsupression_desc = "翡翠镇压出现时进行警告",
    
    
    bar_emeraldSupression = " 被镇压（驱散魔法）！！",
    
    ["You have slain %s!"] = "你已击败了%s！",
    you = "你",
} end )
local timer = {
	emeraldSupression = 12,
}
local icon = {
	emeraldSupression = "Spell_Nature_MagicImmunity",
}
local color = {
	emeraldSupression = "Red",
}
local syncName = {
	emeraldSupressionOn = "SanctumSupressorSupressionOn"..module.revision,
	emeraldSupressionOff = "SanctumSupressorSupressionOff"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {56501, "Emerald Supression"}, "SupressionEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {56501, "Emerald Supression"}, "SupressionFadeEvent")
	
	
	
	self:ThrottleSync(0, syncName.emeraldSupressionOn)
	self:ThrottleSync(0, syncName.emeraldSupressionOff)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:SupressionEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.emeraldSupressionOn .. " " .. ev.destName)
	end
end

function module:SupressionFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.emeraldSupressionOff .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.emeraldSupressionOn and rest and self.db.profile.emeraldsupression then
		self:EmeraldSupressionOn(rest)
	elseif sync == syncName.emeraldSupressionOff and rest and self.db.profile.emeraldsupression then
		self:EmeraldSupressionOff(rest)
	end
end


function module:EmeraldSupressionOn(rest)
	self:Bar(rest..L["bar_emeraldSupression"], timer.emeraldSupression, icon.emeraldSupression, true, color.emeraldSupression)
end

function module:EmeraldSupressionOff(rest)
	self:RemoveBar(rest..L["bar_emeraldSupression"])
end
