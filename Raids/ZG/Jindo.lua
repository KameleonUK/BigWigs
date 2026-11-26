local module, L = BigWigs:ModuleDeclaration("Jin'do the Hexxer", "Zul'Gurub")

module.revision = 30077
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = { "curse", "hex", "brainwash", "healingward", "autotarget", "bosskill" }
module.defaultDB = {
	autotarget = false,
}

L:RegisterTranslations("enUS", function()
	return {
		cmd = "Jindo",

		curse_cmd = "curse",
		curse_name = "Curse Alert",
		curse_desc = "Warn when players get Delusions of Jin'do.",

		hex_cmd = "hex",
		hex_name = "Hex Alert",
		hex_desc = "Warn when players get Hex.",

		brainwash_cmd = "brainwash",
		brainwash_name = "Brain Wash Totem Alert",
		brainwash_desc = "Warn when Jin'do summons Brain Wash Totems.",

		healingward_cmd = "healingward",
		healingward_name = "Healing Totem Alert",
		healingward_desc = "Warn when Jin'do summons Powerful Healing Wards.",

		autotarget_cmd = "autotarget",
		autotarget_name = "Autotargetting of Totems",
		autotarget_desc = "Autotargetting of Totems",


		trigger_engage = "Welcome to the great show, friends. Step right up to die!", --CHAT_MSG_MONSTER_YELL

		bar_hex = " Hexxed",
		msg_hex = " is Hexxed - Dispel!",

		msg_curseYou = "You are cursed! Kill the Shades!",
		bar_curse = " Cursed",

		msg_curseDispel = "Delusions of Jin'do was decursed!",

		msg_brainWash = "Brain Wash Totem!",
		--trigger_brainWashDeath = "Brain Wash Totem is destroyed.",--CHAT_MSG_COMBAT_HOSTILE_DEATH

		msg_healingWard = "Healing Totem!",
		--trigger_healingWardDeath = "Powerful Healing Ward is destroyed.",--CHAT_MSG_COMBAT_HOSTILE_DEATH
	}
end)


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Jindo",
	
	curse_cmd = "curse",
    curse_name = "诅咒警报",
    curse_desc = "当玩家受到金度的欺骗时进行警告。",

	hex_cmd = "hex",
    hex_name = "妖术警报",
    hex_desc = "当玩家受到妖术时进行警告。",
	
	brainwash_cmd = "brainwash",
    brainwash_name = "洗脑图腾警报",
    brainwash_desc = "当金度召唤洗脑图腾时进行警告。",

	healingward_cmd = "healingward",
    healingward_name = "治疗图腾警报",
    healingward_desc = "当金度召唤强力治疗图腾时进行警告。",

	autotarget_cmd = "autotarget",
    autotarget_name = "自动标记图腾",
    autotarget_desc = "自动标记图腾",
	
	
	trigger_engage = "朋友，欢迎参加这场盛宴。来吧，狂欢至死吧！",--CHAT_MSG_MONSTER_YELL
	
    bar_hex = " 妖术",
    msg_hex = " 被妖术 - 驱散！",
	
    msg_curseYou = "你被诅咒了！转火影子！",
    bar_curse = " 被诅咒",
	
    msg_curseDispel = "金度的欺骗被驱散了！",
	
    msg_brainWash = "快打洗脑图腾！",
	--trigger_brainWashDeath = "Brain Wash Totem is destroyed.",--CHAT_MSG_COMBAT_HOSTILE_DEATH
	
    msg_healingWard = "快打治疗图腾！",
	--trigger_healingWardDeath = "Powerful Healing Ward is destroyed.",--CHAT_MSG_COMBAT_HOSTILE_DEATH
} end )
local timer = {
	hexDuration = 5,
	curseDuration = 20,
}
local icon = {
	hex = "Spell_Nature_Polymorph",
	curse = "Spell_Shadow_UnholyFrenzy",
	brainWash = "Spell_Totem_WardOfDraining",
	healingWard = "Spell_Holy_LayOnHands",
}
local color = {
	hex = "Green",
	curse = "Blue",
}
local syncName = {
	hex = "JindoHexStart" .. module.revision,
	hexFade = "JindoHexStop" .. module.revision,
	curse = "JindoCurse" .. module.revision,
	curseFade = "JindoCurseStop" .. module.revision,
	curseDispel = "JindoCurseDispel" .. module.revision,
	brainWash = "JindoBrainWash" .. module.revision,
	healingWard = "JindoHealingWard" .. module.revision,
}

