
local module, L = BigWigs:ModuleDeclaration("Fankriss the Unyielding", "Ahn'Qiraj")

module.revision = 30067
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"wound", "entangle", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Fankriss",
	
	wound_cmd = "wound",
	wound_name = "Wound 5 stacks alerts",
	wound_desc = "Alert for 5 stacks of Wound",
	
	entangle_cmd = "entangle",
	entangle_name = "Entangle Alert",
	entangle_desc = "Warn for Entangle",
	
	
	bar_entangle = " Entangled",
	
	bar_wound = " Wounds",
} end )

L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "Fankriss",
	
	wound_cmd = "wound",
    wound_name = "重伤堆叠5层警报",
    wound_desc = "当重伤达到5层时进行警报",
    
    entangle_cmd = "entangle",
    entangle_name = "纠缠警报",
    entangle_desc = "纠缠出现时进行警告",
	
	
    bar_entangle = " 纠缠持续",
	
    bar_wound = " 重伤持续",
} end )
local timer = {
	entangle = 8,
	wound = 15,
}
local icon = {
	entangle = "Spell_Nature_Web",
	wound = "ability_criticalstrike",
}
local color = {
	entangle = "White",
	wound = "Black",
}
local syncName = {
	entangle = "FankrissEntangle"..module.revision,
	entangleFade = "FankrissEntangleFade"..module.revision,
	wound = "FankrissWound"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Entangle", "EntangleEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Entangle", "EntangleFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED_DOSE", "Mortal Wound", "WoundEvent")
	
	
	self:ThrottleSync(0.1, syncName.entangle)
	self:ThrottleSync(0.1, syncName.entangleFade)
	self:ThrottleSync(3, syncName.wound)
end

function module:OnSetup()
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:EntangleEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.entangle .. " " .. ev.destName)
	end
end

function module:EntangleFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.entangleFade .. " " .. ev.destName)
	end
end

function module:WoundEvent(ev)
	if ev.destName and ev.amount and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.wound .. " " .. ev.destName .. " " .. ev.amount)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.entangle and rest and self.db.profile.entangle then
		self:Entangle(rest)
	elseif sync == syncName.entangleFade and rest and self.db.profile.entangle then
		self:EntangleFade(rest)
	elseif sync == syncName.wound and rest and self.db.profile.wound then
		self:Wound(rest)
	end
end

function module:Entangle(rest)
	self:Bar(rest..L["bar_entangle"], timer.entangle, icon.entangle, true, color.entangle)
end

function module:EntangleFade(rest)
	self:RemoveBar(rest..L["bar_entangle"])
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
