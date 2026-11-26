
local module, L = BigWigs:ModuleDeclaration("Sanctum Dreamer", "Emerald Sanctum")

module.revision = 30020
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"dreamstate"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Emerald Sanctum"],
	AceLibrary("Babble-Zone-2.2")["Emerald Sanctum"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "SanctumDreamer",

	dreamstate_cmd = "dreamstate",
	dreamstate_name = "Dreamstate Alert",
	dreamstate_desc = "Warn for Dreamstate",

	
	--bar_dreamstate = " is Sleeping",
	bar_dreamstate = "People Sleeping",
	
	["You have slain %s!"] = true,
	
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "SanctumDreamer",

    dreamstate_cmd = "dreamstate",
    dreamstate_name = "梦境状态警报",
    dreamstate_desc = "梦境状态出现时进行警告",

    
    --bar_dreamstate = " is Sleeping",
    bar_dreamstate = "治疗沉睡队友！",
    
    ["You have slain %s!"] = "你已击败了%s！",
    you = "你",
} end )
local timer = {
	dreamstate = 10,
}
local icon = {
	dreamstate = "Spell_Nature_Sleep",
}
local color = {
	dreamstate = "White",
}
local syncName = {
	sleepOn = "SanctumDreamerDreamstateOn"..module.revision,
	--sleepOff = "SanctumDreamerDreamstateOff"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {56500, "Dreamstate"}, "SleepEvent")
	
	
	
	
	
	self:ThrottleSync(3, syncName.sleepOn)
	--self:ThrottleSync(0, syncName.sleepOff)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:SleepEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.sleepOn .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.sleepOn and rest and self.db.profile.dreamstate then
		self:SleepOn(rest)
	--elseif sync == syncName.sleepOff and rest and self.db.profile.dreamstate then
	--	self:SleepOff(rest)
	end
end


function module:SleepOn(rest)
	self:Bar(L["bar_dreamstate"], timer.dreamstate, icon.dreamstate, true, color.dreamstate)
	--self:Bar(rest..L["bar_dreamstate"], timer.dreamstate, icon.dreamstate, true, color.dreamstate)
end

function module:SleepOff(rest)
	self:RemoveBar(L["bar_dreamstate"])
	--self:RemoveBar(rest..L["bar_dreamstate"])
end
