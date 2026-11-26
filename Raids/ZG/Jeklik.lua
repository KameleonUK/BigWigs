
local module, L = BigWigs:ModuleDeclaration("High Priestess Jeklik", "Zul'Gurub")

module.revision = 30083
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"heal", "fear", "fire", "mindflay", "silence", "swarm", "phase", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Jeklik",

	heal_cmd = "heal",
	heal_name = "Heal Alert",
	heal_desc = "Warn for healing",
	
	fear_cmd = "fear",
	fear_name = "Fear Alert",
	fear_desc = "Warn for Fears",
	
	fire_cmd = "fire",
	fire_name = "Fire Bat Alert",
	fire_desc = "Warn for Standing in Fire",
	
	mindflay_cmd = "mindflay",
	mindflay_name = "Mind Flay Alert",
	mindflay_desc = "Warn for casting Mind Flay",

	silence_cmd = "silence",
	silence_name = "Silence Alert",
	silence_desc = "Warn for Silence",

	swarm_cmd = "swarm",
	swarm_name = "Bat Swarm Alert",
	swarm_desc = "Warn for Bat swarms",
	
	phase_cmd = "phase",
	phase_name = "Phase Notification",
	phase_desc = "Announces the boss' phase transition",
	
	
	trigger_engage = "Lord Hir'eek, grant me wings of vengance!",--CHAT_MSG_MONSTER_YELL
	
	bar_healCast = "Heal - Interrupt!",
	bar_healCd = "Heal CD",
	msg_healCast = "Heal! Interrupt it!",
	
	
	--this happens in P1
	
	--guessing this happens in P2

	bar_fearCd = "Fear CD",
	
	msg_liquidFire = "Move away from Fire!",
	
		--mindflay chains, this trigger is unreliable
	--trigger_mindflayFade = "Mind Flay fades",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_mindflay = "Mind Flay - Interrupt!",
	
	bar_silenceAfflicted = "People Silenced",
	bar_silenceCd = "Silence CD",
	
	bar_swam = "Bat Swarm",
	msg_swarm = "Swarm of Bats! AoE!",
	
	msg_p2 = "Phase 2",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Jeklik",

	heal_cmd = "heal",
    heal_name = "治疗警报",
    heal_desc = "治疗时进行警告",
	
	fear_cmd = "fear",
    fear_name = "恐惧警报",
    fear_desc = "恐惧出现时进行警告",
	
	fire_cmd = "fire",
    fire_name = "火蝠警报",
    fire_desc = "站在火中的警告",
	
	mindflay_cmd = "mindflay",
    mindflay_name = "精神鞭笞警报",
    mindflay_desc = "施放精神鞭笞时进行警告",

	silence_cmd = "silence",
    silence_name = "沉默警报",
    silence_desc = "沉默时进行警告",

	swarm_cmd = "swarm",
    swarm_name = "蝙蝠群警报",
    swarm_desc = "蝙蝠群出现时进行警告",
	
	phase_cmd = "phase",
    phase_name = "阶段通知",
    phase_desc = "Boss阶段转换时进行警告",
	
	
	trigger_engage = "Lord Hir'eek, grant me wings of vengance!",--CHAT_MSG_MONSTER_YELL
	
    bar_healCast = "治疗 - 打断！",
    bar_healCd = "治疗冷却",
    msg_healCast = "治疗！打断它！",
	
	
	--this happens in P1
	
	--guessing this happens in P2

    bar_fearCd = "恐惧冷却",
	
    msg_liquidFire = "远离火焰！",
	
		--mindflay chains, this trigger is unreliable
	--trigger_mindflayFade = "Mind Flay fades",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_mindflay = "精神鞭笞 - 打断！",
	
    bar_silenceAfflicted = "被沉默",
    bar_silenceCd = "沉默冷却",
	
    bar_swam = "蝙蝠群",
    msg_swarm = "蝙蝠群！AOE！",
	
    msg_p2 = "第二阶段",
} end )
local timer = {
	healCast = 4,
	healCd = 20,--need data

	firstTerrifyingScreechCd = 18,--need data
	terrifyingScreechCd = 30,--need data
	psychicScreamCd = 39.5,--need data
	
	mindflay = 25,--need data
	
	firstSilence = 12,--need data
	silenceCd = 10,--20cd -10afflicted
	silenceAfflicted = 10,
	
	swarm = 45,--need data
}
local icon = {
	heal = "Spell_Holy_Heal",
	terrifyingScreech = "Spell_Shadow_SummonImp",
	psychicScream = "Spell_Shadow_PsychicScream",
	liquidFire = "spell_fire_incinerate",
	mindflay = "Spell_Shadow_SiphonMana",
	silence = "spell_shadow_teleport",
	swarm = "ability_hunter_pet_bat",
}
local color = {
	healCast = "Green",
	healCd = "White",
	fearCd = "Blue",
	mindflay = "Orange",
	silenceCd = "Black",
	silenceAfflicted = "Cyan",
	swarm = "Red",
}
local syncName = {
	heal = "JeklikHeal"..module.revision,
	healOver = "JeklikHealStop"..module.revision,
	terrifyingScreech = "JeklikTerrifyingScreech"..module.revision,
	psychicScream = "JeklikPsychicScream"..module.revision,
	mindflay = "Jeklikmindflay"..module.revision,
	mindflayFade = "JeklikmindflayEnd2"..module.revision,
	silence = "JeklikSilence"..module.revision,
	swarm = "JeklikSwarmBats"..module.revision,
	phase = "JeklikPhase"..module.revision,
}

