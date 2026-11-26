
local module, L = BigWigs:ModuleDeclaration("Qiraji Mindslayer", "Ahn'Qiraj")

module.revision = 30075
module.combatLog = true -- triggers from the combat log; a kill does not end the module (as before)
module.enabletrigger = module.translatedName
module.toggleoptions = {"mc", "mindflay", "disorient"}
module.trashMod = true
module.defaultDB = {
	bosskill = nil,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Mindslayer",

	mc_cmd = "mc",
	mc_name = "Mind Control Alert",
	mc_desc = "Warn for Mind Control",
	
	mindflay_cmd = "mindflay",
	mindflay_name = "Mind Flay Alert",
	mindflay_desc = "Warn for Mind Flay",
	
	disorient_cmd = "disorient",
	disorient_name = "Mana Burn Disorient Alert",
	disorient_desc = "Warn for Mana Burn Disorient",
	
	
	bar_mc = " MC",
	msg_mc = "MC on ",

	bar_mindFlay = " Mind Flay",
	
	bar_disorient = "Mana Burn & Disorient",
	msg_disorientSoon = "Qiraji Mindslayer < 20% HP - 30 Yards Mana Burn & Disorient Soon!",
	
	["You have slain %s!"] = true,
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Mindslayer",

    mc_cmd = "mc",
    mc_name = "精神控制警报",
    mc_desc = "精神控制出现时进行警告",

    mindflay_cmd = "mindflay",
    mindflay_name = "精神鞭笞警报",
    mindflay_desc = "精神鞭笞出现时进行警告",

    disorient_cmd = "disorient",
    disorient_name = "法力燃烧&迷惑警报",
    disorient_desc = "法力燃烧&迷惑出现时进行警告",


    bar_mc = " 精神控制",
    msg_mc = "精神控制在 ",

    bar_mindFlay = " 精神鞭笞",

    bar_disorient = "法力燃烧&迷惑",
    msg_disorientSoon = "其拉斩灵者血量 < 20% HP - 即将出现30码范围法力燃烧&迷惑！",

    ["You have slain %s!"] = "你已经击败了%s！",
    clickme = " >点击我！<",
    you = "你",
} end )
local timer = {
	mc = 9.5,
	mindFlay = 8,
	disorient = 8,
}
local icon = {
	mc = "Spell_Shadow_Charm",
	mindFlay = "spell_shadow_siphonmana",
	disorient = "spell_shadow_manaburn",
}
local color = {
	mc = "Red",
	mindFlay = "Black",
	disorient = "Cyan",
}
local syncName = {
	mc = "MindslayerMC"..module.revision,
	mcFade = "MindslayerMCEnd"..module.revision,
	mindFlay = "MindslayerMindFlay"..module.revision,
	mindFlayFade = "MindslayerMindFlayEnd"..module.revision,
	disorient = "MindslayerDisorient"..module.revision,
	disorientSoon = "MindslayerDisorientSoon"..module.revision,
}

local disorientSoonCheck = nil

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Cause Insanity", "McEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Cause Insanity", "McFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Mind Flay", "MindFlayEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Mind Flay", "MindFlayFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Mana Burn", "DisorientEvent")
	
	
	
	self:RegisterEvent("UNIT_HEALTH")
	
	
	self:ThrottleSync(1, syncName.mc)
	self:ThrottleSync(1, syncName.mcFade)
	self:ThrottleSync(1, syncName.mindFlay)
	self:ThrottleSync(1, syncName.mindFlayFade)
	self:ThrottleSync(1, syncName.disorient)
	self:ThrottleSync(5, syncName.disorientSoon)
end

function module:OnSetup()
	self.started = nil
	
end

function module:OnEngage()
	if self.core:IsModuleActive("Qiraji Brainwasher", "Ahn'Qiraj") then self.core:DisableModule("Qiraji Brainwasher", "Ahn'Qiraj") end
	if self.core:IsModuleActive("The Prophet Skeram", "Ahn'Qiraj") then self.core:DisableModule("The Prophet Skeram", "Ahn'Qiraj") end
	
	disorientSoonCheck = true
end

function module:OnDisengage()
	disorientSoonCheck = true
end

function module:BossUnitDied(ev)
end

function module:UNIT_HEALTH(msg)
	if UnitName(msg) == self.translatedName and disorientSoonCheck == true then
		local healthPct = UnitHealth(msg) * 100 / UnitHealthMax(msg)
		if healthPct < 20 then
			self:Sync(syncName.disorientSoon)
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:McEvent(ev)
	if ev.destName then
		self:Sync(syncName.mc .. " " .. ev.destName)
	end
end

function module:McFadeEvent(ev)
	if ev.destName then
		self:Sync(syncName.mcFade .. " " .. ev.destName)
	end
end

function module:MindFlayEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mindFlay .. " " .. ev.destName)
	end
end

function module:MindFlayFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.mindFlayFade .. " " .. ev.destName)
	end
end

function module:DisorientEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.disorient)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.mc and rest and self.db.profile.mc then
		self:Mc(rest)
	elseif sync == syncName.mcFade and rest and self.db.profile.mc then
		self:McFade(rest)
		
	elseif sync == syncName.mindFlay and rest and self.db.profile.mindflay then
		self:MindFlay(rest)
	elseif sync == syncName.mindFlayFade and rest and self.db.profile.mindflay then
		self:MindFlayFade(rest)
		
	elseif sync == syncName.disorient and self.db.profile.disorient then
		self:Disorient()
	elseif sync == syncName.disorientSoon and self.db.profile.disorient then
		self:DisorientSoon()
	end
end


function module:Mc(rest)
	self:Bar(rest..L["bar_mc"].." >Click Me<", timer.mc, icon.mc, true, color.mc)
	self:SetCandyBarOnClick("BigWigsBar "..rest..L["bar_mc"].. " >Click Me<", function(name, button, extra) TargetByName(extra, true) end, rest)
	self:Message(L["msg_mc"]..rest, "Attention", false, nil, false)
	
	if IsRaidLeader() or IsRaidOfficer() then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == rest then
				SetRaidTarget("raid"..i, 4)
			end
		end
	end
	
	if BigWigs:PlayerClass() == "MAGE" then
		self:WarningSign(icon.mc, 1)
		self:Sound("Info")
	end
end

function module:McFade(rest)
	self:RemoveBar(rest..L["bar_mc"].. " >Click Me<")
	
	if IsRaidLeader() or IsRaidOfficer() then
		for i=1,GetNumRaidMembers() do
			if UnitName("raid"..i) == rest then
				SetRaidTargetIcon("raid"..i, 0)
			end
		end
	end
end

function module:MindFlay(rest)
	self:Bar(rest..L["bar_mindFlay"], timer.mindFlay, icon.mindFlay, true, color.mindFlay)
end

function module:MindFlayFade(rest)
	self:RemoveBar(rest..L["bar_mindFlay"])
end

function module:Disorient()
	self:Bar(L["bar_disorient"], timer.disorient, icon.disorient, true, color.disorient)
end

function module:DisorientSoon()
	disorientSoonCheck = nil
	
	self:Message(L["msg_disorientSoon"], "Urgent", false, nil, false)
	self:ScheduleEvent("EnableDisorientSoonCheck", self.EnableDisorientSoonCheck, 5, self)
end

function module:EnableDisorientSoonCheck()
	disorientSoonCheck = true
end
