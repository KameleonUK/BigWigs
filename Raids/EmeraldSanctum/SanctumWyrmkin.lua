
local module, L = BigWigs:ModuleDeclaration("Sanctum Wyrmkin", "Emerald Sanctum")

module.revision = 30020
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"wyrmkinsvenom"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Emerald Sanctum"],
	AceLibrary("Babble-Zone-2.2")["Emerald Sanctum"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "SanctumWyrmkin",

	wyrmkinsvenom_cmd = "wyrmkinsvenom",
	wyrmkinsvenom_name = "Wyrmkins Venom Alert",
	wyrmkinsvenom_desc = "Warn for Wyrmkins Venom",

	
	bar_wyrmkinsVenom = " Venom",
	
	["You have slain %s!"] = true,
	
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "SanctumWyrmkin",

    wyrmkinsvenom_cmd = "wyrmkinsvenom",
    wyrmkinsvenom_name = "龙族毒液警报",
    wyrmkinsvenom_desc = "龙族毒液出现时进行警告",

    
    bar_wyrmkinsVenom = " 中了毒液（驱毒）！！！",
    
    ["You have slain %s!"] = "你已击败了%s！",
    you = "你",
} end )
local timer = {
	wyrmkinsVenom = 30,--tbd
}
local icon = {
	wyrmkinsVenom = "Ability_Creature_Poison_03",
}
local color = {
	wyrmkinsVenom = "Green",
}
local syncName = {
	wyrmkinsVenomOn = "SanctumWyrmkinWyrmkinsVenomOn"..module.revision,
	wyrmkinsVenomOff = "SanctumWyrmkinWyrmkinsVenomOff"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {56503, "Wyrmkins Venom"}, "VenomEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {56503, "Wyrmkins Venom"}, "VenomFadeEvent")
	
	
	
	self:ThrottleSync(0, syncName.wyrmkinsVenomOn)
	self:ThrottleSync(0, syncName.wyrmkinsVenomOff)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:VenomEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.wyrmkinsVenomOn .. " " .. ev.destName)
	end
end

function module:VenomFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.wyrmkinsVenomOff .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.wyrmkinsVenomOn and rest and self.db.profile.wyrmkinsvenom then
		self:WyrmkinsVenomOn(rest)
	elseif sync == syncName.wyrmkinsVenomOff and rest and self.db.profile.wyrmkinsvenom then
		self:WyrmkinsVenomOff(rest)
	end
end


function module:WyrmkinsVenomOn(rest)
	self:Bar(rest..L["bar_wyrmkinsVenom"], timer.wyrmkinsVenom, icon.wyrmkinsVenom, true, color.wyrmkinsVenom)
end

function module:WyrmkinsVenomOff(rest)
	self:RemoveBar(rest..L["bar_wyrmkinsVenom"])
end
