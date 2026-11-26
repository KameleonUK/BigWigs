
local module, L = BigWigs:ModuleDeclaration("High Priestess Arlokk", "Zul'Gurub")
local vanished = nil

module.revision = 30078
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"phase", "mark", "whirlwind", "ravage", "gouge", "swp", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Arlokk",
	
	phase_cmd = "phase",
	phase_name = "Phase Change Alert",
	phase_desc = "Warn for Phase Change",
	
	mark_cmd = "mark",
	mark_name = "Mark of Arlokk Alert",
	mark_desc = "Warn for Mark of Arlokk",

	whirlwind_cmd = "whirlwind",
	whirlwind_name = "Whirlwind Alert",
	whirlwind_desc = "Warn for Whirlwind",

	ravage_cmd = "ravage",
	ravage_name = "Ravage Alert",
	ravage_desc = "Warn for Ravage",

	gouge_cmd = "gouge",
	gouge_name = "Gouge Alert",
	gouge_desc = "Warn for Gouge",
	
	swp_cmd = "swp",
	swp_name = "Shadow Word: Pain Alert",
	swp_desc = "Warn for Shadow Word: Pain",
	
	
	trigger_engage = "Bethekk, your priestess calls upon your might!",--CHAT_MSG_MONSTER_YELL
	
	msg_trollPhase = "Troll Phase - Casting Gouge and Shadow Word: Pain", --supposed to cast gouge in troll form only, is it the case on twow?
	msg_pantherPhase = "Panther Phase - +35% damage - Casting Backstab and Ravage",
	msg_vanishPhase = "Vanish Phase - Casting Mark of Arlokk",
	bar_return = "Re-Appear CD",
	bar_returnSoon = "Re-Appear Soon...",
	bar_nextVanish = "Next Vanish",
	bar_nestTroll = "Next Troll Phase", --need data on timer
	
	msg_mark = " is Marked!",
	bar_mark = " Marked",
	
	bar_ww = "Whirlwind CD",
	
	bar_ravage = " Ravage Stun",
	
	bar_gouge = " Gouged",
	
	bar_swp = " Shadow Word: Pain",
	msg_swp = " Shadow Word: Pain - Dispel!",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Arlokk",
	
	phase_cmd = "phase",
    phase_name = "阶段变化警报",
    phase_desc = "阶段变化时进行警告",
	
	mark_cmd = "mark",
    mark_name = "娅尔罗的印记警报",
    mark_desc = "娅尔罗的印记出现时进行警告",

	whirlwind_cmd = "whirlwind",
    whirlwind_name = "旋风斩警报",
    whirlwind_desc = "旋风斩出现时进行警告",

	ravage_cmd = "ravage",
    ravage_name = "毁灭警报",
    ravage_desc = "毁灭出现时进行警告",

	gouge_cmd = "gouge",
    gouge_name = "凿击警报",
    gouge_desc = "凿击出现时进行警告",
	
	swp_cmd = "swp",
    swp_name = "暗言术：痛警报",
    swp_desc = "暗言术：痛出现时进行警告",
	
	
	trigger_engage = "贝泰克，你的女祭司召唤你的力量！",--CHAT_MSG_MONSTER_YELL
	
    msg_trollPhase = "巨魔阶段 - 施放凿击和暗言术：痛", --supposed to cast gouge in troll form only, is it the case on twow?
    msg_pantherPhase = "豹形阶段 - 伤害增加35% - 施放背刺和毁灭",
    msg_vanishPhase = "消失阶段 - 施放娅尔罗的印记",
    bar_return = "重新出现冷却",
    bar_returnSoon = "即将重新出现...",
    bar_nextVanish = "下一次消失",
    bar_nestTroll = "下一次巨魔阶段", --need data on timer
	
    msg_mark = " 被标记！",
    bar_mark = " 标记",
	
    bar_ww = "旋风斩冷却",
	
    bar_ravage = " 毁灭昏迷",
	
    bar_gouge = " 被凿击",
	
    bar_swp = " 暗言术：痛",
    msg_swp = " 暗言术：痛 - 驱散！",
    you = "你",
    clickme = " >点击我<",
} end )
local timer = {
	firstVanish = 35,
	vanish = 75,
	
	unvanish = 35,
	unvanishSoon = 15,
	
	mark = 120,
	
	ww = 16,
	
	ravage = 2,
	
	gouge = 4,
	
	swp = 18,
}
local icon = {
	vanish = "Ability_Vanish",
	mark = "Ability_Hunter_Snipershot",
	ww = "Ability_Whirlwind",
	ravage = "spell_frost_stun",
	gouge = "ability_gouge",
	swp = "spell_shadow_shadowwordpain",
}
local color = {
	phase = "White",
	ww = "Blue",
	mark = "Green",
	ravage = "Black",
	gouge = "Red",
	swp = "Magenta",
}
local syncName = {
	vanishPhase = "ArlokkPhaseVanish"..module.revision,
	pantherPhase = "ArlokkPhasePanther"..module.revision,
	
	mark = "ArlokkMark"..module.revision,
	markFade = "ArlokkMarkFade"..module.revision,
	
	ww = "ArlokkWhirlwind"..module.revision,
	
	ravage = "ArlokkRavage"..module.revision,
	ravageFade = "ArlokkRavageFade"..module.revision,
	
	gouge = "ArlokkGouge"..module.revision,
	gougeFade = "ArlokkGougeFade"..module.revision,
	
	swp = "ArlokkSwp"..module.revision,
	swpFade = "ArlokkSwpFade"..module.revision,
}

