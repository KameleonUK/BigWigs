
local module, L = BigWigs:ModuleDeclaration("High Priest Thekal", "Zul'Gurub")

module.revision = 30083
module.combatLog = true -- triggers come from the combat log; Thekal's kill counts only in phase 2 (see BossUnitDied)
module.enabletrigger = module.translatedName
module.wipemobs = {"Zealot Zath", "Zealot Lor'Khan"}
module.toggleoptions = {
	"heal",
	"silence",
	"disarm",
	"blind",
	"gouge",
	"mortalcleave",
	"bloodlust",
	-1,
	"punch",
	"charge",
	"frenzy",
	"enrage",
	"adds",
	-1,
	"hpbars",
	"reztimer",
	"bosskill"
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Thekal",
	
	heal_cmd = "heal",
	heal_name = "Great Heal Alert",
	heal_desc = "Warn for Lor'Khan's Great Heals",
	
	silence_cmd = "silence",
	silence_name = "Silence Alert",
	silence_desc = "Warn for Silence",
	
	disarm_cmd = "disarm",
	disarm_name = "Disarm Alert",
	disarm_desc = "Warn for Disarm",
	
	blind_cmd = "blind",
	blind_name = "Blind Alert",
	blind_desc = "Warn for Blind",
	
	gouge_cmd = "gouge",
	gouge_name = "Gouge Alert",
	gouge_desc = "Warn for Gouge",
	
	mortalcleave_cmd = "mortalcleave",
	mortalcleave_name = "Mortal Cleave Alert",
	mortalcleave_desc = "Warn for Mortal Cleave",
	
	bloodlust_cmd = "bloodlust",
	bloodlust_name = "Bloodlust Alert",
	bloodlust_desc = "Warn for Bloodlust",

	punch_cmd = "punch",
	punch_name = "Force Punch Alert",
	punch_desc = "Warn for Force Punch",

	charge_cmd = "charge",
	charge_name = "Charge Alert",
	charge_desc = "Warn for Charge",
	
	frenzy_cmd = "frenzy",
	frenzy_name = "Frenzy Alert",
	frenzy_desc = "Warn for Frenzy",

	enrage_cmd = "enrage",
	enrage_name = "Enrage Alert",
	enrage_desc = "Warn for Enrage",
	
	adds_cmd = "adds",
	adds_name = "Tiger Adds Alert",
	adds_desc = "Warn for Tiger Adds",
	
	hpbars_cmd = "hpbars",
	hpbars_name = "HP Bars in Phase 1",
	hpbars_desc = "Display HP Bars for Thekal's, Zath's and Lor'Khan's HP",
	
	reztimer_cmd = "reztimer",
	reztimer_name = "Timer for Resurrect",
	reztimer_desc = "Time after one dies before he resurrects",
	
	
	msg_heal = "Zealot Lor'Khan is Healing - Interrupt!",
	bar_heal = "Casting Heal",
	
	
	bar_silence = " Silenced",
	msg_silence = " Silenced - Dispel!",
	
	bar_disarm = " Disarmed",
	
	bar_blind = " Blinded",
	
	bar_gouge = " Gouged",
	
	bar_mortalCleave = " Mortal Cleave",
	
	--to be confirmed
	bar_bloodlust = " Bloodlust",
	msg_bloodlust = " Bloodlust - Dispel!",
	
		--unuseable due to %s
	--trigger_mobDies = "(.+) dies.", --CHAT_MSG_MONSTER_EMOTE --High Priest Thekal // Zealot Zath // Zealot Lor'Khan
	bar_rezTimer = "Resurrect",
	
	trigger_resurrection = "is resurrected by a nearby ally!", --CHAT_MSG_MONSTER_EMOTE --High Priest Thekal // Zealot Zath // Zealot Lor'Khan
	
	trigger_phase2 = "Shirvallah, fill me with your RAGE!", --CHAT_MSG_MONSTER_YELL
	
	bar_phase2 = "Tiger Phase",
	msg_phase2 = "Phase 2 - Tiger Phase",
	
	bar_forcePunch = "Force Punch CD",
	bar_forcePunchCast = "Casting Force Punch!",
	
	bar_charge = "Charge CD",
	
	--to be confirmed
	msg_frenzy = "Frenzy - Tranq!",
	bar_frenzy = "Frenzy",
	
	msg_enrage = "High Priest Thekal is Enraged!",
	
	--no trigger_tigers
	bar_tigersCd = "Tigers Spawn CD",
	msg_tigers = "Tiger adds Spawned!",
	msg_addDead = "/2 Tiger Adds Dead",
	
	trigger_bossDead = "Hakkar binds me no more! Peace at last!", --CHAT_MSG_MONSTER_YELL
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Thekal",
	
	heal_cmd = "heal",
    heal_name = "强效治疗警报",
    heal_desc = "狂热者洛卡恩施放强效治疗时进行警告",
	
	silence_cmd = "silence",
    silence_name = "沉默警报",
    silence_desc = "沉默时进行警告",
	
	disarm_cmd = "disarm",
    disarm_name = "缴械警报",
    disarm_desc = "缴械时进行警告",
	
	blind_cmd = "blind",
    blind_name = "致盲警报",
    blind_desc = "致盲时进行警告",
	
	gouge_cmd = "gouge",
    gouge_name = "凿击警报",
    gouge_desc = "凿击时进行警告",
	
	mortalcleave_cmd = "mortalcleave",
    mortalcleave_name = "致死顺劈警报",
    mortalcleave_desc = "致死顺劈时进行警告",
	
	bloodlust_cmd = "bloodlust",
    bloodlust_name = "嗜血警报",
    bloodlust_desc = "嗜血时进行警告",

	punch_cmd = "punch",
    punch_name = "重击警报",
    punch_desc = "重击时进行警告",

	charge_cmd = "charge",
    charge_name = "冲锋警报",
    charge_desc = "冲锋时进行警告",
	
	frenzy_cmd = "frenzy",
    frenzy_name = "狂暴警报",
    frenzy_desc = "狂暴时进行警告",

	enrage_cmd = "enrage",
    enrage_name = "激怒警报",
    enrage_desc = "激怒时进行警告",
	
	adds_cmd = "adds",
    adds_name = "猛虎增援警报",
    adds_desc = "猛虎增援时进行警告",
	
	hpbars_cmd = "hpbars",
    hpbars_name = "第一阶段的血量条",
    hpbars_desc = "显示塞卡尔、札斯和洛卡恩的血量条",
	
	reztimer_cmd = "reztimer",
    reztimer_name = "复活计时器",
    reztimer_desc = "计时死亡后复活的时间",
	
	
    msg_heal = "狂热者洛卡恩正在治疗 - 打断！",
    bar_heal = "治疗施法中",
	
	
    bar_silence = " 被沉默",
    msg_silence = " 沉默 - 驱散！",
	
    bar_disarm = " 被缴械",
	
    bar_blind = " 被致盲",
	
    bar_gouge = " 被凿击",
	
    bar_mortalCleave = " 致死顺劈",
	
	--to be confirmed
    bar_bloodlust = " 嗜血",
    msg_bloodlust = " 嗜血 - 驱散！",
	
		--unuseable due to %s
	--trigger_mobDies = "(.+) dies.", --CHAT_MSG_MONSTER_EMOTE --High Priest Thekal // Zealot Zath // Zealot Lor'Khan
    bar_rezTimer = "复活",
	
	trigger_resurrection = "被附近的盟友复活了!", --CHAT_MSG_MONSTER_EMOTE --High Priest Thekal // Zealot Zath // Zealot Lor'Khan
	
	trigger_phase2 = "Shirvallah，让我充满你的愤怒！", --CHAT_MSG_MONSTER_YELL
	
    bar_phase2 = "猛虎阶段",
    msg_phase2 = "第二阶段 - 猛虎阶段",
	
    bar_forcePunch = "重击冷却",
    bar_forcePunchCast = "施放重击！",
	
    bar_charge = "冲锋冷却",
	
	--to be confirmed
    msg_frenzy = "狂暴 - 宁神射击！",
    bar_frenzy = "狂暴",
	
    msg_enrage = "狂暴了！加大治疗！",
	
	--no trigger_tigers
    bar_tigersCd = "猛虎生成冷却",
    msg_tigers = "猛虎增援生成！",
    msg_addDead = "/2 猛虎增援已死",
	
	trigger_bossDead = "哈卡不再束缚我！终于平安了！", --CHAT_MSG_MONSTER_YELL
	c_zuliantiger = "祖利安猛虎",
	c_zulianguardian = "祖利安守护者",
	you ="你",
} end )
local timer = {
	heal = 4,
	silence = 6,
	disarm = 6,
	blind = 10,
	gouge = 4,
	mortalCleave = 5,
	bloodlust = 30,
	rezTimer = 10, --guessing
	
	phase2 = 15, --15sec from thekal's death, not from all 3 dead
	
	forcePunchFirst = 5,
	forcePunch = {12,18}, --saw 12,18
	charge = {12,18}, --saw 13,15,18
	frenzy = 10, --is 8 or 10 depending on bosses
	addsFirst = 25,
	adds = 20,
}
local icon = {
	heal = "Spell_Holy_Heal",
	silence = "Spell_Holy_Silence",
	disarm = "Ability_Warrior_Disarm",
	blind = "spell_shadow_mindsteal",
	gouge = "ability_gouge",
	mortalCleave = "Ability_Warrior_SavageBlow",
	bloodlust = "Spell_Nature_BloodLust",
	hpBar = "spell_holy_prayerofspirit",
	rezTimer = "spell_holy_resurrection",
	
	phase = "ability_mount_jungletiger",
	
	forcePunch = "ability_smash",
	charge = "ability_warrior_charge",
	frenzy = "Ability_Druid_ChallangingRoar",
	enrage = "Spell_Shadow_UnholyFrenzy",
	adds = "Ability_Hunter_Pet_Cat",
}
local color = {
	heal = "Green",
	silence = "Blue",
	disarm = "Yellow",
	blind = "Black",
	gouge = "Red",
	mortalCleave = "Orange",
	bloodlust = "Cyan",
	hpBar = "Magenta",
	rezTimer = "White",
	
	phase = "White",
	
	forcePunch = "Black",
	charge = "White",
	frenzy = "Red",
	adds = "Blue",
}
local syncName = {
	heal = "ThekalLorkhanHeal"..module.revision,
	healOver = "ThekalLorkhanHealOver"..module.revision,
	
	silence = "ThekalSilence"..module.revision,
	silenceFade = "ThekalSilenceFade"..module.revision,
	
	disarm = "ThekalDisarm"..module.revision,
	disarmFade = "ThekalDisarmFade"..module.revision,
	
	blind = "ThekalBlind"..module.revision,
	blindFade = "ThekalBlindFade"..module.revision,
	
	gouge = "ThekalGouge"..module.revision,
	gougeFade = "ThekalGougeFade"..module.revision,
	
	mortalCleave = "ThekalMortalCleave"..module.revision,
	mortalCleaveFade = "ThekalMortalCleaveFade"..module.revision,
	
	bloodlust = "ThekalBloodlustStart"..module.revision,
	bloodlustFade = "ThekalBloodlustStop"..module.revision,
	
	
	
	phase1End = "ThekalPhase1End"..module.revision,
	phase2 = "ThekalPhaseTwo"..module.revision,
	
	forcePunch = "ThekalForcePunch"..module.revision,
	
	charge = "ThekalCharge"..module.revision,
	
	frenzy = "ThekalFrenzyStart"..module.revision,
	frenzyFade = "ThekalFrenzyStop"..module.revision,
	
	enrage = "ThekalEnrage"..module.revision,
	
	moreAdds = "ThekalMoreAdds"..module.revision,
	addDead = "ThekalAddDead"..module.revision,
}

