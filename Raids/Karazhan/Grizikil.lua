
local module, L = BigWigs:ModuleDeclaration("Grizikil", "Karazhan")

module.revision = 30024
module.enabletrigger = module.translatedName
module.toggleoptions = {"rainoffire", "flamewave", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED

L:RegisterTranslations("enUS", function() return {
	cmd = "Grizikil",

	rainoffire_cmd = "rainoffire",
	rainoffire_name = "Rain of Fire Alert",
	rainoffire_desc = "Warn for Rain of Fire",

	flamewave_cmd = "flamewave",
	flamewave_name = "Flamewave Alert",
	flamewave_desc = "Warn for Flamewave",

	msg_rainOfFireYou = "Get out of Rain of Fire!",

	bar_flamewave = "Flamewave",
	bar_flamewaveCd = "Next Flamewave",
	msg_flamewave = "Flamewave, melee run out!",
	msg_flamewaveSoon = "Flamewave soon, melee get ready!",

	trigger_engage = "Whats this? You're here for the orb?! ITS MINE, Grellkin, get them!",--CHAT_MSG_MONSTER_YELL

	msg_pullAll = "Pull --ALL-- imp packs before engaging Grizikil!",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Grizikil",

    rainoffire_cmd = "rainoffire",
    rainoffire_name = "火焰之雨警报",
    rainoffire_desc = "火焰之雨出现时进行警告",

    flamewave_cmd = "flamewave",
    flamewave_name = "烈焰波警报",
    flamewave_desc = "烈焰波出现时进行警告",

    msg_rainOfFireYou = "离开火焰之雨区域！",

    bar_flamewave = "烈焰波",
    bar_flamewaveCd = "下一次烈焰波",
    msg_flamewave = "烈焰波，近战快躲开！",
    msg_flamewaveSoon = "烈焰波即将到来，近战准备！",

    trigger_engage = "Whats this? You're here for the orb?! ITS MINE, Grellkin, get them!",--CHAT_MSG_MONSTER_YELL

    msg_pullAll = "在与格里兹基尔交战前，拉清--所有--小鬼群！",
} end )

-- Timings from the server script (boss_grizikil.cpp): Flamewave first at 30s, then 25-34s after
-- each cast; the aura lasts 9s and hits everyone within about 10 yards every 3s.
local timer = {
	flamewave = 9,
	flamewaveFirstCd = 30,
	flamewaveCd = {25, 34},
	flamewaveSoon = 3, -- warning this long before the earliest cast
	rainOfFireRepeat = 3, -- at most one "get out" warning per Rain of Fire tick
}
local icon = {
	rainOfFire = "spell_shadow_rainoffire",
	flamewave = "spell_fire_incinerate",
}
local color = {
	flamewave = "Red",
	flamewaveCd = "Orange",
}
local syncName = {
	flamewave = "GrizikilFlamewave"..module.revision,
	flamewaveFade = "GrizikilFlamewaveFade"..module.revision,
}

-- spell IDs, with the English name as a fallback match (see RegisterCombatLog in Core.lua)
local spell = {
	flamewave = {57091, "Flamewave"},
	rainOfFire = {57093, "Grellkin Rain of Fire"},
}

local lastRainOfFire = 0

--module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	self:Message(L["msg_pullAll"], "Urgent", false, nil, false)

	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED"}, spell.flamewave, "FlamewaveEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", spell.flamewave, "FlamewaveFadeEvent")
	self:RegisterCombatLog({"SPELL_DAMAGE", "SPELL_PERIODIC_DAMAGE"}, spell.rainOfFire, "RainOfFireEvent")

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_engage

	self:ThrottleSync(5, syncName.flamewave)
	self:ThrottleSync(5, syncName.flamewaveFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	lastRainOfFire = 0
	if self.db.profile.flamewave then
		self:Bar(L["bar_flamewaveCd"], timer.flamewaveFirstCd, icon.flamewave, true, color.flamewaveCd)
		self:DelayedMessage(timer.flamewaveFirstCd - timer.flamewaveSoon, L["msg_flamewaveSoon"], "Attention", false, nil, false)
	end
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:FlamewaveEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.flamewave)
	end
end

function module:FlamewaveFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.flamewaveFade)
	end
end

function module:RainOfFireEvent(ev)
	if not self.db.profile.rainoffire or not ev.destGUID or ev.destGUID ~= UnitGUID("player") then
		return
	end
	local now = GetTime()
	if now - lastRainOfFire < timer.rainOfFireRepeat then
		return
	end
	lastRainOfFire = now
	self:WarningSign(icon.rainOfFire, 0.7)
	self:Message(L["msg_rainOfFireYou"], "Important", false, nil, false)
	self:Sound("Info")
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.flamewave and self.db.profile.flamewave then
		self:Flamewave()
	elseif sync == syncName.flamewaveFade and self.db.profile.flamewave then
		self:FlamewaveFade()
	end
end

function module:Flamewave()
	self:RemoveBar(L["bar_flamewaveCd"])
	self:CancelDelayedMessage(L["msg_flamewaveSoon"])

	self:Bar(L["bar_flamewave"], timer.flamewave, icon.flamewave, true, color.flamewave)
	self:Message(L["msg_flamewave"], "Urgent", false, nil, false)
	self:WarningSign(icon.flamewave, 1)
	self:Sound("Beware")

	self:IntervalBar(L["bar_flamewaveCd"], timer.flamewaveCd[1], timer.flamewaveCd[2], icon.flamewave, true, color.flamewaveCd)
	self:DelayedMessage(timer.flamewaveCd[1] - timer.flamewaveSoon, L["msg_flamewaveSoon"], "Attention", false, nil, false)
end

function module:FlamewaveFade()
	self:RemoveBar(L["bar_flamewave"])
end