module:RegisterYellEngage(L["trigger_engage"])

local phase2 = nil
local castingHeal = nil
local castingMindFlay = nil

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog("SPELL_CAST_START", "Great Heal", "HealEvent")
	self:RegisterCombatLog("SPELL_INTERRUPT", nil, "InterruptEvent")
	self:RegisterCombatLog({"SWING_DAMAGE", "SWING_MISSED"}, nil, "MeleeEvent")
	self:RegisterCombatLog({"SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Terrifying Screech", "ScreechEvent")
	self:RegisterCombatLog({"SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Psychic Scream", "PsychicScreamEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE"}, "Liquid Fire", "LiquidFireEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Mind Flay", "MindFlayEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Mind Flay", "MindFlayFadeEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Sonic Burst", "SonicBurstEvent")
		
	
	
	
	
	
	
	self:RegisterEvent("UNIT_HEALTH")


	self:ThrottleSync(4, syncName.heal)
	self:ThrottleSync(4, syncName.healOver)
	
	self:ThrottleSync(10, syncName.terrifyingScreech)
	self:ThrottleSync(10, syncName.psychicScream)
	
	self:ThrottleSync(1.5, syncName.mindflay)
	self:ThrottleSync(1.5, syncName.mindflayFade)
	
	self:ThrottleSync(5, syncName.silence)
	
	self:ThrottleSync(5, syncName.swarm)
	self:ThrottleSync(10, syncName.phase)
end

function module:OnSetup()
end

function module:OnEngage()
	phase2 = nil
	castingHeal = nil
	castingMindFlay = nil
	
	if self.db.profile.fear then
		self:Bar(L["bar_fearCd"], timer.firstTerrifyingScreechCd, icon.terrifyingScreech, true, color.fearCd)
	end
	
	if self.db.profile.silence then
		self:Bar(L["bar_silenceCd"], timer.firstSilence, icon.silence, true, color.silenceCd)
	end

	if self.db.profile.swarm then
		self:Bar(L["bar_swam"], timer.swarm, icon.swarm, true, color.swarm)
	end
end

function module:OnDisengage()
end

function module:UNIT_HEALTH(msg)
	if UnitName(msg) == module.translatedName then
		local healthPct = UnitHealth(msg) * 100 / UnitHealthMax(msg)
		if healthPct <= 50 and not phase2 then
			self:Sync(syncName.phase)
			phase2 = true
			
		elseif healthPct > 50 and phase2 then
			phase2 = nil
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:HealEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.heal)
	end
end

-- Great Heal or Mind Flay cut short: an interrupt on her, or her melee starting again
local function CastOver(self)
	if castingHeal == true then
		self:Sync(syncName.healOver)
	elseif castingMindFlay == true then
		self:Sync(syncName.mindflayFade)
	end
end

function module:InterruptEvent(ev)
	if ev.destName == self.translatedName then
		CastOver(self)
	end
end

function module:MeleeEvent(ev)
	if ev.sourceName == self.translatedName then
		CastOver(self)
	end
end

function module:ScreechEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.terrifyingScreech)
	end
end

