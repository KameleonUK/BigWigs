local module, L = BigWigs:ModuleDeclaration("Anubisath Guardian", "Ruins of Ahn'Qiraj")

module.revision = 30075
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = { "reflect", "plague", "icon", "thunderclap", "shadowstorm", "meteor", -1, "explode", "enrage" }
module.trashMod = true
module.defaultDB = {
	bosskill = false,
}

L:RegisterTranslations("enUS", function()
	return {
		cmd = "Guardian",

		reflect_cmd = "reflect",
		reflect_name = "Spell Reflect Alert",
		reflect_desc = "Shows bars for which reflect the Guardian has",

		plague_cmd = "plague",
		plague_name = "Plague Alert",
		plague_desc = "Warns for Plague",

		icon_cmd = "icon",
		icon_name = "Raid Icon for Plague",
		icon_desc = "Place Raid Icon on the last plagued person (requires promoted or higher)",

		thunderclap_cmd = "thunderclap",
		thunderclap_name = "Thunder Clap Alert",
		thunderclap_desc = "Warns for Thunder Clap",

		shadowstorm_cmd = "shadowstorm",
		shadowstorm_name = "Shadow Storm Alert",
		shadowstorm_desc = "Warns for Shadow Storm",

		meteor_cmd = "meteor",
		meteor_name = "Meteor Alert",
		meteor_desc = "Warns for Meteor",

		explode_cmd = "explode",
		explode_name = "Explode Alert",
		explode_desc = "Warns for Explode",

		enrage_cmd = "enrage",
		enrage_name = "Enrage Alert",
		enrage_desc = "Warns for Enrage",


		bar_fireArcaneReflect = "Fire & Arcane Reflect",

		bar_shadowFrostReflect = "Shadow & Frost Reflect",

		msg_selfReflect = "Spell Reflect - STOP KILLING YOURSELF!",

		bar_plague = " Plagued",
		msg_plague = "Plague on ",

		bar_thunderClap = "Thunder Clap CD",
		msg_thunderClap = "Thunder Clap - Ranged get Out!",

		bar_shadowStorm = "Shadow Storm CD",
		msg_shadowStorm = "Shadow Storm - Ranged get In!",

		bar_meteor = "Meteor CD",
		msg_meteor = "Meteor!",

		bar_explode = "Exploding!",
		msg_explode = "Exploding!",

		msg_enrage = "Enraged!",
	}
end)

L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Guardian",

    reflect_cmd = "reflect",
    reflect_name = "法术反射警报",
    reflect_desc = "显示守护者拥有的反射法术的计时条",

    plague_cmd = "plague",
    plague_name = "瘟疫警报",
    plague_desc = "瘟疫出现时进行警告",

    icon_cmd = "icon",
    icon_name = "瘟疫团队标记",
    icon_desc = "在最后一个被瘟疫感染的人身上放置团队标记（需要助理或更高权限）",

    thunderclap_cmd = "thunderclap",
    thunderclap_name = "雷霆一击警报",
    thunderclap_desc = "雷霆一击出现时进行警告",

    shadowstorm_cmd = "shadowstorm",
    shadowstorm_name = "暗影风暴警报",
    shadowstorm_desc = "暗影风暴出现时进行警告",

    meteor_cmd = "meteor",
    meteor_name = "流星警报",
    meteor_desc = "流星出现时进行警告",

    explode_cmd = "explode",
    explode_name = "爆炸警报",
    explode_desc = "爆炸出现时进行警告",

    enrage_cmd = "enrage",
    enrage_name = "激怒警报",
    enrage_desc = "激怒出现时进行警告",
	
	
    bar_fireArcaneReflect = "火焰 & 奥术反射",
	
    bar_shadowFrostReflect = "暗影 & 冰霜反射",
	
    msg_selfReflect = "法术反射 - 停止自残！",
	
    bar_plague = "瘟疫",
    msg_plague = "瘟疫在 ",
	
    bar_thunderClap = "雷霆一击",
    msg_thunderClap = "雷霆一击 - 远程远离！",

    bar_shadowStorm = "暗影风暴",
    msg_shadowStorm = "暗影风暴 - 远程靠近！",

    bar_meteor = "流星",
    msg_meteor = "流星！",
	
    bar_explode = "即将爆炸！",
    msg_explode = "即将爆炸！快跑！！！",

    msg_enrage = "狂暴！加大治疗！",
} end )
local timer = {
	--the timers for tClap, sStorm, meteor vary too much,
	--will just put 600 so bars tell people what abilities they have
	fireArcaneReflect = 600,
	shadowFrostReflect = 600,
	plague = 40,
	thunderClap = 600, --saw 3 and saw 8
	shadowStorm = 600,
	meteor = 600, --saw 6.4 and saw 13
	explode = 6,
}
local icon = {
	fireArcaneReflect = "spell_arcane_portaldarnassus",
	shadowFrostReflect = "spell_arcane_portalundercity",
	plague = "Spell_Shadow_CurseOfTounges",
	thunderClap = "Ability_ThunderClap",
	shadowStorm = "spell_shadow_shadowbolt",
	meteor = "Spell_Fire_Fireball02",
	explode = "spell_fire_selfdestruct",
	enrage = "spell_shadow_unholyfrenzy",
}
local color = {
	fireArcaneReflect = "Red",
	shadowFrostReflect = "Blue",
	plague = "Green",
	thunderClap = "Yellow",
	shadowStorm = "White",
	meteor = "Cyan",
	explode = "Black",
}
local syncName = {
	fireArcaneReflect = "GuardianArcaneReflect" .. module.revision,
	shadowFrostReflect = "GuardianShadowReflect" .. module.revision,
	plague = "GuardianPlague" .. module.revision,
	thunderClap = "GuardianThunderclap" .. module.revision,
	shadowStorm = "GuardianShadowstorm" .. module.revision,
	meteor = "GuardianMeteor" .. module.revision,
	explode = "GuardianExplode" .. module.revision,
	enrage = "GuardianEnrage" .. module.revision,
}

