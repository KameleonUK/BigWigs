
local module, L = BigWigs:ModuleDeclaration("The Bug Family", "Ahn'Qiraj")

local kri = AceLibrary("Babble-Boss-2.2")["Lord Kri"]
local yauj = AceLibrary("Babble-Boss-2.2")["Princess Yauj"]
local vem = AceLibrary("Babble-Boss-2.2")["Vem"]

module.revision = 30077
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = {kri, yauj, vem}
module.toggleoptions = {"panic", "volley", "heal", "enrage", "vapors", "deathspecials", "bosskill"}

module.defaultDB = {
	enrage = false,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "BugFamily",
	
	panic_cmd = "panic",
	panic_name = "Fear",
	panic_desc = "Warn for Princess Yauj's Panic.",

	volley_cmd = "volley",
	volley_name = "Toxic Volley",
	volley_desc = "Warn for Lord Kri's Toxic Volley.",

	heal_cmd = "heal",
	heal_name = "Great Heal",
	heal_desc = "Announce Princess Yauj's heals.",
	
	enrage_cmd = "enrage",
	enrage_name = "Enrage",
	enrage_desc = "Enrage timers.",
	
	vapors_cmd = "vapors",
	vapors_name = "Vapors Cloud Alert",
	vapors_desc = "Warn if you are standing in the Toxic Vapors Cloud.",
	
	deathspecials_cmd = "deathspecials",
	deathspecials_name = "Death Specials",
	deathspecials_desc = "Lets people know which boss has been killed and what special abilities they do.",


	bar_panic = "Panic CD",
	
	bar_volley = "Toxic Volley",
	
	bar_heal = "Great Heal",
	msg_heal = "Yauj Casting Heal - Interrupt!",
	
	
	trigger_enrage = "%s goes into a berserker rage!",--CHAT_MSG_MONSTER_EMOTE (not confirmed)
	bar_enrage = "Enrage",
	msg_enrage60 = "Enrage in 60 seconds!",
	msg_enrage10 = "Enrage in 10 seconds!",
	msg_enrage = "Enraged!",

	msg_toxicVapors = "Move away from the Poison Cloud!",
	
	msg_kriDead = "Kri is Dead - POISON CLOUD!",
	msg_yaujDead = "Yauj is Dead - KILL THE SPAWNS!",
	msg_vemDead = "Vem is Dead - ENRAGE!",	
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "BugFamily",

    panic_cmd = "panic",
    panic_name = "恐惧",
    panic_desc = "警告亚尔基公主的恐慌技能。",

    volley_cmd = "volley",
    volley_name = "毒性箭雨",
    volley_desc = "警告克里勋爵的毒性箭雨。",

    heal_cmd = "heal",
    heal_name = "强效治疗",
    heal_desc = "警告亚尔基公主的治疗。",

    enrage_cmd = "enrage",
    enrage_name = "激怒",
    enrage_desc = "激怒计时器。",

    vapors_cmd = "vapors",
    vapors_name = "毒云警报",
    vapors_desc = "警告你是否站在毒性蒸汽中。",

    deathspecials_cmd = "deathspecials",
    deathspecials_name = "死亡特效",
    deathspecials_desc = "让人们知道哪个Boss被杀死以及他们具有的特殊能力。",


    bar_panic = "恐慌 CD",

    bar_volley = "毒性箭雨",

    bar_heal = "强效治疗",
    msg_heal = "亚尔基正在施放治疗 - 打断它！",
	
	
    trigger_enrage = "%s进入了狂暴状态！",--CHAT_MSG_MONSTER_EMOTE (not confirmed)
    bar_enrage = "狂暴",
    msg_enrage60 = "60秒后狂暴！",
    msg_enrage10 = "10秒后狂暴！",
    msg_enrage = "狂暴了！",

    msg_toxicVapors = "远离毒云！",

    msg_kriDead = "克里勋爵死了 - 毒云！",
    msg_yaujDead = "亚尔基公主死了 - 杀死幼虫！",
    msg_vemDead = "维姆死了 - 复仇！",
} end )
local timer = {
	earliestFirstPanic = 10,
	latestFirstPanic = 20,
	panic = 20,
	
	earliestFirstVolley = 8,
	latestFirstVolley = 10,
	earliestVolley = 8,
	latestVolley = 14,
	
	heal = 2,
	enrage = 900,
}
local icon = {
	panic = "Spell_Shadow_DeathScream",
	volley = "Spell_Nature_Corrosivebreath",
	heal = "Spell_Holy_Heal",
	enrage = "Spell_Shadow_UnholyFrenzy",
	toxicVapors = "Spell_Nature_AbolishMagic",
}
local color = {
	panic = "White",
	volley = "Green",
	heal = "Yellow",
	enrage = "Black",
}
local syncName = {
	panic = "BugTrioYaujPanic"..module.revision,
	volley = "BugTrioKriVolley"..module.revision,
	heal = "BugTrioYaujHealStart"..module.revision,
	healStop = "BugTrioYaujHealStop"..module.revision,
	enrage = "BugTrioEnraged"..module.revision,
	kriDead = "BugTrioKriDead"..module.revision,
	yaujDead = "BugTrioYaujDead"..module.revision,
	vemDead = "BugTrioVemDead"..module.revision,
	allDead = "BugTrioAllDead"..module.revision,
}