function module:PsychicScreamEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.psychicScream)
	end
end

function module:LiquidFireEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.fire then
		self:LiquidFire()
	end
end

-- her Mind Flay on a raid member (a priest's Mind Flay is on a mob, so it is skipped)
function module:MindFlayEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mindflay)
	end
end

function module:MindFlayFadeEvent(ev)
	if castingMindFlay == true and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mindflayFade)
	end
end

function module:SonicBurstEvent(ev)
	if true then
		self:Sync(syncName.silence)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.heal and self.db.profile.heal then
		self:Heal()
	elseif sync == syncName.healOver and self.db.profile.heal then
		self:HealOver()
	elseif sync == syncName.terrifyingScreech and self.db.profile.fear then
		self:TerrifyingScreech()
	elseif sync == syncName.psychicScream and self.db.profile.fear then
		self:PsychicScream()
	elseif sync == syncName.mindflay and self.db.profile.mindflay then
		self:MindFlay()
	elseif sync == syncName.mindflayFade and self.db.profile.mindflay then
		self:MindFlayFade()
	elseif sync == syncName.silence and self.db.profile.silence then
		self:Silence()
	elseif sync == syncName.swarm and self.db.profile.swarm then
		self:Swarm()
	elseif sync == syncName.phase then
		self:Phase()
	end
end


function module:Heal()
	castingHeal = true
	self:Bar(L["bar_healCast"], timer.healCast, icon.heal, true, color.healCast)
	self:Message(L["msg_healCast"], "Positive", false, nil, false)
	
	if BigWigs:PlayerClass() == "MAGE" then
		self:Sound("Beware")
		self:WarningSign(icon.heal, 0.7)
	elseif BigWigs:PlayerClass() == "WARRIOR" then
		self:Sound("Beware")
		self:WarningSign(icon.heal, timer.healCast)
	elseif BigWigs:PlayerClass() == "ROGUE" then
		self:Sound("Beware")
		self:WarningSign(icon.heal, timer.healCast)
	end
end

function module:HealOver()
	castingHeal = nil
	self:RemoveBar(L["bar_healCast"])
	self:RemoveWarningSign(icon.heal)
end

function module:TerrifyingScreech()
	self:Bar(L["bar_fearCd"], timer.terrifyingScreechCd, icon.terrifyingScreech, true, color.fearCd)
end

function module:PsychicScream()
	self:Bar(L["bar_fearCd"], timer.psychicScreamCd, icon.psychicScream, true, color.fearCd)
end

function module:LiquidFire()
	self:Message(L["msg_liquidFire"], "Urgent", false, nil, false)
	self:Sound("Info")
	self:WarningSign(icon.liquidFire, 0.7)
end

function module:MindFlay()
	castingMindFlay = true
	self:Bar(L["bar_mindflay"], timer.mindflay, icon.mindflay, true, color.mindflay)
	
	if BigWigs:PlayerClass() == "MAGE" then
		self:Sound("Alarm")
		self:WarningSign(icon.mindflay, 0.7)
	elseif BigWigs:PlayerClass() == "WARRIOR" then
		self:Sound("Alarm")
		self:WarningSign(icon.mindflay, timer.mindflay)
	elseif BigWigs:PlayerClass() == "ROGUE" then
		self:Sound("Alarm")
		self:WarningSign(icon.mindflay, timer.mindflay)
	end
end

function module:MindFlayFade()
	castingMindFlay = nil
	self:RemoveBar(L["bar_mindflay"])
	self:RemoveWarningSign(icon.heal)
end

function module:Silence()
	self:Bar(L["bar_silenceAfflicted"], timer.silenceAfflicted, icon.silence, true, color.silenceAfflicted)
	self:DelayedBar(timer.silenceAfflicted, L["bar_silenceCd"], timer.silenceCd, icon.silence, true, color.silenceCd)
end

function module:Swarm()
	self:RemoveBar(L["bar_swam"])
	self:Message(L["msg_swarm"], "Urgent", false, nil, false)
end

function module:Phase()
	phase2 = true
	
	if self.db.profile.phase then
		self:Message(L["msg_p2"])
		
		self:RemoveBar(L["bar_fearCd"])
		self:RemoveBar(L["bar_silenceCd"])
		self:RemoveBar(L["bar_swam"])
		
		self:CancelDelayedBar(L["bar_silenceCd"])
	end
end
