
local module, L = BigWigs:ModuleDeclaration("Broodlord Lashlayer", "Blackwing Lair")

module.revision = 30141
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"ms", "bw", "knock", "serrated", -1, "targeticon", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Broodlord",
	
	ms_cmd = "ms",
	ms_name = "Mortal Strike Alert",
	ms_desc = "Warn for Mortal Strike",

	bw_cmd = "bw",
	bw_name = "Blast Wave Alert",
	bw_desc = "Warn for Blast Wave",
	
	knock_cmd = "knock",
	knock_name = "Knock Away Alert",
	knock_desc = "Warn for Knock Away",
	
	serrated_cmd = "serrated",
	serrated_name = "Serrated Wound Duration",
	serrated_desc = "Show a bar for the debuff duration of Serrated Wound (click to target victim)",
	
	targeticon_cmd = "targeticon",
	targeticon_name = "Skull Icon on Bloodlord's Target",
	targeticon_desc = "Put a Skull Raid Icon on Bloodlord's Target",
	
	
	trigger_engage = "None of your kind should be here! You've doomed only yourselves!",
	
	msg_msEvade = "Mortal Strike was Dodged!",
	
	bar_msCd = "Mortal Strike CD",
	bar_msSoon = "Mortal Strike Soon...",
	bar_msDur = " Mortal Strike",
	msg_ms = " Mortal Strike",
	
	bar_bwCd = "Blast Wave CD",
	bar_bwSoon = "Blast Wave Soon...",
	
	bar_knockCd = "Knock Away CD",
	bar_knockSoon = "Knock Away Soon...",
	
	bar_serratedDur = ">%s< bleeding",
} end )

local timer = {
	msFirstCd = 30, -- Observed at 32.61s in 2026-09-04 log (was 15.4s late)
	msCd = 20,--cd supposed to be {20,30}, saw 26, 27
	msSoon = 10,
	msDur = 5,
	
	bwCd = 20,--first is 20, next are 20 minimum
	bwSoon = 15,--20+15=35, saw 29, 25, 31, supposed to be {20,35}
	
	knockFirstCd = 20,
	knockFirstSoon = 5,
	knockCd = 12,--first is 20-25, next are 12,25
	knockSoon = 13,
	
	serratedDur = 10,
}
local icon = {
	ms = "Ability_Warrior_SavageBlow",
	bw = "Spell_Holy_Excorcism_02",
	knock = "INV_Gauntlets_05",
	serrated = "Ability_Rogue_Rupture",
}
local color = {
	msCd = "Black",
	msSoon = "Black",
	msDur = "Magenta",
	
	bwCd = "Orange",
	bwSoon = "Red",
	
	knockCd = "Cyan",
	knockSoon = "Blue",
	serrated = "Yellow",
}
local syncName = {
	ms = "BroodlordMs"..module.revision,
	msFade = "BroodlordMsFade"..module.revision,
	bw = "BroodlordBlastWave"..module.revision,
	knock = "BroodlordKnockAway"..module.revision,
	serrated = "BroodlordSerrated"..module.revision,
	serratedFade = "BroodlordSerratedFade"..module.revision,
}

module:RegisterYellEngage(L["trigger_engage"])

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {24573, "Mortal Strike"}, "MortalStrikeEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {24573, "Mortal Strike"}, "MortalStrikeFadeEvent")
	self:RegisterCombatLog("SPELL_MISSED", {24573, "Mortal Strike"}, "MortalStrikeMissEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE"}, {23331, "Blast Wave"}, "BlastWaveEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, {18670, "Knock Away"}, "KnockAwayEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Serrated Wound", "SerratedEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Serrated Wound", "SerratedFadeEvent")
	
	
	
	
	self:ThrottleSync(3, syncName.ms)
	self:ThrottleSync(3, syncName.msFade)
	self:ThrottleSync(3, syncName.bw)
	self:ThrottleSync(3, syncName.knock)
	self:ThrottleSync(3, syncName.serrated)
	self:ThrottleSync(3, syncName.serratedFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.ms then
		self:Bar(L["bar_msCd"], timer.msFirstCd, icon.ms, true, color.msCd)
	end
	
	if self.db.profile.bw then
		self:Bar(L["bar_bwCd"], timer.bwCd, icon.bw, true, color.bwCd)
	end
	
	if self.db.profile.knock then
		self:Bar(L["bar_knockCd"], timer.knockFirstCd, icon.knock, true, color.knockCd)
		self:DelayedBar(timer.knockFirstCd, L["bar_knockSoon"], timer.knockFirstSoon, icon.knock, true, color.knockSoon)
	end
	
	if self.db.profile.targeticon then
		self:ScheduleRepeatingEvent("BroodlordTargetCheck", self.BroodlordTarget, 0.5, self)
	end
end

function module:OnDisengage()
	self:CancelScheduledEvent("BroodlordTargetCheck")
end

function module:BroodlordTarget()
	if UnitName("Target") ~= nil and UnitName("TargetTarget") ~= nil and (IsRaidLeader() or IsRaidOfficer()) then
		if UnitName("Target") == "Broodlord Lashlayer" then
			SetRaidTarget("TargetTarget",8)
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:MortalStrikeEvent(ev)
	if ev.destName and ev.sourceName == self.translatedName then
		self:Sync(syncName.ms .. " " .. ev.destName)
	end
end

function module:MortalStrikeFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.msFade .. " " .. ev.destName)
	end
