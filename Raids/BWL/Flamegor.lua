
local module, L = BigWigs:ModuleDeclaration("Flamegor", "Blackwing Lair")

module.revision = 30141
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"wingbuffet", "shadowflame", "frenzy", -1, "mcalert", "mcbar", "mcmark", "bosskill"}
module.defaultDB = {
	mcbar = false,
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Flamegor",

	wingbuffet_cmd = "wingbuffet",
	wingbuffet_name = "Wing Buffet Alert",
	wingbuffet_desc = "Warn for Wing Buffet",

	shadowflame_cmd = "shadowflame",
	shadowflame_name = "Shadow Flame Alert",
	shadowflame_desc = "Warn for Shadow Flame",

	frenzy_cmd = "frenzy",
	frenzy_name = "Frenzy Alert",
	frenzy_desc = "Warn for Frenzy",

	mcalert_cmd = "mcalert",
	mcalert_name = "Overbearing Rage Alert",
	mcalert_desc = "Warn when Overbearing Rage (mind control) happens",

	mcbar_cmd = "mcbar",
	mcbar_name = "Overbearing Rage Health Bar",
	mcbar_desc = "Show a health bar for victims of Overbearing Rage (bring them to 25% HP to end the effect, they cannot be CCed)",

	mcmark_cmd = "mcmark",
	mcmark_name = "Overbearing Rage Mark",
	mcmark_desc = "Mark the victim of Overbearing Rage with Diamond",
	
	
	bar_wingBuffetCast = "Casting Wing Buffet!",
	bar_wingBuffetCd = "Wing Buffet CD",
	msg_wingBuffetCast = "Casting Wing Buffet!",
	msg_wingBuffetSoon = "Wing Buffet in 2 seconds - Taunt now!",
	
	bar_shadowFlameCast = "Casting Shadow Flame!",
	msg_shadowFlameCast = "Casting Shadow Flame!",
	bar_shadowFlameCd = "Shadow Flame CD",
	
	bar_frenzyCd = "Frenzy CD",
	bar_frenzyDur = "Frenzy!",
	msg_frenzy = "Frenzy - Tranq now!",
	
	bar_mc = "%s Rage",
	msg_mc = "%s raging out! - bring to 25%% or kill boss",
	
} end)

local timer = {
	wingBuffetFirstCd = 30,
	wingBuffetCd = 29, --30sec - 1sec cast
	wingBuffetCast = 1,
	
	shadowFlameFirstCd = 16,
	shadowFlameCd = 14, --16 - 2sec cast
	shadowFlameCast = 2,
	
	frenzyCd = 10,
	frenzyDur = 10,
}
local icon = {
	wingBuffet = "INV_Misc_MonsterScales_14",
	shadowFlame = "Spell_Fire_Incinerate",
	frenzy = "Ability_Druid_ChallangingRoar",
	tranquil = "Spell_Nature_Drowsy",
	mc = "Spell_Shadow_ShadowWordDominate",
}
local color = {
	wingBuffetCd = "Cyan",
	wingBuffetCast = "Blue",
	
	shadowFlameCd = "Orange",
	shadowFlameCast = "Red",
	
	frenzyCd = "Black",
	frenzyDur = "Magenta",
}
local syncName = {
	wingBuffet = "FlamegorWingBuffet"..module.revision,
	shadowFlameCast = "FlamegorShadowflame"..module.revision,
	shadowFlameHit = "FlamegorShadowflameHit"..module.revision,
	frenzy = "FlamegorFrenzyStart"..module.revision,
	frenzyFade = "FlamegorFrenzyEnd"..module.revision,
	mc = "FlamegorMC"..module.revision,
	mcFade = "FlamegorMCFade"..module.revision,
}
local spellId = {
	shadowFlame = 22539,
}

local frenzyStartTime = 0
local frenzyEndTime = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog("SPELL_CAST_START", {23339, "Wing Buffet"}, "WingBuffetEvent")
	self:RegisterCombatLog("SPELL_CAST_START", {22539, "Shadow Flame"}, "ShadowFlameCastEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, {22539, "Shadow Flame"}, "ShadowFlameHitEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {23342, "Frenzy"}, "FrenzyEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {23342, "Frenzy"}, "FrenzyFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Overbearing Rage", "McEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Overbearing Rage", "McFadeEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
	
	
	
	
	
	self:ThrottleSync(3, syncName.wingBuffet)
	self:ThrottleSync(3, syncName.shadowFlameCast)
	self:ThrottleSync(3, syncName.shadowFlameHit)
	self:ThrottleSync(5, syncName.frenzy)
	self:ThrottleSync(1, syncName.frenzyFade)
	self:ThrottleSync(3, syncName.mc)
	self:ThrottleSync(1, syncName.mcFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	frenzyStartTime = 0
	frenzyEndTime = 0
	
	if self.db.profile.wingbuffet then
		self:Bar(L["bar_wingBuffetCd"], timer.wingBuffetFirstCd, icon.wingBuffet, true, color.wingBuffetCd)
		self:DelayedMessage(timer.wingBuffetFirstCd - 2, L["msg_wingBuffetSoon"], "Attention", false, nil, false)
	end
	
	if self.db.profile.shadowflame then
		self:Bar(L["bar_shadowFlameCd"], timer.shadowFlameFirstCd, icon.shadowFlame, true, color.shadowFlameCd)
	end
	
	if self.db.profile.frenzy then
		self:Bar(L["bar_frenzyCd"], timer.frenzyCd, icon.frenzy, true, color.frenzyCd)
	end
end

function module:OnDisengage()
end


-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:WingBuffetEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.wingBuffet)
	end
end

function module:ShadowFlameCastEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.shadowFlameCast)
	end
