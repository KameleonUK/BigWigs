
local module, L = BigWigs:ModuleDeclaration("Kurinnaxx", "Ruins of Ahn'Qiraj")

module.revision = 30069
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"wound", "trap", "enrage", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Kurinnaxx",
	
	wound_cmd = "wound",
	wound_name = "Wound Alerts",
	wound_desc = "Warn for Mortal Wounds",
	
	trap_cmd = "trap",
	trap_name = "Trap Alerts",
	trap_desc = "Timer bars for everyone hit by a trap",
	
	enrage_cmd = "enrage",
	enrage_name = "Enrage Alerts",
	enrage_desc = "Warn for Enrage",
	
	
	msg_sandTrap = "Sand Trap",
	bar_trap = " Sand Trap",
	
	bar_wound = " Wounds",

	msg_enrage = "Kurinnaxx is Enraged!",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Kurinnaxx",

    wound_cmd = "wound",
    wound_name = "重伤警报",
    wound_desc = "重伤出现时进行警告",

    trap_cmd = "trap",
    trap_name = "陷阱警报",
    trap_desc = "为每个中陷阱的玩家显示计时条",

    enrage_cmd = "enrage",
    enrage_name = "激怒警报",
    enrage_desc = "激怒出现时进行警告",
    
    
    msg_sandTrap = "沙尘陷阱",
    bar_trap = " 沙尘陷阱",
    
    bar_wound = " 重伤",

    msg_enrage = "库林纳克斯激怒了！",
    you = "你",
} end )
local timer = {
	wound = 15,
	trap = 20,
}
local icon = {
	wound = "ability_criticalstrike",
	trap = "inv_misc_dust_02",
	enrage = "Spell_Shadow_UnholyFrenzy",
}
local color = {
	wound = "Black",
	trap = "White",
}
local syncName = {
	wound = "KurinaxxWound"..module.revision,
	trap = "KurinaxxTrap"..module.revision,
	enrage = "KurinaxxEnrage"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED_DOSE", "Mortal Wound", "WoundEvent")
	self:RegisterCombatLog("SPELL_DAMAGE", "Sand Trap", "TrapEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Enrage", "EnrageEvent")
	
	
	
	
	self:ThrottleSync(2, syncName.wound)
	self:ThrottleSync(0, syncName.trap)
	self:ThrottleSync(10, syncName.enrage)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:WoundEvent(ev)
	if ev.destName and ev.amount and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.wound .. " " .. ev.destName .. " " .. ev.amount)
	end
end

function module:TrapEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.trap .. " " .. ev.destName)
	end
end

function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.wound and rest and self.db.profile.wound then
		self:Wound(rest)
	
	elseif sync == syncName.trap and rest and self.db.profile.trap then
		self:Trap(rest)
	
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	end
end


function module:Wound(rest)
	local woundPlayer = strsub(rest,0,strfind(rest," ") - 1)
	local woundQty = tonumber(strsub(rest,strfind(rest," "),strlen(rest)))
	
	self:RemoveBar(woundPlayer.." ".."1"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."2"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."3"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."4"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."5"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."6"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."7"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."8"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."9"..L["bar_wound"])
	self:RemoveBar(woundPlayer.." ".."10"..L["bar_wound"])

	self:Bar(woundPlayer.." "..woundQty..L["bar_wound"], timer.wound, icon.wound, true, color.wound)
end

function module:Trap(rest)
	if rest == UnitName("Player") then
		self:Message(L["msg_sandTrap"], "Attention", false, nil, false)
		self:WarningSign(icon.trap, 0.7)
	end
	
	self:Bar(rest..L["bar_trap"], timer.trap, icon.trap)
end

function module:Enrage()
	self:Message(L["msg_enrage"], "Attention", false, nil, false)
	self:Sound("Alarm")
	self:WarningSign(icon.enrage, 0.7)
end
