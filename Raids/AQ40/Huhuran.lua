
local module, L = BigWigs:ModuleDeclaration("Princess Huhuran", "Ahn'Qiraj")

module.revision = 30033
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"wyvernsting", "frenzy", "noxiouspoison", "berserk", "enrage", "bosskill"}

module.defaultDB = {
	enrage = false,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Huhuran",

	wyvernsting_cmd = "wyvernsting",
	wyvernsting_name = "Wyvern Sting Alert",
	wyvernsting_desc = "Warn for Wyvern Sting",

	frenzy_cmd = "frenzy",
	frenzy_name = "Frenzy Alert",
	frenzy_desc = "Warn for Frenzy",

	noxiouspoison_cmd = "noxiouspoison",
	noxiouspoison_name = "Noxious Poison Alert",
	noxiouspoison_desc = "Warn for Noxious Poison",
	
	berserk_cmd = "berserk",
	berserk_name = "Low Hp Berserk Alert",
	berserk_desc = "Warn for Low Hp Berserk",
	
	enrage_cmd = "enrage",
	enrage_name = "Timed Enrage Alert",
	enrage_desc = "Warn for Timed Enrage",
	
	
	bar_wyvernStingDuration = "Wyvern Stung",
	bar_wyvernStingCd = "Wyvern Sting CD",
	
	bar_frenzyDuration = "Frenzy!",
	bar_frenzyCd = "Frenzy CD",
	msg_frenzy = "Frenzy - Tranq Shot!",

	bar_noxiousPoisonDuration = "People Silenced",
	bar_noxiousPoisonCd = "Noxious Poison CD",
	
	msg_berserk = "Berserk! Soak poison!",
	
	bar_enrage = "Enrage",
	msg_enrage1min = "Enrage in 60 seconds",
	msg_enrage5sec = "Enrage in 5 seconds",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Huhuran",

    wyvernsting_cmd = "wyvernsting",
    wyvernsting_name = "飞龙钉刺警报",
    wyvernsting_desc = "飞龙钉刺出现时进行警告",

    frenzy_cmd = "frenzy",
    frenzy_name = "狂乱警报",
    frenzy_desc = "狂乱出现时进行警告",

    noxiouspoison_cmd = "noxiouspoison",
    noxiouspoison_name = "剧毒警报",
    noxiouspoison_desc = "剧毒出现时进行警告",
    
    berserk_cmd = "berserk",
    berserk_name = "低血量狂暴警报",
    berserk_desc = "低血量狂暴出现时进行警告",
    
    enrage_cmd = "enrage",
    enrage_name = "定时狂怒警报",
    enrage_desc = "定时狂怒出现时进行警告",
    
    
    bar_wyvernStingDuration = "翼龙钉刺效果",
    bar_wyvernStingCd = "翼龙钉刺冷却",
    
    bar_frenzyDuration = "狂乱！",
    bar_frenzyCd = "狂乱冷却",
    msg_frenzy = "狂乱 - 宁神射击！",

    bar_noxiousPoisonDuration = "沉默效果",
    bar_noxiousPoisonCd = "剧毒冷却",
    
    msg_berserk = "狂暴！开管家铃！召唤各种小弟！",
    
    bar_enrage = "狂怒",
    msg_enrage1min = "60秒内狂怒",
    msg_enrage5sec = "5秒内狂怒",
} end )
local timer = {
	wyvernStingCdFirst = {18,28},
	wyvernStingCd = {3,20},--15,32 minus 12sec duration
	wyvernStingDuration = 12,
	
	frenzyCd = {25,35},
	frenzyDuration = 8,
	
	noxiousPoisonCdFirst = {10,14},
	noxiousPoisonCd = {3,7},--11,15 minus 8sec duration
	noxiousPoisonDuration = 8,
	
	enrage = 300,
}
local icon = {
	wyvernSting = "INV_Spear_02",
	frenzy = "Ability_Druid_ChallangingRoar",
	tranq = "Spell_Nature_Drowsy",
	noxiousPoison = "spell_nature_corrosivebreath",
	berserk = "Spell_Shadow_UnholyFrenzy",
	enrage = "Spell_Shadow_UnholyFrenzy",
}
local color = {
	wyvernStingCd = "Yellow",
	wyvernStingDuration = "Blue",
	frenzyCd = "Cyan",
	frenzyDuration = "Red",
	noxiousPoisonCd = "Black",
	noxiousPoisonDuration = "Green",
	enrage = "White",
}
local syncName = {
	wyvernSting = "HuhuranWyvernSting"..module.revision,
	frenzyGain = "HuhuranFrenzyGain"..module.revision,
	frenzyFade = "HuhuranFrenzyFade"..module.revision,
	noxiousPoison = "HuhuranNoxiousCD"..module.revision,
	berserk = "HuhuranBerserk"..module.revision,
	enrage = "HuhuranEnrage"..module.revision,
}

local lastFrenzy = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Wyvern Sting", "WyvernStingEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Wyvern Sting", "WyvernStingFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Noxious Poison", "NoxiousPoisonEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Noxious Poison", "NoxiousPoisonFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Frenzy", "FrenzyEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Frenzy", "FrenzyFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Berserk", "BerserkEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Enrage", "EnrageEvent")
	

	self:ThrottleSync(5, syncName.wyvernSting)
	self:ThrottleSync(5, syncName.frenzyGain)
	self:ThrottleSync(5, syncName.frenzyFade)
	self:ThrottleSync(5, syncName.noxiousPoison)
	self:ThrottleSync(5, syncName.berserk)
	self:ThrottleSync(5, syncName.enrage)