module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {24210, "Mark of Arlokk"}, "MarkEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {24210, "Mark of Arlokk"}, "MarkFadeEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "Whirlwind", "WhirlwindEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Ravage", "RavageEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Ravage", "RavageFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Gouge", "GougeEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Gouge", "GougeFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Shadow Word: Pain", "ShadowWordPainEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Shadow Word: Pain", "ShadowWordPainFadeEvent")
	
		
	
	
	self:ThrottleSync(3, syncName.vanishPhase)
	self:ThrottleSync(3, syncName.pantherPhase)
	
	self:ThrottleSync(5, syncName.mark)
	self:ThrottleSync(5, syncName.markFade)
	
	self:ThrottleSync(5, syncName.ww)
	
	self:ThrottleSync(5, syncName.ravage)
	self:ThrottleSync(1, syncName.ravageFade)
	
	self:ThrottleSync(5, syncName.gouge)
	self:ThrottleSync(1, syncName.gougeFade)
	
	self:ThrottleSync(5, syncName.swp)
	self:ThrottleSync(1, syncName.swpFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	vanished = nil
	
	self:ScheduleRepeatingEvent("CheckVanish", self.CheckVanish, 1, self)
	
	if self.db.profile.phase then
		self:Bar(L["bar_nextVanish"], timer.firstVanish, icon.vanish, true, color.phase)
		self:Message(L["msg_trollPhase"], "Important", false, nil, false)
	end
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:MarkEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mark .. " " .. ev.destName)
	end
end

function module:MarkFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.markFade .. " " .. ev.destName)
	end
end

function module:WhirlwindEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.ww)
	end
end

function module:RavageEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.ravage .. " " .. ev.destName)
	end
end

function module:RavageFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.ravageFade .. " " .. ev.destName)
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

function module:ShadowWordPainEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.swp .. " " .. ev.destName)
	end
end

function module:ShadowWordPainFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.swpFade .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.pantherPhase then
		self:PantherPhase()
	elseif sync == syncName.vanishPhase then
		self:VanishPhase()
	
	elseif sync == syncName.mark and rest and self.db.profile.mark then
		self:Mark(rest)
	elseif sync == syncName.markFade and rest and self.db.profile.mark then
		self:MarkFade(rest)
	
	elseif sync == syncName.ww and self.db.profile.whirlwind then
		self:Whirlwind()
		
	elseif sync == syncName.ravage and rest and self.db.profile.ravage then
		self:Ravage(rest)
	elseif sync == syncName.ravageFade and rest and self.db.profile.ravage then
		self:RavageFade(rest)
		
	elseif sync == syncName.gouge and rest and self.db.profile.gouge then
		self:Gouge(rest)
	elseif sync == syncName.gougeFade and rest and self.db.profile.gouge then
		self:GougeFade(rest)
		
	elseif sync == syncName.swp and rest and self.db.profile.swp then
		self:Swp(rest)
	elseif sync == syncName.swpFade and rest and self.db.profile.swp then
		self:SwpFade(rest)
	end