local fireArcaneReflectFound = nil
local shadowFrostReflectFound = nil
local thunderClapFound = nil
local shadowStormFound = nil
local meteorFound = nil

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --debug

	self:RegisterCombatLog("SPELL_MISSED", nil, "ReflectEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Detect Magic", "DetectMagicEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Plague", "PlagueEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_MISSED"}, "Thunderclap", "ThunderclapEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_MISSED"}, "Shadow Storm", "ShadowStormEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_MISSED"}, "Meteor", "MeteorEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Explode", "ExplodeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Enrage", "EnrageEvent")





	self:ThrottleSync(5, syncName.fireArcaneReflect)
	self:ThrottleSync(5, syncName.shadowFrostReflect)
	self:ThrottleSync(5, syncName.plague)
	self:ThrottleSync(5, syncName.thunderClap)
	self:ThrottleSync(5, syncName.shadowStorm)
	self:ThrottleSync(5, syncName.meteor)
	self:ThrottleSync(5, syncName.explode)
	self:ThrottleSync(5, syncName.enrage)
end

function module:OnSetup()
end

function module:OnEngage()
	fireArcaneReflectFound = nil
	shadowFrostReflectFound = nil
	thunderClapFound = nil
	shadowStormFound = nil
	meteorFound = nil

	--in case the bars are still there when pulling a new one
	self:RemoveBar(L["bar_fireArcaneReflect"])
	self:RemoveBar(L["bar_shadowFrostReflect"])
	self:RemoveBar(L["bar_shadowStorm"])
	self:RemoveBar(L["bar_thunderClap"])
	self:RemoveBar(L["bar_meteor"])
end

function module:OnDisengage()
	fireArcaneReflectFound = nil
	shadowFrostReflectFound = nil
	thunderClapFound = nil
	shadowStormFound = nil
	meteorFound = nil
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
-- a spell reflected by a Guardian shows which reflection it has
local fireArcane = { ["Moonfire"] = true, ["Scorch"] = true, ["Flame Shock"] = true, ["Fireball"] = true, ["Flame Lash"] = true, ["Detect Magic"] = true }
local shadowFrost = { ["Shadow Word: Pain"] = true, ["Corruption"] = true, ["Frostbolt"] = true, ["Frost Shock"] = true }

function module:ReflectEvent(ev)
	if ev.missType ~= "REFLECT" or ev.destName ~= self.translatedName then
		return
	end
	local spell = ev.spellName or ""
	if ev.sourceGUID and ev.sourceGUID == UnitGUID("player") and spell ~= "Elemental Vulnerability" and spell ~= "Fire Strike" then
		self:SelfReflect()
	end
	if fireArcane[spell] then
		self:Sync(syncName.fireArcaneReflect)
	elseif shadowFrost[spell] then
		self:Sync(syncName.shadowFrostReflect)
	end
end

-- Detect Magic landing (not reflected) means the shadow/frost reflection
function module:DetectMagicEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.shadowFrostReflect)
	end
end

function module:PlagueEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.plague .. " " .. ev.destName)
	end
end

function module:ThunderclapEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.thunderClap)
	end
