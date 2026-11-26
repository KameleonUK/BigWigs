
local module, L = BigWigs:ModuleDeclaration("Battleguard Sartura", "Ahn'Qiraj")

module.revision = 30075
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.wipemobs = {"Sartura's Royal Guard"}
module.toggleoptions = {"whirlwind", "adds", "enrage", "berserk", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Sartura",
		
	adds_cmd = "adds",
	adds_name = "Dead adds counter",
	adds_desc = "Announces dead Sartura's Royal Guards.",
	
	whirlwind_cmd = "whirlwind",
	whirlwind_name = "Whirlwind",
	whirlwind_desc = "Timers and bars for Whirlwinds.",
	
	enrage_cmd = "enrage",
	enrage_name = "Enrage",
	enrage_desc = "Announces the Enrage when the boss is at 20% HP.",

	berserk_cmd = "berserk",
	berserk_name = "Berserk",
	berserk_desc = "Warns for the Berserk that the boss gains after 10 minutes.",

	
	trigger_engage = "You will be judged for defiling these sacred grounds! The laws of the Ancients will not be challenged! Trespassers will be annihilated!", --CHAT_MSG_MONSTER_YELL
	trigger_bossDead = "I serve to the last!", --CHAT_MSG_MONSTER_YELL
	
	msg_addDead = "%d/3 Sartura's Royal Guards dead!",
	
	bar_whirlwind = "Whirlwind!",
	msg_whirlwind = "Whirlwind!",
	bar_whirlwindCd = "Whirlwind CD",
	
	msg_whirlwindFade = "Whirlwind ended!",
	
	msg_enrage = "Enrage - Spam heals!",
	
	msg_berserk = "Berserk!",
	bar_berserk = "Berserk",
	msg_berserk60 = "Berserk in 60 seconds!",
	msg_berserk10 = "Berserk in 10 seconds!",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Sartura",

    adds_cmd = "adds",
    adds_name = "萨特拉的皇家卫兵死亡计数器",
    adds_desc = "宣布萨特拉的皇家卫兵死亡。",

    whirlwind_cmd = "whirlwind",
    whirlwind_name = "旋风斩",
    whirlwind_desc = "旋风斩的计时器和计时条。",

    enrage_cmd = "enrage",
    enrage_name = "激怒",
    enrage_desc = "在Boss血量为20%时警告激怒。",

    berserk_cmd = "berserk",
    berserk_name = "狂暴",
    berserk_desc = "警告Boss在10分钟后获得的狂暴。",


    trigger_engage = "你将因玷污这些神圣的土地而受到审判！上古法则不容挑战！入侵者将被消灭！", --CHAT_MSG_MONSTER_YELL
    trigger_bossDead = "我服务到最后！", --CHAT_MSG_MONSTER_YELL

    msg_addDead = "%d/3 沙尔图拉皇家卫士死亡！",

    bar_whirlwind = "旋风斩！",
    msg_whirlwind = "旋风斩！",
    bar_whirlwindCd = "旋风斩 CD",

    msg_whirlwindFade = "旋风斩结束！",

    msg_enrage = "激怒 - 疯狂治疗！",

    msg_berserk = "狂暴！",
    bar_berserk = "狂暴",
    msg_berserk60 = "60秒后狂暴！",
    msg_berserk10 = "10秒后狂暴！",
} end )
local timer = {
	firstWhirlwind = {8,12},
	whirlwindCd = {5,10},
	whirlwindDur = 15,
	
	berserk = 600,
}
local icon = {
	whirlwind = "Ability_Whirlwind",
	berserk = "Spell_Shadow_UnholyFrenzy",
}
local color = {
	whirlwindCd = "Blue",
	whirlwindDur = "Red",
	berserk = "Black",
}
local syncName = {
	whirlwind = "SarturaWhirlwindStart"..module.revision,
	whirlwindFade = "SarturaWhirlwindEnd"..module.revision,
	enrage = "SarturaEnrage"..module.revision,
	berserk = "SarturaBerserk"..module.revision,
}

local addDeadCount = 0

module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	
	--self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Whirlwind", "WhirlwindEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Whirlwind", "WhirlwindFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Enrage", "EnrageEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Berserk", "BerserkEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	


	self:ThrottleSync(3, syncName.whirlwind)
	self:ThrottleSync(3, syncName.whirlwindFade)
	self:ThrottleSync(5, syncName.enrage)
	self:ThrottleSync(5, syncName.berserk)
end

function module:OnSetup()
	self.started = nil

end

function module:OnEngage()
	addDeadCount = 0
	
	if self.db.profile.berserk then
		self:Bar(L["bar_berserk"], timer.berserk, icon.berserk, true, color.berserk)
		self:DelayedMessage(timer.berserk - 60, L["msg_berserk60"], "Urgent", false, nil, false)
		self:DelayedMessage(timer.berserk - 10, L["msg_berserk10"], "Important", false, nil, false)
	end
	
	if self.db.profile.whirlwind then
		self:IntervalBar(L["bar_whirlwindCd"], timer.firstWhirlwind[1], timer.firstWhirlwind[2], icon.whirlwind, true, color.whirlwindCd)
	end
end

function module:OnDisengage()
end

-- UNIT_DIED: her Royal Guards (Sartura's own death comes from the core)
function module:UnitDied(ev)
	if ev.destName == "Sartura's Royal Guard" and self.db.profile.adds then
		addDeadCount = addDeadCount + 1
		self:Message(string.format(L["msg_addDead"], addDeadCount), "Positive", false, nil, false)
	end
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_bossDead"] then
		self:SendBossDeathSync()
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:WhirlwindEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.whirlwind)
	end
end

function module:WhirlwindFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.whirlwindFade)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end

function module:BerserkEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.berserk)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.whirlwind and self.db.profile.whirlwind then
		self:Whirlwind()
	
	elseif sync == syncName.whirlwindFade and self.db.profile.whirlwind then
		self:WhirlwindFade()
	
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
		
	elseif sync == syncName.berserk and self.db.profile.berserk then
		self:Berserk()
	end
end


function module:Whirlwind()
	self:RemoveBar(L["bar_whirlwindCd"])
	
	self:Bar(L["bar_whirlwind"], timer.whirlwindDur, icon.whirlwind, true, color.whirlwindDur)
	self:Message(L["msg_whirlwind"], "Important", false, nil, false)
end

function module:WhirlwindFade()
	self:RemoveBar(L["bar_whirlwind"])
	
	self:IntervalBar(L["bar_whirlwindCd"], timer.whirlwindCd[1], timer.whirlwindCd[2], icon.whirlwind, true, color.whirlwindCd)
	self:Message(L["msg_whirlwindFade"], "Attention", false, nil, false)
end

function module:Enrage()
	self:Message(L["msg_enrage"], "Attention", false, nil, false)
end

function module:Berserk()
	self:RemoveBar(L["bar_berserk"])
	self:CancelDelayedMessage(L["msg_berserk60"])
	self:CancelDelayedMessage(L["msg_berserk10"])
	
	self:Message(L["msg_berserk"], "Attention", false, nil, false)
end