local zathDead = nil
local lorkhanDead = nil
local thekalDead = nil

local zathHp = 100
local lorkhanHp = 100
local thekalHp = 100

local phase = "phase1"
local thekalDeadTime = 0

local doCheckForBossDeath = false

local castingHeal = nil

local addDead = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") --trigger_phase2
	
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE") --trigger_mobDies, trigger_resurrection
	
	self:RegisterCombatLog("SPELL_CAST_START", "Great Heal", "HealEvent")
	self:RegisterCombatLog("SPELL_INTERRUPT", nil, "InterruptEvent")
	self:RegisterCombatLog({"SWING_DAMAGE", "SWING_MISSED"}, nil, "MeleeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Silence", "SilenceEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Silence", "SilenceFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Disarm", "DisarmEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Disarm", "DisarmFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Blind", "BlindEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Blind", "BlindFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Gouge", "GougeEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Gouge", "GougeFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Mortal Cleave", "MortalCleaveEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Mortal Cleave", "MortalCleaveFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Bloodlust", "BloodlustEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Bloodlust", "BloodlustFadeEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Force Punch", "ForcePunchEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Charge", "ChargeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Frenzy", "FrenzyEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Frenzy", "FrenzyFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Enrage", "EnrageEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
		
	
	
	
	
	
	
	
	self:ThrottleSync(3, syncName.heal)
	self:ThrottleSync(3, syncName.healOver)
	
	self:ThrottleSync(3, syncName.silence)
	self:ThrottleSync(3, syncName.silenceFade)
	
	self:ThrottleSync(3, syncName.disarm)
	self:ThrottleSync(3, syncName.disarmFade)
	
	self:ThrottleSync(3, syncName.blind)
	self:ThrottleSync(3, syncName.blindFade)
	
	self:ThrottleSync(3, syncName.gouge)
	self:ThrottleSync(3, syncName.gougeFade)
	
	self:ThrottleSync(3, syncName.mortalCleave)
	self:ThrottleSync(3, syncName.mortalCleaveFade)
	
	self:ThrottleSync(3, syncName.bloodlust)
	self:ThrottleSync(3, syncName.bloodlustFade)
	
	
	self:ThrottleSync(10, syncName.phase1End)
	self:ThrottleSync(10, syncName.phase2)
	
	
	self:ThrottleSync(3, syncName.forcePunch)
	self:ThrottleSync(3, syncName.charge)
	
	self:ThrottleSync(3, syncName.frenzy)
	self:ThrottleSync(1, syncName.frenzyFade)
	
	self:ThrottleSync(5, syncName.enrage)
	
	self:ThrottleSync(10, syncName.moreAdds)
	self:ThrottleSync(0.5, syncName.addDead)
end

function module:OnSetup()
	self.started = nil

end

function module:OnEngage()
	zathDead = nil
	lorkhanDead = nil
	thekalDead = nil
	
	zathHp = 100
	lorkhanHp = 100
	thekalHp = 100
	
	phase = "phase1"
	thekalDeadTime = 0
	
	doCheckForBossDeath = false
	
	castingHeal = nil
	
	addDead = 0
	
	self:TriggerEvent("BigWigs_StartHPBar", self, "Zealot Zath", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
	self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Zath", 0)
	
	self:TriggerEvent("BigWigs_StartHPBar", self, "Zealot Lor'Khan", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
	self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Lor'Khan", 0)
	
	self:TriggerEvent("BigWigs_StartHPBar", self, "High Priest Thekal", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
	self:TriggerEvent("BigWigs_SetHPBar", self, "High Priest Thekal", 0)
	
	self:ScheduleRepeatingEvent("ThekalCheckHp", self.CheckHp, 0.5, self)
end

function module:OnDisengage()
	self:CancelScheduledEvent("Thekal_PhaseChangeCheck")
	
	self:CancelScheduledEvent("ThekalCheckHp")
end

-- UNIT_DIED: the tigers, and the trio dying in phase 1 (each is raised again unless all three die together)
function module:UnitDied(ev)
	if ev.destName == "Zulian Tiger" or ev.destName == "Zulian Guardian" then
		addDead = addDead + 1
		if addDead <= 2 then
			self:Sync(syncName.addDead .. " " .. addDead)
		end
	
	
	
	elseif ev.destName == "Zealot Zath" then
		if lorkhanDead == nil and thekalDead == nil and self.db.profile.reztimer then
			self:Bar(L["bar_rezTimer"], timer.rezTimer, icon.rezTimer, true, color.rezTimer)
		end
		
		zathDead = true
		if zathDead and lorkhanDead and thekalDead then
			self:ScheduleRepeatingEvent("Thekal_PhaseChangeCheck", self.PhaseChangeCheck, 1, self)
		end
		
		self:RemoveBar("Zealot Zath"..L["bar_bloodlust"])
		self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Zath")
	
	
	elseif ev.destName == "Zealot Lor'Khan" then
		if zathDead == nil and thekalDead == nil and self.db.profile.reztimer then
			self:Bar(L["bar_rezTimer"], timer.rezTimer, icon.rezTimer, true, color.rezTimer)
		end
		
		lorkhanDead = true
		castingHeal = nil
		if zathDead and lorkhanDead and thekalDead then
			self:ScheduleRepeatingEvent("Thekal_PhaseChangeCheck", self.PhaseChangeCheck, 1, self)
		end
		
		self:RemoveBar(L["bar_heal"])
		self:RemoveBar("Zealot Lor'Khan"..L["bar_bloodlust"])
		self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Lor'Khan")
	
	
	elseif ev.destName == "High Priest Thekal" then
		if zathDead == nil and lorkhanDead == nil and self.db.profile.reztimer then
			self:Bar(L["bar_rezTimer"], timer.rezTimer, icon.rezTimer, true, color.rezTimer)
		end
		
		thekalDead = true
		if zathDead and lorkhanDead and thekalDead then
			self:ScheduleRepeatingEvent("Thekal_PhaseChangeCheck", self.PhaseChangeCheck, 1, self)
		end
		
		self:RemoveBar("High Priest Thekal"..L["bar_bloodlust"])
		self:TriggerEvent("BigWigs_StopHPBar", self, "High Priest Thekal")
		
		thekalDeadTime = GetTime()
	end
end

function module:CHAT_MSG_MONSTER_EMOTE(msg)
	--there is no way to know which mob was resurrected as the emote is "%s is resurrected by a nearby ally!"
	--if we're in p1 and that happens, consider all alive and reset all bars
		--the mobs that are still alive will have their bar refreshed on hit
	if string.find(msg, L["trigger_resurrection"]) and phase == "phase1" then
		self:CancelScheduledEvent("Thekal_PhaseChangeCheck")
		
		if zathDead then zathDead = nil end
		zathHp = 100
		self:TriggerEvent("BigWigs_StartHPBar", self, "Zealot Zath", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
		self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Zath", 0)
		
		if lorkhanDead then lorkhanDead = nil end
		lorkhanHp = 100
		self:TriggerEvent("BigWigs_StartHPBar", self, "Zealot Lor'Khan", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
		self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Lor'Khan", 0)
		
		if thekalDead then thekalDead = nil end
		thekalHp = 100
		self:TriggerEvent("BigWigs_StartHPBar", self, "High Priest Thekal", 100, "Interface\\Icons\\"..icon.hpBar, true, color.hpBar)
		self:TriggerEvent("BigWigs_SetHPBar", self, "High Priest Thekal", 0)
	end
end

function module:PhaseChangeCheck()
	local zathDeadConfirm = true
	local lorkhanDeadConfirm = true
	local thekalDeadConfirm = true
	
	for i=1,GetNumRaidMembers() do
		if UnitName("Raid"..i.."Target") == "Zealot Zath" and not UnitIsDead("Raid"..i.."Target") then
			zathDeadConfirm = nil
		elseif UnitName("Raid"..i.."Target") == "Zealot Lor'Khan" and not UnitIsDead("Raid"..i.."Target") then
			lorkhanDeadConfirm = nil
		elseif UnitName("Raid"..i.."Target") == "High Priest Thekal" and not UnitIsDead("Raid"..i.."Target") then
			thekalDeadConfirm = nil
		end
	end

	if zathDeadConfirm and lorkhanDeadConfirm and thekalDeadConfirm then
		self:Sync(syncName.phase1End)
	end
end

function module:CheckHp()
	local zathHealth
	local lorkhanHealth
	local thekalHealth
	
	if UnitName("PlayerTarget") == "Zealot Zath" then
		zathHealth = math.ceil((UnitHealth("PlayerTarget") / UnitHealthMax("PlayerTarget")) * 100)
	elseif UnitName("PlayerTarget") == "Zealot Lor'Khan" then
		lorkhanHealth = math.ceil((UnitHealth("PlayerTarget") / UnitHealthMax("PlayerTarget")) * 100)
	elseif UnitName("PlayerTarget") == "High Priest Thekal" then
		thekalHealth = math.ceil((UnitHealth("PlayerTarget") / UnitHealthMax("PlayerTarget")) * 100)
	end
	
	for i=1,GetNumRaidMembers() do
		if UnitName("Raid"..i.."Target") == "Zealot Zath" then
			zathHealth = math.ceil((UnitHealth("Raid"..i.."Target") / UnitHealthMax("Raid"..i.."Target")) * 100)
		elseif UnitName("Raid"..i.."Target") == "Zealot Lor'Khan" then
			lorkhanHealth = math.ceil((UnitHealth("Raid"..i.."Target") / UnitHealthMax("Raid"..i.."Target")) * 100)
		elseif UnitName("Raid"..i.."Target") == "High Priest Thekal" then
			thekalHealth = math.ceil((UnitHealth("Raid"..i.."Target") / UnitHealthMax("Raid"..i.."Target")) * 100)
		end
		if zathHealth and lorkhanHealth and thekalHealth then break end
	end
	
	if zathHealth then
		self.zathHP = zathHealth
		self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Zath", 100-self.zathHP)
	end
	if lorkhanHealth then
		self.lorkhanHP = lorkhanHealth
		self:TriggerEvent("BigWigs_SetHPBar", self, "Zealot Lor'Khan", 100-self.lorkhanHP)
	end
	if thekalHealth then
		self.thekalHP = thekalHealth
		self:TriggerEvent("BigWigs_SetHPBar", self, "High Priest Thekal", 100-self.thekalHP)
	end
end

-- Thekal "dies" in phase 1 and is raised; only his phase 2 death is the kill
function module:BossUnitDied(ev)
	if doCheckForBossDeath then
		self:SendBossDeathSync()
	end
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L["trigger_phase2"] then
		self:Sync(syncName.phase2)
	
	elseif msg == L["trigger_bossDead"] then
		self:SendBossDeathSync()
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:HealEvent(ev)
	if ev.sourceName == "Zealot Lor'Khan" then
		self:Sync(syncName.heal)
	end
end

-- Lor'Khan's Great Heal cut short: an interrupt on her, or her melee starting again
function module:InterruptEvent(ev)
	if castingHeal == true and ev.destName == "Zealot Lor'Khan" then
		self:Sync(syncName.healOver)
	end
end

function module:MeleeEvent(ev)
	if castingHeal == true and ev.sourceName == "Zealot Lor'Khan" then
		self:Sync(syncName.healOver)
	end
end

function module:SilenceEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.silence .. " " .. ev.destName)
	end
end

function module:SilenceFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.silenceFade .. " " .. ev.destName)
	end
end

function module:DisarmEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.disarm .. " " .. ev.destName)
	end
end

function module:DisarmFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.disarmFade .. " " .. ev.destName)
	end
end

function module:BlindEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.blind .. " " .. ev.destName)
	end
end

function module:BlindFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.blindFade .. " " .. ev.destName)
	end