end

function module:ShadowStormEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.shadowStorm)
	end
end

function module:MeteorEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.meteor)
	end
end

function module:ExplodeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.explode)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.fireArcaneReflect and self.db.profile.reflect then
		self:ArcaneReflect()
	elseif sync == syncName.shadowFrostReflect and self.db.profile.reflect then
		self:ShadowReflect()

	elseif sync == syncName.plague and rest and self.db.profile.plague then
		self:Plague(rest)

	elseif sync == syncName.thunderClap and self.db.profile.thunderclap then
		self:Thunderclap()
	elseif sync == syncName.shadowStorm and self.db.profile.shadowstorm then
		self:ShadowStorm()

	elseif sync == syncName.meteor and self.db.profile.meteor then
		self:Meteor()

	elseif sync == syncName.explode and self.db.profile.explode then
		self:Explode()
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	end
end

function module:ArcaneReflect()
	if fireArcaneReflectFound == nil then
		self:Bar(L["bar_fireArcaneReflect"], timer.fireArcaneReflect, icon.fireArcaneReflect, true, color.fireArcaneReflect)

		if BigWigs:PlayerClass() == "MAGE" or BigWigs:PlayerClass() == "WARLOCK" or BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "SHAMAN" then
			self:WarningSign(icon.fireArcaneReflect, 1)
		end

		self:RemoveBar(L["bar_shadowFrostReflect"])

		shadowFrostReflectFound = nil
		fireArcaneReflectFound = true
	end
end

function module:ShadowReflect()
	if shadowFrostReflectFound == nil then
		self:Bar(L["bar_shadowFrostReflect"], timer.shadowFrostReflect, icon.shadowFrostReflect, true, color.shadowFrostReflect)

		if BigWigs:PlayerClass() == "MAGE" or BigWigs:PlayerClass() == "WARLOCK" or BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "SHAMAN" then
			self:WarningSign(icon.shadowFrostReflect, 1)
		end

		self:RemoveBar(L["bar_fireArcaneReflect"])

		shadowFrostReflectFound = true
		fireArcaneReflectFound = nil
	end
end

function module:Plague(rest)
	self:Bar(rest .. L["bar_plague"], timer.plague, icon.plague, true, color.plague)
	self:Message(L["msg_plague"] .. rest, "Important", false, nil, false)

	if rest == UnitName("Player") then
		self:WarningSign(icon.plague, 1)
		SendChatMessage("Plague on " .. rest .. "!", "SAY")
		self:Sound("Plague")
	end

	if self.db.profile.icon and (IsRaidLeader() or IsRaidOfficer()) then
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid" .. i) == rest then
				SetRaidTarget("raid" .. i, 8)
			end
		end
	end

	meteorFound = nil
end

function module:Thunderclap()
	if thunderClapFound == nil then
		self:Bar(L["bar_thunderClap"], timer.thunderClap, icon.thunderClap, true, color.thunderClap)
		self:Message(L["msg_thunderClap"], "Urgent", false, nil, false)
		self:WarningSign(icon.thunderClap, 1)
		self:Sound("Beware")
	end

	self:RemoveBar(L["bar_shadowStorm"])

	thunderClapFound = true
	shadowStormFound = nil
end

function module:ShadowStorm()
	if shadowStormFound == nil then
		self:Bar(L["bar_shadowStorm"], timer.shadowStorm, icon.shadowStorm, true, color.shadowStorm)
		self:Message(L["msg_shadowStorm"], "Attention", false, nil, false)
		self:WarningSign(icon.shadowStorm, 1)
		self:Sound("Beware")
	end

	self:RemoveBar(L["bar_thunderClap"])

	thunderClapFound = nil
	shadowStormFound = true
end

function module:Meteor()
	if meteorFound == nil then
		self:Bar(L["bar_meteor"], timer.meteor, icon.meteor, true, color.meteor)
		self:Message(L["msg_meteor"], "Important", false, nil, false)
		self:WarningSign(icon.meteor, 1)
	end

	meteorFound = true
end

function module:Explode()
	self:Bar(L["bar_explode"], timer.explode, icon.explode, true, color.explode)
	self:Message(L["msg_explode"], "Urgent", false, nil, false)
	self:WarningSign(icon.explode, timer.explode)
	self:Sound("RunAway")
end

function module:Enrage()
	self:Message(L["msg_enrage"], "Important", false, nil, false)
	self:WarningSign(icon.enrage, 1)
end

function module:SelfReflect()
	self:Message(L["msg_selfReflect"], "Personal", false, nil, false)
	self:Sound("Info")
end
