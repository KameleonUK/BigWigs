
local module, L = BigWigs:ModuleDeclaration("Dark Rider Champion", "Karazhan")

module.revision = 30026
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"reaverstorm"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "darkriderchampion",

	reaverstorm_cmd = "reaverstorm",
	reaverstorm_name = "Reaver Storm Alert",
	reaverstorm_desc = "Warn for Reaver Storm",


	bar_reaverstormCd = "Reaver Storm CD",
	bar_reaverstormCast = "Reaver Storm Cast",

	["You have slain %s!"] = true,
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "darkriderchampion",

    reaverstorm_cmd = "reaverstorm",
    reaverstorm_name = "掠夺者风暴警报",
    reaverstorm_desc = "掠夺者风暴施放时进行警告",


    bar_reaverstormCd = "掠夺者风暴冷却",
    bar_reaverstormCast = "掠夺者风暴施放",

    ["You have slain %s!"] = "你杀死了%s！",
} end )
local timer = {
	reaverstormCd = 5.5,
	reaverstormCast = 1.5,
}
local icon = {
	reaverstorm = "Ability_Whirlwind",
}
local color = {
	reaverstormCd = "White",
	reaverstormCast = "Red",
}
local syncName = {
	reaverstorm = "DarkRiderChampionReaverstorm"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_CAST_START", "Reaver Storm", "ReaverStormEvent")
	
	self:ThrottleSync(5, syncName.reaverstorm)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:ReaverStormEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.reaverstorm)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.reaverstorm and self.db.profile.reaverstorm then
		self:Reaverstorm()
	end
end


function module:Reaverstorm()
	self:RemoveBar(L["bar_reaverstormCd"])
	self:Bar(L["bar_reaverstormCast"], timer.reaverstormCast, icon.reaverstorm, true, color.reaverstormCast)
	self:DelayedBar(timer.reaverstormCast, L["bar_reaverstormCd"], timer.reaverstormCd, icon.reaverstorm, true, color.reaverstormCd)
end