end

function module:GougeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.gouge .. " " .. ev.destName)
	end
end

function module:GougeFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.gougeFade .. " " .. ev.destName)
	end
end

function module:MortalCleaveEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mortalCleave .. " " .. ev.destName)
	end
end

function module:MortalCleaveFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mortalCleaveFade .. " " .. ev.destName)
	end
end

local trio = { ["Zealot Zath"] = true, ["Zealot Lor'Khan"] = true, ["High Priest Thekal"] = true }

function module:BloodlustEvent(ev)
	if ev.destName and trio[ev.destName] then
		self:Sync(syncName.bloodlust .. " " .. ev.destName)
	end
end

function module:BloodlustFadeEvent(ev)
	if ev.destName and trio[ev.destName] then
		self:Sync(syncName.bloodlustFade .. " " .. ev.destName)
	end
end

function module:ForcePunchEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.forcePunch)
	end
end

function module:ChargeEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.charge)
	end
end

function module:FrenzyEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzy)
	end
end

function module:FrenzyFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzyFade)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.heal and self.db.profile.heal then
		self:Heal()
	elseif sync == syncName.healOver and self.db.profile.heal then
		self:HealOver()
	
	elseif sync == syncName.silence and rest and self.db.profile.silence then
		self:Silence(rest)
	elseif sync == syncName.silenceFade and rest and self.db.profile.silence then
		self:SilenceFade(rest)
		
	elseif sync == syncName.disarm and rest and self.db.profile.disarm then
		self:Disarm(rest)
	elseif sync == syncName.disarmFade and rest and self.db.profile.disarm then
		self:DisarmFade(rest)
		
	elseif sync == syncName.blind and rest and self.db.profile.blind then
		self:Blind(rest)
	elseif sync == syncName.blindFade and rest and self.db.profile.blind then
		self:BlindFade(rest)
		
	elseif sync == syncName.gouge and rest and self.db.profile.gouge then
		self:Gouge(rest)
	elseif sync == syncName.gougeFade and rest and self.db.profile.gouge then
		self:GougeFade(rest)
		
	elseif sync == syncName.mortalCleave and rest and self.db.profile.mortalcleave then
		self:MortalCleave(rest)
	elseif sync == syncName.mortalCleaveFade and rest and self.db.profile.mortalcleave then
		self:MortalCleaveFade(rest)
		
	elseif sync == syncName.bloodlust and rest and self.db.profile.bloodlust then
		self:Bloodlust(rest)
	elseif sync == syncName.bloodlustFade and rest and self.db.profile.bloodlust then
		self:BloodlustFade(rest)
		
		
	elseif sync == syncName.phase1End then
		self:Phase1End()
	elseif sync == syncName.phase2 then
		self:Phase2()

	
	elseif sync == syncName.forcePunch and self.db.profile.punch then
		self:ForcePunch()
		
	elseif sync == syncName.charge and self.db.profile.charge then
		self:Charge()
		
	elseif sync == syncName.frenzy and self.db.profile.frenzy then
		self:Frenzy()
	elseif sync == syncName.frenzyFade and self.db.profile.frenzy then
		self:FrenzyFade()
		
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	
	elseif sync == syncName.moreAdds and self.db.profile.adds then
		self:MoreAdds()
	elseif sync == syncName.addDead and rest and self.db.profile.adds then
		self:AddDead(rest)
	end