end

-- dodged, parried, blocked...: the Mortal Strike still went out
function module:MortalStrikeMissEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.ms .. " " .. "msEvade")
	end
end

function module:BlastWaveEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.bw)
	end
end

function module:KnockAwayEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.knock)
	end
end

function module:SerratedEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.serrated .. " " .. ev.destName)
	end
end

function module:SerratedFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.serratedFade .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.ms and rest and self.db.profile.ms then
		self:Ms(rest)
	elseif sync == syncName.msFade and rest and self.db.profile.ms then
		self:MsFade(rest)
	
	elseif sync == syncName.bw and self.db.profile.bw then
		self:BW()
		
	elseif sync == syncName.knock and self.db.profile.knock then
		self:Knock()
		
	elseif sync == syncName.serrated and rest and self.db.profile.serrated then
		self:Serrated(rest)
	elseif sync == syncName.serratedFade and rest and self.db.profile.serrated then
		self:SerratedFade(rest)
	end
end


function module:Ms(rest)
	self:CancelDelayedBar(L["bar_msSoon"])
	self:RemoveBar(L["bar_msSoon"])
	self:RemoveBar(L["bar_msCd"])
	
	if rest ~= "msEvade" then
		self:ClickBar(rest..L["bar_msDur"], timer.msDur, icon.ms, rest, nil, true, color.msDur)
		self:Message(rest..L["msg_ms"], "Urgent", false, nil, false)
	
		self:DelayedBar(timer.msDur, L["bar_msCd"], timer.msCd, icon.ms, true, color.msCd)
		self:DelayedBar(timer.msDur + timer.msCd, L["bar_msSoon"], timer.msSoon, icon.ms, true, color.msSoon)
	else
		self:Message(L["msg_msEvade"], "Urgent", false, nil, false)
	
		self:Bar(L["bar_msCd"], timer.msDur + timer.msCd, icon.ms, true, color.msCd)
		self:DelayedBar(timer.msDur + timer.msCd, L["bar_msSoon"], timer.msSoon, icon.ms, true, color.msSoon)
	end
end

function module:MsFade(rest)
	self:RemoveBar(rest..L["bar_msDur"])
end

function module:BW()
	self:CancelDelayedBar(L["bar_bwSoon"])
	self:RemoveBar(L["bar_bwSoon"])
	
	self:Bar(L["bar_bwCd"], timer.bwCd, icon.bw, true, color.bwCd)
	self:DelayedBar(timer.bwCd, L["bar_bwSoon"], timer.bwSoon, icon.bw, true, color.bwSoon)
end

function module:Knock()
	self:CancelDelayedBar(L["bar_knockSoon"])
	self:RemoveBar(L["bar_knockSoon"])
	
	self:Bar(L["bar_knockCd"], timer.knockCd, icon.knock, true, color.knockCd)
	self:DelayedBar(timer.knockCd, L["bar_knockSoon"], timer.knockSoon, icon.knock, true, color.knockSoon)
end

function module:Serrated(rest)
	self:ClickBar(string.format(L["bar_serratedDur"],rest), timer.serratedDur, icon.serrated, rest, nil, true, color.serrated)
end

function module:SerratedFade(rest)
	self:RemoveBar(string.format(L["bar_serratedDur"],rest))
end
