
local module, L = BigWigs:ModuleDeclaration("Ayamiss the Hunter", "Ruins of Ahn'Qiraj")
local p2 = nil -- true once phase 2 has started

module.revision = 30069
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"bigicon", "sacrifice", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Ayamiss",

	sacrifice_cmd = "sacrifice",
	sacrifice_name = "Sacrifice Alert",
	sacrifice_desc = "Warn for Sacrifice",
	
	bigicon_cmd = "bigicons",
	bigicon_name = "Kill the larva icon alert",
	bigicon_desc = "Shows a big icon when a larva spawns",
	
	
	
	larva_bar = "Larva >Click Me!<",
	nextlarva_bar = "Larva/Sacrifice CD",
	
	msg_sacrifice = " Sacrificed, Kill the larva!",
	
	p2_msg = "Phase 2",

	larvaname = "Hive'Zara Larva",	
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "Ayamiss",

	sacrifice_cmd = "sacrifice",
	sacrifice_name = "祭品警报",
	sacrifice_desc = "被作为祭品时进行警告",
	
	bigicon_cmd = "bigicons",
	bigicon_name = "击杀幼虫时显示图标警报",
	bigicon_desc = "当幼虫产生时显示大图标警告",
	
	
	
	larva_bar = "幼虫 >点我!<",
	nextlarva_bar = "幼虫/牺牲冷却",
	
	msg_sacrifice = " 牺牲，击杀幼虫!",
	
	p2_msg = "第二阶段",

	larvaname = "札拉幼虫",	
} end )
local timer = {
	sacrifice = 10,
	larvacd = 14,
}

local icon = {
	sacrifice = "ability_creature_poison_05",
}

local syncName = {
	sacrifice = "AyamissSacrifice"..module.revision,
	p2 = "AyamissP2"..module.revision,
	larvaend = "AyamissLarvaEnd"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Paralyze", "ParalyzeEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Paralyze", "ParalyzeFadeEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	self:RegisterEvent("UNIT_HEALTH")
	
	self:ThrottleSync(5, syncName.sacrifice)
	self:ThrottleSync(5, syncName.p2)
	self:ThrottleSync(3, syncName.larvaend)
end

function module:OnSetup()
end

function module:OnEngage()
	p2 = nil
	self:Bar(L["nextlarva_bar"], timer.larvacd, icon.sacrifice, true, "white")
end

function module:OnDisengage()
end

-- UNIT_DIED: the larva reaching nobody (Ayamiss's own death comes from the core)
function module:UnitDied(ev)
	if ev.destName == L["larvaname"] then
		self:Sync(syncName.larvaend)
	end
end

function module:UNIT_HEALTH(arg1)
	if UnitName(arg1) == module.translatedName then
		local health = UnitHealth(arg1)
		local maxHealth = UnitHealthMax(arg1)
		if math.ceil(100*health/maxHealth) > 65 and math.ceil(100*health/maxHealth) <= 70 and not p2 then
			self:Sync(syncName.p2)
			p2 = true
		elseif math.ceil(100*health/maxHealth) > 70 and p2 then
			p2 = nil
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:ParalyzeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.sacrifice .. " " .. ev.destName)
	end
end

function module:ParalyzeFadeEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.larvaend)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.sacrifice and rest and self.db.profile.sacrifice then
		self:Sacrifice(rest)
	elseif sync == syncName.p2 then
		self:Phase2()
	elseif sync == syncName.larvaend and self.db.profile.sacrifice then
		self:LarvaEnd()
	end
end

function module:Sacrifice(rest)
	self:Message(rest..L["msg_sacrifice"], "Urgent", false, "Beware")
	self:Bar(L["larva_bar"], timer.larva, icon.sacrifice, true, "red")
	self:SetCandyBarOnClick("BigWigsBar "..L["larva_bar"], function(name, button, extra) TargetByName("Hive'Zara Larva", true) end, rest)
	
	if self.db.profile.bigicon then
		self:WarningSign(icon.sacrifice, 0.7)
	end
	
	local bwPlayerIsAttacking = nil
	if IsRaidLeader() or IsRaidOfficer() then
		if BigWigs:PlayerClass() ~= "ROGUE" and BigWigs:PlayerClass() ~= "DRUID" then
			if PlayerFrame.inCombat then
				bwPlayerIsAttacking = true
			end
			
			TargetByName(rest,true)
			SetRaidTarget("target",8)
			TargetLastTarget()
			if bwPlayerIsAttacking then
				AttackTarget()
			end
		end
	end
	
	self:Bar(L["nextlarva_bar"], timer.larvacd, icon.sacrifice, true, "white")
end

function module:Phase2()
	self:Message(L["p2_msg"], "Attention")
	p2 = true
end

function module:LarvaEnd()
	self:RemoveBar(L["larva_bar"])
end