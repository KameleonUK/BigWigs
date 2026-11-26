
local module, L = BigWigs:ModuleDeclaration("Gurubashi Berserker", "Zul'Gurub")

module.revision = 30041
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"fear", "knock", "thunderclap"}
module.trashMod = true
module.defaultDB = {
	bosskill = nil,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Berserker",
	
	fear_cmd = "fear",
	fear_name = "Fear Alert",
	fear_desc = "Warn for Fear",
	
	knock_cmd = "knock",
	knock_name = "Knock Away Alert",
	knock_desc = "Warn for Knock Away",
	
	thunderclap_cmd = "thunderclap",
	thunderclap_name = "Thunderclap Alert",
	thunderclap_desc = "Warn for Thunderclap",
	
	
	
	bar_fear = "Fear CD",
	
	bar_knockAway = "KnockAway CD",
	
	bar_thunderclap = "Thunderclap CD",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "Berserker",
	
	fear_cmd = "fear",
	fear_name = "恐惧警报",
	fear_desc = "恐惧出现时进行警告",
	
	knock_cmd = "knock",
	knock_name = "击退警报",
	knock_desc = "击退出现时进行警告",
	
	thunderclap_cmd = "thunderclap",
	thunderclap_name = "雷霆一击警报",
	thunderclap_desc = "雷霆一击出现时进行警告",
	
	
	
	bar_fear = "恐惧 CD",
	
	bar_knockAway = "击退 CD",
	
	bar_thunderclap = "雷霆一击 CD",
} end )
local timer = {
	firstFear = 15,--ok
	fear = 25,--ok
	
	firstKnock = 10,--ok
	knockAway = 10,--ok
	
	firstThunderclap = 5,--ok
	thunderclap = 15,--ok
}
local icon = {
	fear = "Ability_GolemThunderClap",
	knockAway = "INV_Gauntlets_05",
	thunderclap = "Ability_ThunderClap",
}
local color = {
	fear = "White",
	knockAway = "Red",
	thunderclap = "Blue",
}
local syncName = {
	fear = "BerserkerDebuff"..module.revision,
	knockAway = "BerserkerKnockBack"..module.revision,
	thunderclap = "BerserkerThunderclap"..module.revision,
}


function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Intimidating Roar", "FearEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Knock Away", "KnockAwayEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Thunderclap", "ThunderclapEvent")


	self:ThrottleSync(2, syncName.fear)
	self:ThrottleSync(2, syncName.knockAway)
	self:ThrottleSync(2, syncName.thunderclap)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.fear then
		self:Bar(L["bar_fear"], timer.firstFear, icon.fear, true, color.fear)
	end
	if self.db.profile.knock then
		self:Bar(L["bar_knockAway"], timer.firstKnock, icon.knockAway, true, color.knockAway)
	end
	if self.db.profile.thunderclap then
		self:Bar(L["bar_thunderclap"], timer.firstThunderclap, icon.thunderclap, true, color.thunderclap)
	end
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:FearEvent(ev)
	if ev.sourceName == self.translatedName or (ev.subevent == "SPELL_AURA_APPLIED" and not ev.sourceName) then
		self:Sync(syncName.fear)
	end
end

function module:KnockAwayEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.knockAway)
	end
end

function module:ThunderclapEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.thunderclap)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.fear and self.db.profile.fear then
		self:Fear()
	elseif sync == syncName.knockAway and self.db.profile.knock then
		self:KnockAway()
	elseif sync == syncName.thunderclap and self.db.profile.thunderclap then
		self:Thunderclap()
	end
end

function module:Fear()
	self:Bar(L["bar_fear"], timer.fear, icon.fear, true, color.fear)
end

function module:KnockAway()
	self:Bar(L["bar_knockAway"], timer.knockAway, icon.knockAway, true, color.knockAway)
end

function module:Thunderclap()
	self:Bar(L["bar_thunderclap"], timer.thunderclap, icon.thunderclap, true, color.thunderclap)
end
