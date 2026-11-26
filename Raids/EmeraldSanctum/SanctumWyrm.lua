
local module, L = BigWigs:ModuleDeclaration("Sanctum Wyrm", "Emerald Sanctum")

module.revision = 30020
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"volley"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Emerald Sanctum"],
	AceLibrary("Babble-Zone-2.2")["Emerald Sanctum"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "SanctumWyrm",

	volley_cmd = "volley",
	volley_name = "Poison Volley Alert",
	volley_desc = "Warn for Poison Volley",

	bar_volley = "Poison Bolt Volley",
	
	msg_volley = "Get max range to avoid Poison Volley!",
	
	["You have slain %s!"] = true,
	
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "SanctumWyrm",

    volley_cmd = "volley",
    volley_name = "毒箭齐射警报",
    volley_desc = "毒箭齐射出现时进行警告",

    bar_volley = "毒箭齐射（清毒）",
    
    msg_volley = "保持最远距离以躲避毒箭齐射！",
    
    ["You have slain %s!"] = "你已击败了%s！",
	
} end )
local timer = {
	volley = 15,
}
local icon = {
	volley = "Spell_Nature_CorrosiveBreath",
}
local color = {
	volley = "Black",
}
local syncName = {
	volley = "SanctumWyrmVolley"..module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED", "SPELL_AURA_APPLIED"}, {24099, "Poison Bolt Volley"}, "VolleyEvent")
	
	self:ThrottleSync(1, syncName.volley)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
local volleyClasses = { MAGE = true, WARLOCK = true, PRIEST = true }

function module:VolleyEvent(ev)
	if ev.sourceName ~= self.translatedName then
		return
	end
	self:Sync(syncName.volley)
	if ev.subevent == "SPELL_DAMAGE" and ev.destGUID and ev.destGUID == UnitGUID("player") and volleyClasses[BigWigs:PlayerClass()] then
		self:Message(L["msg_volley"], "Urgent", false, nil, false)
		self:Sound("Info")
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.volley and self.db.profile.volley then
		self:Volley()
	end
end


function module:Volley()
	self:RemoveBar(L["bar_volley"])
	self:Bar(L["bar_volley"], timer.volley, icon.volley, true, color.volley)
	
	if BigWigs:PlayerClass() == "SHAMAN" then
		self:WarningSign(icon.volley, 0.7)
	end
end
