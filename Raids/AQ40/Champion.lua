
local module, L = BigWigs:ModuleDeclaration("Qiraji Champion", "Ahn'Qiraj")

module.revision = 30067
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"fear"}
module.trashMod = true
module.defaultDB = {
	bosskill = false,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Champion",

	fear_cmd = "fear",
	fear_name = "Intimidating Shout Alert",
	fear_desc = "Warn for Intimidating Shout",
	
	
	bar_fear = "Intimidating Shout CD",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Champion",

    fear_cmd = "fear",
    fear_name = "破胆怒吼警报",
    fear_desc = "破胆怒吼出现时进行警告",


    bar_fear = "破胆怒吼 CD",
} end )
local timer = {
	fearCd = {19,40},--saw 19, saw 40
}
local icon = {
	fear = "ability_golemthunderclap",
}
local color = {
	fear = "Blue",
}
local syncName = {
	fear = "QirajiChampionFear"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog({"SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Intimidating Shout", "FearEvent")
	
	
	
	
	self:ThrottleSync(15, syncName.fear)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:FearEvent(ev)
	if ev.sourceName == self.translatedName or (ev.subevent == "SPELL_AURA_APPLIED" and BigWigs:IsGroupMember(ev.destFlags)) then
		self:Sync(syncName.fear)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.fear and self.db.profile.fear then
		self:Fear()
	end
end

function module:Fear()
	self:IntervalBar(L["bar_fear"], timer.fearCd[1], timer.fearCd[2], icon.fear, true, color.fear)
end