module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Hex", "HexEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Hex", "HexFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Delusions of Jin'do", "CurseEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Delusions of Jin'do", "CurseFadeEvent")
	self:RegisterCombatLog("SPELL_DISPEL", nil, "DispelEvent")
	self:RegisterCombatLog("SPELL_CAST_SUCCESS", "Summon Brain Wash Totem", "BrainWashEvent")
	self:RegisterCombatLog("SPELL_CAST_SUCCESS", "Powerful Healing Ward", "HealingWardEvent")






	self:ThrottleSync(3, syncName.hex)
	self:ThrottleSync(3, syncName.hexFade)
	self:ThrottleSync(3, syncName.curse)
	self:ThrottleSync(3, syncName.curseFade)
	self:ThrottleSync(3, syncName.curseDispel)
	self:ThrottleSync(3, syncName.brainWash)
	self:ThrottleSync(3, syncName.healingWard)
end

function module:OnSetup()
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:HexEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.hex .. " " .. ev.destName)
	end
end

function module:HexFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.hexFade .. " " .. ev.destName)
	end
end

function module:CurseEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.curse .. " " .. ev.destName)
	end
end

function module:CurseFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.curseFade .. " " .. ev.destName)
	end
end

-- a curse removed from a raid member
function module:DispelEvent(ev)
	if ev.extraSpellName == "Delusions of Jin'do" then
		self:Sync(syncName.curseDispel)
	end
end

function module:BrainWashEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.brainWash)
	end
end

function module:HealingWardEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.healingWard)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.hex and self.db.profile.hex and rest then
		self:Hex(rest)
	elseif sync == syncName.hexFade and self.db.profile.hex and rest then
		self:HexFade(rest)

	elseif sync == syncName.curse and self.db.profile.curse and rest then
		self:Curse(rest)
	elseif sync == syncName.curseFade and self.db.profile.curse and rest then
		self:CurseFade(rest)
	elseif sync == syncName.curseDispel then
		self:CurseDispel()

	elseif sync == syncName.brainWash and self.db.profile.brainwash then
		self:BrainWash()
	elseif sync == syncName.healingWard and self.db.profile.healingward then
		self:HealingWard()
	end
end

function module:Curse(rest)
	if rest == UnitName("Player") then
		self:WarningSign(icon.curse, 1)
		self:Message(L["msg_curseYou"], "Personal", false, nil, false)
		self:Sound("Beware")
	end

	self:Bar(rest .. L["bar_curse"], timer.curseDuration, icon.curse, true, color.curse)
end

function module:CurseFade(rest)
	self:RemoveBar(rest .. L["bar_curse"])
end

function module:CurseDispel()
	self:Message(L["msg_curseDispel"], "Urgent", false, nil, false)
end

function module:Hex(rest)
	self:Bar(rest .. L["bar_hex"], timer.hexDuration, icon.hex, true, color.hex)

	if BigWigs:PlayerClass() == "PALADIN" or BigWigs:PlayerClass() == "PRIEST" then
		self:Message(rest .. L["msg_hex"], "Important", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.hex, 0.7)
	end
end

function module:HexFade(rest)
	self:RemoveBar(rest .. L["bar_hex"])
end

function module:BrainWash()
	self:WarningSign(icon.brainWash, 0.7)
	self:Message(L["msg_brainWash"], "Attention", false, nil, false)
	self:Sound("Alarm")

	if UnitName("Target") == "Jin'do the Hexxer" and UnitName("TargetTarget") == UnitName("Player") then
		return
	end

	if UnitName("Target") == "Shade of Jin'do" then
		return
	end

	if BigWigs:PlayerClass() == "WARRIOR" and self.db.profile.autotarget then
		TargetByName("Brain Wash Totem", true)
	elseif BigWigs:PlayerClass() == "ROGUE" and self.db.profile.autotarget then
		TargetByName("Brain Wash Totem", true)
	elseif BigWigs:PlayerClass() == "HUNTER" and self.db.profile.autotarget then
		TargetByName("Brain Wash Totem", true)
	elseif BigWigs:PlayerClass() == "MAGE" and self.db.profile.autotarget then
		TargetByName("Brain Wash Totem", true)
	elseif BigWigs:PlayerClass() == "WARLOCK" and self.db.profile.autotarget then
		TargetByName("Brain Wash Totem", true)
	end
end

function module:HealingWard()
	self:WarningSign(icon.healingWard, 0.7)
	self:Message(L["msg_healingWard"], "Attention", false, nil, false)
	self:Sound("Alarm")

	if UnitName("Target") == "Brain Wash Totem" then
		return
	end
	if UnitName("Target") == "Jin'do the Hexxer" and UnitName("TargetTarget") == UnitName("Player") then
		return
	end

	if BigWigs:PlayerClass() == "WARRIOR" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	elseif BigWigs:PlayerClass() == "ROGUE" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	elseif BigWigs:PlayerClass() == "HUNTER" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	elseif BigWigs:PlayerClass() == "MAGE" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	elseif BigWigs:PlayerClass() == "WARLOCK" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	elseif BigWigs:PlayerClass() == "WARRIOR" and self.db.profile.autotarget then
		TargetByName("Powerful Healing Ward", true)
	end
end
