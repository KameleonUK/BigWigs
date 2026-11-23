
local module, L = BigWigs:ModuleDeclaration("Erennius", "Emerald Sanctum")

module.revision = 30020
module.enabletrigger = module.translatedName
module.toggleoptions = {"wailoferennius", "howloferennius", "volley", "bosskill"}
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED

L:RegisterTranslations("enUS", function() return {
	cmd = "Erennius",

	wailoferennius_cmd = "wailoferennius",
	wailoferennius_name = "Wail Of Erennius Alert",
	wailoferennius_desc = "Warn for Wail Of Erennius",

	howloferennius_cmd = "howloferennius",
	howloferennius_name = "Howl Of Erennius Alert",
	howloferennius_desc = "Warns for Howl Of Erennius",
	
	volley_cmd = "volley",
	volley_name = "Poison Volley Alert",
	volley_desc = "Warns for Poison Volley",
	
	--Erennius vv
	bar_wailOfErenniusCast = "Wail Casting",
	bar_wailOfErenniusAfflicted = "Wail Afflicted",
	bar_wailOfErenniusCd = "Wail of Erennius CD",
	
	bar_howlOfErenniusCD = "Silence CD",
	bar_howlOfErenniusAfflicted = "Silenced!",
	
	bar_volley = "Poison Bolt Volley",
	--Erennius ^^
	
	trigger_someYell = "Your efforts...",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Erennius",

    wailoferennius_cmd = "wailoferennius",
    wailoferennius_name = "埃伦纽斯之嚎警报",
    wailoferennius_desc = "埃伦纽斯之嚎出现时进行警告",

    howloferennius_cmd = "howloferennius",
    howloferennius_name = "埃伦纽斯之吼警报",
    howloferennius_desc = "埃伦纽斯之吼出现时进行警告",
    
    volley_cmd = "volley",
    volley_name = "毒箭齐射警报",
    volley_desc = "毒箭齐射出现时进行警告",
    
    --Erennius vv
    bar_wailOfErenniusCast = "正在施放群体睡眠",
    bar_wailOfErenniusAfflicted = "群体睡眠",
    bar_wailOfErenniusCd = "群体睡眠冷却",
    
    bar_howlOfErenniusCD = "沉默冷却",
    bar_howlOfErenniusAfflicted = "沉默！",
    
    bar_volley = "毒箭齐射",
    --Erennius ^^
    
    trigger_someYell = "Your efforts...",
} end )
-- Server script (erenniusAI in instance_emerald_sanctum.cpp): Howl first at 37s, then every 30-33s;
-- Poison Bolt Volley every 9-13s; Wail of Erennius every 35s, only while Solnius is alive and in combat.
local timer = {
	howlOfErenniusFirstCd = 37,
	wailOfErenniusCast = 6,
	wailOfErenniusAfflicted = 3,
	wailOfErenniusCd = 26,
	howlOfErenniusCd = {22,38},--saw 30, saw 46, minus the 8 afflicted -> 25,38
	howlOfErenniusAfflicted = 8,
	volley = 12,
}
local icon = {
	wailOfErenniusCast = "Spell_Shadow_ShadeTruesight",
	wailOfErenniusAfflicted = "Spell_Shadow_ShadeTruesight",
	wailOfErenniusCd = "Spell_Shadow_ShadeTruesight",
	howlOfErennius = "Spell_Shadow_AuraOfDarkness",
	volley = "Spell_Nature_CorrosiveBreath",
}
local color = {
	wailOfErenniusCast = "Purple",
	wailOfErenniusAfflicted = "Purple",
	wailOfErenniusCd = "Purple",
	howlOfErennius = "Red",
	volley = "Green",
}
local syncName = {
	wailOfErenniusCast = "ErenniusWailOfErenniusCast"..module.revision,
	howlOfErennius = "ErenniusHowlOfErennius"..module.revision,
	volley = "ErenniusVolley"..module.revision,
}

-- spell IDs (from the server script), with the English name as a fallback match (see RegisterCombatLog in Core.lua)
local spell = {
	wail = {46080, "Wail of Erennius"},
	howl = {56506, "Howl of Erennius"},
	volley = {24099, "Poison Bolt Volley"},
}

--module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	self:RegisterCombatLog("SPELL_CAST_START", spell.wail, "WailEvent")
	-- a silence landing or being resisted both mean Howl went out
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED", "SPELL_MISSED"}, spell.howl, "HowlEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED"}, spell.volley, "VolleyEvent")

	self:ThrottleSync(10, syncName.wailOfErenniusCast)
	self:ThrottleSync(10, syncName.howlOfErennius)
	self:ThrottleSync(8, syncName.volley)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.howloferennius then
		self:Bar(L["bar_howlOfErenniusCD"], timer.howlOfErenniusFirstCd, icon.howlOfErennius, true, color.howlOfErennius)
	end
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
-- (the Sanctum Wyrms cast Poison Bolt Volley too, so each checks the caster)
function module:WailEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.wailOfErenniusCast)
	end
end

function module:HowlEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.howlOfErennius)
	end
end

function module:VolleyEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.volley)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.wailOfErenniusCast and self.db.profile.wailoferennius then
		self:WailOfErenniusCast()
	elseif sync == syncName.howlOfErennius and self.db.profile.howloferennius then
		self:HowlOfErennius()
	elseif sync == syncName.volley and self.db.profile.volley then
		self:Volley()
	end
end


function module:WailOfErenniusCast()
	self:RemoveBar(L["bar_wailOfErenniusCd"])
	self:Bar(L["bar_wailOfErenniusCast"], timer.wailOfErenniusCast, icon.wailOfErenniusCast, true, color.wailOfErenniusCast)
	self:DelayedBar(timer.wailOfErenniusCast, L["bar_wailOfErenniusAfflicted"], timer.wailOfErenniusAfflicted, icon.wailOfErenniusAfflicted, true, color.wailOfErenniusAfflicted)
	self:DelayedBar(9, L["bar_wailOfErenniusCd"], timer.wailOfErenniusCd, icon.wailOfErenniusCd, true, color.wailOfErenniusCd)
end

function module:HowlOfErennius()
	self:RemoveBar(L["bar_howlOfErenniusCD"])
	self:Bar(L["bar_howlOfErenniusAfflicted"], timer.howlOfErenniusAfflicted, icon.howlOfErennius, true, color.howlOfErennius)
	self:DelayedIntervalBar(timer.howlOfErenniusAfflicted, L["bar_howlOfErenniusCD"], timer.howlOfErenniusCd[1], timer.howlOfErenniusCd[2], icon.howlOfErennius, true, color.howlOfErennius)
end

function module:Volley()
	self:Bar(L["bar_volley"], timer.volley, icon.volley, true, color.volley)
	
	if BigWigs:PlayerClass() == "SHAMAN" then
		self:WarningSign(icon.volley, 0.7)
	end
end