end

function module:ShadowFlameHitEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.shadowFlameHit)
	end
end

function module:FrenzyEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzy)
	end
end

-- Overbearing Rage: a player turned against the raid
function module:McEvent(ev)
	if ev.destName then
		self:Sync(syncName.mc .. " " .. ev.destName)
	end
end

function module:FrenzyFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.frenzyFade)
	end
end

function module:McFadeEvent(ev)
	if ev.destName then
		self:Sync(syncName.mcFade .. " " .. ev.destName)
	end
end

-- a raid member dying clears their Overbearing Rage
function module:UnitDied(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:OverbearingRageFade(ev.destName)
		self:Sync(syncName.mcFade .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.wingBuffet and self.db.profile.wingbuffet then
		self:WingBuffet()
	elseif sync == syncName.shadowFlameCast and self.db.profile.shadowflame then
		self:RemoveBar(L["bar_shadowFlameCd"])
		self:Bar(L["bar_shadowFlameCast"], timer.shadowFlameCast, icon.shadowFlame, true, color.shadowFlameCast)
		self:Message(L["msg_shadowFlameCast"], "Urgent", false, nil, false)
	elseif sync == syncName.shadowFlameHit and self.db.profile.shadowflame then
		self:RemoveBar(L["bar_shadowFlameCd"])
		self:Bar(L["bar_shadowFlameCd"], timer.shadowFlameCd, icon.shadowFlame, true, color.shadowFlameCd)
	elseif sync == syncName.frenzy and self.db.profile.frenzy then
		self:Frenzy()
	elseif sync == syncName.frenzyFade and self.db.profile.frenzy then
		self:FrenzyFade()
	elseif sync == syncName.mc and rest then
		self:OverbearingRage(rest)
	elseif sync == syncName.mcFade and rest then
		self:OverbearingRageFade(rest)
	end
end


function module:WingBuffet()
	self:CancelDelayedMessage(L["msg_wingBuffetSoon"])
	self:RemoveBar(L["bar_wingBuffetCd"])
	
	self:Bar(L["bar_wingBuffetCast"], timer.wingBuffetCast, icon.wingBuffet, true, color.wingBuffetCast)
	
	self:DelayedBar(timer.wingBuffetCast, L["bar_wingBuffetCd"], timer.wingBuffetCd, icon.wingBuffet, true, color.wingBuffetCd)
	self:DelayedMessage(timer.wingBuffetCast + timer.wingBuffetCd - 2, L["msg_wingBuffetSoon"], "Attention", false, nil, false)
end

function module:Frenzy()
	self:RemoveBar(L["bar_frenzyCd"])
	
	if BigWigs:PlayerClass() == "HUNTER" then
		self:Message(L["msg_frenzy"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.tranquil, 1)
	end
	
	self:Bar(L["bar_frenzyDur"], timer.frenzyDur, icon.frenzy, true, color.frenzyDur)
	frenzyStartTime = GetTime()
end

function module:FrenzyFade()
	self:RemoveBar(L["bar_frenzyDur"])
	self:RemoveWarningSign(icon.tranquil)
	
	frenzyEndTime = GetTime()
	
	self:Bar(L["bar_frenzyCd"], timer.frenzyCd - (frenzyEndTime - frenzyStartTime), icon.frenzy, true, color.frenzyCd)
end

function module:OverbearingRage(player)
	if self.db.profile.mcalert then
		self:Message(string.format(L["msg_mc"],player), "Attention", false, "Alert")
	end

	if self.db.profile.mcbar then
		self:MonitorBar(string.format(L["bar_mc"],player), icon.mc, BigWigs:GetGUIDByName(player, 0))
	end

	if self.db.profile.mcmark then
		self:SetRaidTargetForPlayer(player, "Diamond")
	end
end

function module:OverbearingRageFade(player)
	self:RestorePreviousRaidTargetForPlayer(player)
	self:RemoveBar(string.format(L["bar_mc"],player))
end
