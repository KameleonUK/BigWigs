local module, L = BigWigs:ModuleDeclaration("Qiraji Brainwasher", "Ahn'Qiraj")

module.revision = 30075
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = { "mc", "mindflay" }
module.trashMod = true
module.defaultDB = {
	bosskill = nil,
}

L:RegisterTranslations("enUS", function()
	return {
		cmd = "BrainWasher",

		mc_cmd = "mc",
		mc_name = "Mind Control Alert",
		mc_desc = "Warn for Mind Control",

		mindflay_cmd = "mindflay",
		mindflay_name = "Mind Flay Alert",
		mindflay_desc = "Warn for Mind Flay",


		bar_mc = " MC",

		bar_mindFlay = " Mind Flay",

		["You have slain %s!"] = true,
	}
end)


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "BrainWasher",

    mc_cmd = "mc",
    mc_name = "精神控制警报",
    mc_desc = "精神控制出现时进行警告",

    mindflay_cmd = "mindflay",
    mindflay_name = "心灵震爆警报",
    mindflay_desc = "心灵震爆出现时进行警告",


    bar_mc = " 精神控制",

    bar_mindFlay = " 精神鞭笞（死缠效果）",

    ["You have slain %s!"] = "你已经击败了%s！",
    clickme = " >点击我<",
    you = "你",
} end )
local timer = {
	mc = 10,
	mindFlay = 8,
}
local icon = {
	mc = "spell_shadow_shadowworddominate",
	mindFlay = "spell_shadow_siphonmana",
}
local color = {
	mc = "Black",
	mindFlay = "Blue",
}
local syncName = {
	mc = "BrainwasherMc" .. module.revision,
	mcFade = "BrainwasherMcFade" .. module.revision,
	mindFlay = "BrainwasherMindFlay" .. module.revision,
	mindFlayFade = "BrainwasherMindFlayFade" .. module.revision,
}

function module:OnEnable()
	

	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Cause Insanity", "McEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Cause Insanity", "McFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Mind Flay", "MindFlayEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Mind Flay", "MindFlayFadeEvent")




	self:ThrottleSync(1, syncName.mc)
	self:ThrottleSync(0.2, syncName.mcFade)
	self:ThrottleSync(1, syncName.mindFlay)
	self:ThrottleSync(0.2, syncName.mindFlayFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.core:IsModuleActive("Anubisath Sentinel", "Ahn'Qiraj") then
		self.core:DisableModule("Anubisath Sentinel", "Ahn'Qiraj")
	end
end

function module:OnDisengage()
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

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.mc and rest and self.db.profile.mc then
		self:Mc(rest)
	elseif sync == syncName.mcFade and rest and self.db.profile.mc then
		self:McFade(rest)

	elseif sync == syncName.mindFlay and rest and self.db.profile.mindflay then
		self:MindFlay(rest)
	elseif sync == syncName.mindFlayFade and rest and self.db.profile.mindflay then
		self:MindFlayFade(rest)
	end
end

function module:Mc(rest)
	self:Bar(rest .. L["bar_mc"] .. " >Click Me<", timer.mc, icon.mc, true, color.mc)
	self:SetCandyBarOnClick("BigWigsBar " .. rest .. L["bar_mc"] .. " >Click Me<", function(name, button, extra)
		TargetByName(extra, true)
	end, rest)

	if IsRaidLeader() or IsRaidOfficer() then
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid" .. i) == rest then
				SetRaidTargetIcon("raid" .. i, 6)
			end
		end
	end
end

function module:McFade(rest)
	self:RemoveBar(rest .. L["bar_mc"] .. " >Click Me<")

	if IsRaidLeader() or IsRaidOfficer() then
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid" .. i) == rest then
				SetRaidTargetIcon("raid" .. i, 0)
			end
		end
	end
end

function module:MindFlay(rest)
	self:Bar(rest .. L["bar_mindFlay"], timer.mindFlay, icon.mindFlay, true, color.mindFlay)
end

function module:MindFlayFade(rest)
	self:RemoveBar(rest .. L["bar_mindFlay"])
end