end


function module:Heal()
	castingHeal = true
	
	self:Bar(L["bar_heal"], timer.heal, icon.heal, true, color.heal)
	
	if BigWigs:PlayerClass() == "SHAMAN" or BigWigs:PlayerClass() == "WARRIOR" or BigWigs:PlayerClass() == "MAGE" then
		self:Message(L["msg_heal"], "Urgent", false, nil, false)
		self:Sound("Beware")
		self:WarningSign(icon.heal, timer.heal)
	end
end

function module:HealOver()
	castingHeal = nil
	self:RemoveBar(L["bar_heal"])
	self:RemoveWarningSign(icon.heal)
end

function module:Silence(rest)
	self:Bar(rest..L["bar_silence"], timer.silence, icon.silence, true, color.silence)	
	
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "PALADIN" then
		self:Message(rest..L["msg_silence"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.silence, 0.7)
	end
end

function module:SilenceFade(rest)
	self:RemoveBar(rest..L["bar_silence"])
end

function module:Disarm(rest)
	self:Bar(rest..L["bar_disarm"], timer.disarm, icon.disarm, true, color.disarm)	
end

function module:DisarmFade(rest)
	self:RemoveBar(rest..L["bar_disarm"])
end

function module:Blind(rest)
	self:Bar(rest..L["bar_blind"], timer.blind, icon.blind, true, color.blind)	
end

function module:BlindFade(rest)
	self:RemoveBar(rest..L["bar_blind"])
end

function module:Gouge(rest)
	self:Bar(rest..L["bar_gouge"], timer.gouge, icon.gouge, true, color.gouge)	
end

function module:GougeFade(rest)
	self:RemoveBar(rest..L["bar_gouge"])
end

function module:MortalCleave(rest)
	self:Bar(rest..L["bar_mortalCleave"], timer.mortalCleave, icon.mortalCleave, true, color.mortalCleave)	
end

function module:MortalCleaveFade(rest)
	self:RemoveBar(rest..L["bar_mortalCleave"])
end

function module:Bloodlust(rest)
	self:Bar(rest..L["bar_bloodlust"], timer.bloodlust, icon.bloodlust, true, color.bloodlust)	
	
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "SHAMAN" then
		self:Message(rest..L["msg_bloodlust"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.bloodlust, 0.7)
	end
end

function module:BloodlustFade(rest)
	self:RemoveBar(rest..L["bar_bloodlust"])
end


function module:Phase1End()
	phase = "phase2"
	addDead = 0
	
	self:CancelScheduledEvent("Thekal_PhaseChangeCheck")
	
	self:CancelScheduledEvent("ThekalCheckHp")
	self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Zath")
	self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Lor'Khan")
	self:TriggerEvent("BigWigs_StopHPBar", self, "High Priest Thekal")
	
	self:RemoveBar(L["bar_heal"])
	self:RemoveBar(L["bar_rezTimer"])
	self:RemoveBar("Zealot Zath"..L["bar_bloodlust"])
	self:RemoveBar("Zealot Lor'Khan"..L["bar_bloodlust"])
	self:RemoveBar("High Priest Thekal"..L["bar_bloodlust"])
	
	--phase 2 happens 15sec from the moment thekal dies,
		--if the other die 8sec after thekal, only 7sec timer for p2
	self:Bar(L["bar_phase2"], timer.phase2 - (GetTime() - thekalDeadTime), icon.phase, true, color.phase)
	self:Message(L["msg_phase2"], "Attention", false, nil, false)
end

function module:Phase2()
	phase = "phase2"
	addDead = 0
	
	self:CancelScheduledEvent("Thekal_PhaseChangeCheck")
	
	self:CancelScheduledEvent("ThekalCheckHp")
	self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Zath")
	self:TriggerEvent("BigWigs_StopHPBar", self, "Zealot Lor'Khan")
	self:TriggerEvent("BigWigs_StopHPBar", self, "High Priest Thekal")
	
	self:RemoveBar(L["bar_heal"])
	self:RemoveBar(L["bar_rezTimer"])
	self:RemoveBar("Zealot Zath"..L["bar_bloodlust"])
	self:RemoveBar("Zealot Lor'Khan"..L["bar_bloodlust"])
	self:RemoveBar("High Priest Thekal"..L["bar_bloodlust"])
	
	self:RemoveBar(L["bar_phase2"])
	
	doCheckForBossDeath = true
	
	if self.db.profile.punch then
		self:Bar(L["bar_forcePunch"], timer.forcePunchFirst, icon.forcePunch, true, color.forcePunch)
	end
	
	if self.db.profile.charge then
		self:IntervalBar(L["bar_charge"], timer.charge[1], timer.charge[2], icon.charge, true, color.charge)
	end
	
	if self.db.profile.adds then
		self:Bar(L["bar_tigersCd"], timer.addsFirst, icon.adds, true, color.adds)
		self:DelayedSync(timer.addsFirst, syncName.moreAdds)
	end
end


function module:ForcePunch()
	self:RemoveBar(L["bar_forcePunch"])
	self:IntervalBar(L["bar_forcePunch"], timer.forcePunch[1], timer.forcePunch[2], icon.forcePunch, true, color.forcePunch)
end

function module:Charge()
	self:RemoveBar(L["bar_charge"])
	self:IntervalBar(L["bar_charge"], timer.charge[1], timer.charge[2], icon.charge, true, color.charge)
end

function module:Frenzy()
	self:Bar(L["bar_frenzy"], timer.frenzy, icon.frenzy, true, color.frenzy)
	
	if BigWigs:PlayerClass() == "HUNTER" then
		self:Message(L["msg_frenzy"], "Personal", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.frenzy, 1)
	end
end

function module:FrenzyFade()
	self:RemoveBar(L["bar_frenzy"])
	self:RemoveWarningSign(icon.frenzy)
end

function module:Enrage()
	self:Message(L["msg_enrage"], "Attention", false, nil, false)
	self:Sound("Beware")
	self:WarningSign(icon.enrage, 0.7)
end

function module:MoreAdds()
	addDead = 0
	
	self:Bar(L["bar_tigersCd"], timer.adds, icon.adds, true, color.adds)
	self:Message(L["msg_tigers"], "Important", false, nil, false)
	self:Sound("Alarm")
	self:WarningSign(icon.adds, 1)
	
	self:DelayedSync(timer.adds, syncName.moreAdds)
end

function module:AddDead(rest)
	self:Message(rest..L["msg_addDead"], "Positive", false, nil, false)
end