local kriDead = nil
local yaujDead = nil
local vemDead = nil
local castingHeal = false

function module:OnEnable()
	self:RegisterCombatLog({"SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Panic", "PanicEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_MISSED", "SPELL_AURA_APPLIED"}, "Toxic Volley", "VolleyEvent")
	self:RegisterCombatLog("SPELL_CAST_START", "Great Heal", "HealEvent")
	self:RegisterCombatLog("SPELL_INTERRUPT", nil, "InterruptEvent")
	self:RegisterCombatLog({"SWING_DAMAGE", "SWING_MISSED"}, nil, "MeleeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Toxic Vapors", "VaporsEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Toxic Vapors", "VaporsFadeEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
	
	
	
	
	
	
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE", "EmoteEvent")--trigger_enrage
	
	
	self:ThrottleSync(5, syncName.panic)
	self:ThrottleSync(5, syncName.volley)
	self:ThrottleSync(5, syncName.heal)
	self:ThrottleSync(5, syncName.healStop)
	self:ThrottleSync(5, syncName.enrage)
	
	self:ThrottleSync(5, syncName.kriDead)
	self:ThrottleSync(5, syncName.yaujDead)
	self:ThrottleSync(5, syncName.vemDead)
	self:ThrottleSync(5, syncName.allDead)
end

function module:OnSetup()
	self.started = nil
	
end

function module:OnEngage()
	kriDead = nil
	vemDead = nil
	yaujDead = nil
	castingHeal = false
	
	if self.db.profile.panic then
		self:IntervalBar(L["bar_panic"], timer.earliestFirstPanic, timer.latestFirstPanic, icon.panic, true, color.panic)
	end
	
	if self.db.profile.volley then
		self:IntervalBar(L["bar_volley"], timer.earliestFirstVolley, timer.latestFirstVolley, icon.volley, true, color.volley)
	end
	
	if self.db.profile.enrage then
		self:Bar(L["bar_enrage"], timer.enrage, icon.enrage, true, color.enrage)
		self:DelayedMessage(timer.enrage - 60, L["msg_enrage60"], "Attention", false, nil, false)
		self:DelayedMessage(timer.enrage - 10, L["msg_enrage10"], "Attention", false, nil, false)
	end
end

function module:OnDisengage()
end

-- UNIT_DIED: each of the three (their deaths drive the death specials and the kill)
function module:UnitDied(ev)
	if ev.destName == kri then
		self:Sync(syncName.kriDead)
	elseif ev.destName == yauj then
		self:Sync(syncName.yaujDead)
	elseif ev.destName == vem then
		self:Sync(syncName.vemDead)
	end
end

function module:EmoteEvent(msg)
	if msg == L["trigger_enrage"] then
		self:Sync(syncName.enrage)
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
local trio = { [kri] = true, [yauj] = true, [vem] = true }

function module:PanicEvent(ev)
	if (ev.sourceName and trio[ev.sourceName]) or (ev.subevent == "SPELL_AURA_APPLIED" and BigWigs:IsGroupMember(ev.destFlags)) then
		self:Sync(syncName.panic)
	end
end

function module:VolleyEvent(ev)
	if (ev.sourceName and trio[ev.sourceName]) or (ev.subevent == "SPELL_AURA_APPLIED" and BigWigs:IsGroupMember(ev.destFlags)) then
		self:Sync(syncName.volley)
	end
end

function module:HealEvent(ev)
	if ev.sourceName == yauj then
		self:Sync(syncName.heal)
	end
end

-- Yauj's Great Heal cut short: an interrupt on her, or her melee starting again
function module:InterruptEvent(ev)
	if castingHeal == true and ev.destName == yauj then
		self:Sync(syncName.healStop)
	end
end

function module:MeleeEvent(ev)
	if castingHeal == true and ev.sourceName == yauj then
		self:Sync(syncName.healStop)
	end
end

function module:VaporsEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.vapors then
		self:ToxicVapors()
	end
end

function module:VaporsFadeEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.vapors then
		self:ToxicVaporsFade()
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.panic and self.db.profile.panic then
		self:Panic()
	
	elseif sync == syncName.volley and self.db.profile.volley then
		self:Volley()
	
	elseif sync == syncName.heal and self.db.profile.heal then
		self:Heal()
	elseif sync == syncName.healStop and self.db.profile.heal then
		self:HealStop()
	
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	elseif sync == syncName.kriDead then
		self:KriDead()
	elseif sync == syncName.yaujDead then
		self:YaujDead()
	elseif sync == syncName.vemDead then
		self:VemDead()
	elseif sync == syncName.allDead then
		self:SendBossDeathSync()
	end
end

function module:Volley()
	self:IntervalBar(L["bar_volley"], timer.earliestVolley, timer.latestVolley, icon.volley, true, color.volley)
end

function module:Heal()
	castingHeal = true
	
	self:Bar(L["bar_heal"], timer.heal, icon.heal, true, color.heal)
	self:Message(L["msg_heal"], "Attention", false, nil, false)
	
	if BigWigs:PlayerClass() == "ROGUE" or BigWigs:PlayerClass() == "WARRIOR" or BigWigs:PlayerClass() == "MAGE" then
		if UnitName("Target") == "Princess Yauj" then
			self:WarningSign(icon.heal, timer.heal)
			self:Sound("Beware")
		else
			self:Sound("Alert")
		end
	end
end

function module:HealStop()
	castingHeal = false
	
	self:RemoveBar(L["bar_heal"])
	self:RemoveWarningSign(icon.heal)
end

function module:Panic()
	self:RemoveBar(L["bar_panic"])
	self:Bar(L["bar_panic"], timer.panic, icon.panic, true, color.panic)
end

function module:Enrage()
	self:RemoveBar(L["bar_enrage"])
	self:Message(L["msg_enrage"], "Important", false, nil, false)
end

function module:KriDead()
	kriDead = true
	if vemDead and yaujDead then
		self:Sync(syncName.allDead)
	else
		if self.db.profile.volley then
			self:RemoveBar(L["bar_volley"])
		end
		if self.db.profile.deathspecials then
			self:Message(L["msg_kriDead"], "Positive", false, nil, false)
		end
	end
end

function module:YaujDead()
	yaujDead = true
	if vemDead and kriDead then
		self:Sync(syncName.allDead)
	else
		if self.db.profile.heal then
			self:RemoveBar(L["bar_heal"])
		end
		if self.db.profile.panic then
			self:RemoveBar(L["bar_panic"])
		end
		if self.db.profile.deathspecials then
			self:Message(L["msg_yaujDead"], "Positive", false, nil, false)
		end
	end	
end

function module:VemDead()
	vemDead = true
	if yaujDead and kriDead then
		self:Sync(syncName.allDead)
	else
		if self.db.profile.deathspecials then
			self:Message(L["msg_vemDead"], "Positive", false, nil, false)
		end
	end	
end

function module:ToxicVapors()
	self:WarningSign(icon.toxicVapors, 10)
	self:Sound("RunAway")
	self:Message(L["msg_toxicVapors"], "Urgent", false, nil, false)
end

function module:ToxicVaporsFade()
	self:RemoveWarningSign(icon.toxicVapors)
end