end

function module:PantherPhase()
	vanished = false
	
	self:CancelScheduledEvent("checkunvanish")
	
	if self.db.profile.phase then
		self:RemoveBar(L["bar_return"])
		self:Bar(L["bar_nextVanish"], timer.vanish, icon.vanish, true, color.phase)
		self:Message(L["msg_pantherPhase"], "Attention", false, nil, false)
		
		--how long until she goes back to troll phase?
		--is it the same after the 2nd vanish?
		--need data, we kill her too fast...
	end

	if not vanished then
		self:ScheduleRepeatingEvent("CheckVanish", self.CheckVanish, 0.5, self)
	end
end

function module:VanishPhase()
	vanished = true
	
	self:CancelScheduledEvent("CheckVanish")
	
	self:RemoveBar(L["bar_ww"])
	
	if self.db.profile.phase then
		self:Message(L["msg_vanishPhase"], "Attention")
	end
	
	if self.db.profile.phase then
		self:RemoveBar(L["bar_nextVanish"])
		self:Bar(L["bar_return"], timer.unvanish, icon.vanish, true, color.phase)
		self:DelayedBar(timer.unvanish, L["bar_returnSoon"], timer.unvanishSoon, icon.vanish, true, color.phase)
	end
	
	self:ScheduleRepeatingEvent("checkunvanish", self.CheckUnvanish, 0.5, self)
end

function module:CheckUnvanish()
	if module:IsArlokkVisible() then
		self:Sync(syncName.pantherPhase)
	end
end
function module:CheckVanish()
	if not module:IsArlokkVisible() then
		self:Sync(syncName.vanishPhase)
	end
end
	function module:IsArlokkVisible()
		if UnitName("PlayerTarget") == "High Priestess Arlokk" then
			return true
		else
			for i=1,GetNumRaidMembers() do
				if UnitName("Raid"..i.."Target") == "High Priestess Arlokk" then
					return true
				end
			end
		end

		return false
	end

function module:Mark(rest)
	self:Message(rest..L["msg_mark"], "Attention")

	self:Bar(rest..L["bar_mark"].. " >Click Me<", timer.mark, icon.mark, true, color.mark)
	self:SetCandyBarOnClick("BigWigsBar "..rest..L["bar_mark"].. " >Click Me<", function(name, button, extra) TargetByName(extra, true) end, rest)

	if (IsRaidLeader() or IsRaidOfficer()) then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == rest then
				SetRaidTarget("raid"..i, 8)
			end
		end
	end
end

function module:MarkFade(rest)
	self:RemoveBar(rest..L["bar_mark"].. " >Click Me<")
	
	if (IsRaidLeader() or IsRaidOfficer()) then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == rest then
				SetRaidTarget("raid"..i, 0)
			end
		end
	end
end

function module:Whirlwind()
	self:Bar(L["bar_ww"], timer.ww, icon.ww, true, color.ww)
end

function module:Ravage(rest)
	self:Bar(rest..L["bar_ravage"], timer.ravage, icon.ravage, true, color.ravage)
end

function module:RavageFade(rest)
	self:RemoveBar(rest..L["bar_ravage"])
end

function module:Gouge(rest)
	self:Bar(rest..L["bar_gouge"], timer.gouge, icon.gouge, true, color.gouge)
end

function module:GougeFade(rest)
	self:RemoveBar(rest..L["bar_gouge"])
end

function module:Swp(rest)
	self:Bar(rest..L["bar_swp"], timer.swp, icon.swp, true, color.swp)
	
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "PALADIN" then
		self:Message(rest..L["msg_swp"], "Personal", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.swp, 0.7)
	end
end

function module:SwpFade(rest)
	self:RemoveBar(rest..L["bar_swp"])
end