end

function module:OnSetup()
end

function module:OnEngage()
	if self.db.profile.enrage then
		self:Bar(L["bar_enrage"], timer.enrage, icon.berserk, true, color.enrage)
		self:DelayedMessage(timer.enrage - 60, L["msg_enrage1min"], "Urgent", false, nil, false)
		self:DelayedMessage(timer.enrage - 5, L["msg_enrage5sec"], "Urgent", false, nil, false)
	end
	if self.db.profile.wyvernsting then
		self:IntervalBar(L["bar_wyvernStingCd"], timer.wyvernStingCdFirst[1], timer.wyvernStingCdFirst[2], icon.wyvernSting, true, color.wyvernStingCd)
	end
	if self.db.profile.frenzy then
		self:IntervalBar(L["bar_frenzyCd"], timer.frenzyCd[1], timer.frenzyCd[2], icon.frenzy, true, color.frenzyCd)
	end
	if self.db.profile.noxiouspoison then
		self:IntervalBar(L["bar_noxiousPoisonCd"], timer.noxiousPoisonCdFirst[1], timer.noxiousPoisonCdFirst[2], icon.noxiousPoison, true, color.noxiousPoisonCd)
	end
end
function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:WyvernStingEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") then
		self:WarningSign(icon.wyvernSting, timer.wyvernStingDuration)
	end
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.wyvernSting)
	end
end

function module:WyvernStingFadeEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") then
		self:RemoveWarningSign(icon.wyvernSting)
	end
end

function module:NoxiousPoisonEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") then
		self:WarningSign(icon.noxiousPoison, timer.noxiousPoisonDuration)
	end
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.noxiousPoison)
	end
end

function module:NoxiousPoisonFadeEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") then
		self:RemoveWarningSign(icon.noxiousPoison)
	end
end

function module:FrenzyEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzyGain)
	end
end

function module:FrenzyFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzyFade)
	end
end

function module:BerserkEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.berserk)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.wyvernSting and self.db.profile.wyvernsting then
		self:WyvernSting()
	elseif sync == syncName.frenzyGain and self.db.profile.frenzy then
		self:FrenzyGain()
	elseif sync == syncName.frenzyFade and self.db.profile.frenzy then
		self:FrenzyFade()
	elseif sync == syncName.noxiousPoison and self.db.profile.noxiouspoison then
		self:NoxiousPoison()
	elseif sync == syncName.berserk and self.db.profile.berserk then
		self:Berserk()
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	end
end

function module:WyvernSting()
	self:RemoveBar(L["bar_wyvernStingCd"])
	
	self:Bar(L["bar_wyvernStingDuration"], timer.wyvernStingDuration, icon.wyvernSting, true, color.wyvernStingDuration)
	self:DelayedIntervalBar(timer.wyvernStingDuration, L["bar_wyvernStingCd"], timer.wyvernStingCd[1], timer.wyvernStingCd[2], icon.wyvernSting, true, color.wyvernStingCd)
end

function module:FrenzyGain()
	self:RemoveBar(L["bar_frenzyCd"])
	
	self:Bar(L["bar_frenzyDuration"], timer.frenzyDuration, icon.frenzy, true, color.frenzyDuration)
	self:Message(L["msg_frenzy"], "Important", false, nil, false)
	
	lastFrenzy = GetTime()
	
	if BigWigs:PlayerClass() == "HUNTER" then
		self:Sound("Info")
		self:WarningSign(icon.tranq, timer.frenzyDuration)
	end
end

function module:FrenzyFade()
	self:RemoveBar(L["bar_frenzyDuration"])
	self:RemoveWarningSign(icon.tranq)
	
	if lastFrenzy ~= 0 then
		local NextTime = (lastFrenzy + timer.frenzyCd[1]) - GetTime()
		local latestNextTime = (lastFrenzy + timer.frenzyCd[2]) - GetTime()
		self:IntervalBar(L["bar_frenzyCd"], NextTime, latestNextTime, icon.frenzy, true, color.frenzyCd)
	end
end

function module:NoxiousPoison()
	self:RemoveBar(L["bar_noxiousPoisonCd"])
	
	self:Bar(L["bar_noxiousPoisonDuration"], timer.noxiousPoisonDuration, icon.noxiousPoison, true, color.noxiousPoisonDuration)
	self:DelayedIntervalBar(timer.noxiousPoisonDuration, L["bar_noxiousPoisonCd"], timer.noxiousPoisonCd[1], timer.noxiousPoisonCd[2], icon.noxiousPoison, true, color.noxiousPoisonCd)
end

function module:Berserk()
	--no more frenzy when she berserks
	self:RemoveBar(L["bar_frenzyDuration"])
	self:RemoveBar(L["bar_frenzyCd"])
	self:RemoveWarningSign(icon.tranq)

	
	self:Message(L["msg_berserk"], "Urgent", false, nil, false)
	self:Sound("Beware")
	self:WarningSign(icon.berserk, 0.7)
end

function module:Enrage()
	self:RemoveBar(L["bar_enrage"])
	self:CancelDelayedMessage(L["msg_enrage1min"])
	self:CancelDelayedMessage(L["msg_enrage5sec"])
	
	self:Sound("Beware")
	self:WarningSign(icon.enrage, 0.7)
end
