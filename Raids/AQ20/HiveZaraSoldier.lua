
local module, L = BigWigs:ModuleDeclaration("Hive'Zara Soldier", "Ruins of Ahn'Qiraj")

module.revision = 30040
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"retaliationgain" , "retaliationhityou"}
module.trashMod = true

L:RegisterTranslations("enUS", function() return {
	cmd = "HiveZaraSoldier",

	retaliationgain_cmd = "retaliationgain",
	retaliationgain_name = "Retaliation Gain Alert",
	retaliationgain_desc = "Warn for Retaliation Gain",
	
	retaliationhityou_cmd = "retaliationhityou",
	retaliationhityou_name = "Retaliation Hit You Alert",
	retaliationhityou_desc = "Warn for Retaliation Hit You",
	
	msg_retaliationGain = "Hive'Zara Soldier gains Retaliation!",
	
	msg_retaliationHitYou = "STOP KILLING YOURSELF!",
	
	["You have slain %s!"] = true,
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "HiveZaraSoldier",

	retaliationgain_cmd = "retaliationgain",
	retaliationgain_name = "反击风暴获得警报",
	retaliationgain_desc = "警告获得反击风暴",
	
	retaliationhityou_cmd = "retaliationhityou",
	retaliationhityou_name = "反击风暴警报",
	retaliationhityou_desc = "警报反击风暴对你的攻击",
	
	msg_retaliationGain = "佐拉士兵获得了反击风暴！",
	
	msg_retaliationHitYou = "请停止自残！",
	
	["You have slain %s!"] = "你已击败%s！",
} end )
local timer = {
}
local icon = {
	retaliation = "ability_warrior_challange",
}
local color = {
}
local syncName = {
	retaliationGain = "HiveZaraSoldierRetaliationGain"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Retaliation", "RetaliationEvent")
	self:RegisterCombatLog("SPELL_DAMAGE", "Retaliation", "RetaliationHitEvent")
	
	self:ThrottleSync(2, syncName.retaliationGain)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:RetaliationEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.retaliationGain)
	end
end

function module:RetaliationHitEvent(ev)
	if ev.sourceName == self.translatedName and ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.retaliationhityou then
		self:HitYou()
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.retaliationGain and self.db.profile.retaliationgain then
		self:RetaliationGain()
	end
end


function module:RetaliationGain()
	self:Message(L["msg_retaliationGain"], "Attention", false, nil, false)
end

function module:HitYou()
	self:Message(L["msg_retaliationHitYou"], "Personal", false, nil, false)
	self:WarningSign(icon.retaliation, 0.7)
	self:Sound("Info")
end
