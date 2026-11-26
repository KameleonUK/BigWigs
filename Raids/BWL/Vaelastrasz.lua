
local module, L = BigWigs:ModuleDeclaration("Vaelastrasz the Corrupt", "Blackwing Lair")

module.revision = 30085
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"start", "adrenaline", "icon","flamebreath", "flamebreathdot", "firenova", "tailsweep", "parry", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Vaelastrasz",
	
	start_cmd = "start",
	start_name = "Engage Alert",
	start_desc = "Warn for Engage",
	
	adrenaline_cmd = "adrenaline",
	adrenaline_name = "Burning Adrenaline Alert",
	adrenaline_desc = "Warn for Burning Adrenaline",
	
	icon_cmd = "icon",
	icon_name = "Burning Adrenaline Raid Icon",
	icon_desc = "Place a Skull on Burning Adrenaline Target",
	
	flamebreath_cmd = "flamebreath",
	flamebreath_name = "Flame Breath Alert",
	flamebreath_desc = "Warn for Flame Breath",
	
	flamebreathdot_cmd = "flamebreathdot",
	flamebreathdot_name = "Flame Breath DoT Alert",
	flamebreathdot_desc = "Warn for Flame Breath DoT",
	
	firenova_cmd = "firenova",
	firenova_name = "Fire Nova Alert",
	firenova_desc = "Warn for Fire Nova",
	
	tailsweep_cmd = "tailsweep",
	tailsweep_name = "Tail Sweep Alert",
	tailsweep_desc = "Warn for Tail Sweep",
	
	parry_cmd = "parry",
	parry_name = "Parry Alert",
	parry_desc = "Warn for Parries",
	
	
	trigger_gossip1 = "Too late, friends", --CHAT_MSG_MONSTER_YELL
	trigger_gossip2 = "I beg you, mortals", --CHAT_MSG_MONSTER_YELL
	trigger_gossip3 = "FLAME! DEATH! DESTRUCTION!", --CHAT_MSG_MONSTER_YELL
	bar_gossip = "Engage",
	msg_gossip = "Vaelastrasz Event Started!",
	
	
	--burning adrenaline on mana user every 15sec, every 45s on the tank ALSO
		-- -5% hp per second
	bar_adrenalineCd = "Burning Adrenaline CD",
	bar_adrenalineDur = " Burning!",
	msg_adrenaline = " has Burning Adrenaline",
	
	
	bar_flameBreathCd = "Flame Breath CD",
	bar_flameBreathCast = "Casting Flame Breath!",
	
	bar_flameBreathDot = " Flame Breath DoT",
	
	bar_fireNova = "Fire Nova CD",
	
	msg_tailSweep = "Tail Sweep hits behind the boss for 30 yards.",
	
	msg_parryYou = "Vaelastrasz the Corrupt Parried your attack - Stop killing the tank you idiot!",
} end)

local timer = {
	gossip1 = 36,
	gossip2 = 26,
	gossip3 = 10,
	
	adrenalineCd = 15,
	adrenalineDur = 20,
	
	flameBreathCd = {5,10}, --sqw 5.062 to 9.604
	flameBreathCast = 2,
	flameBreathDot = 15,
	
	fireNovaCd = {2,4}, --saw from 2 to 3.878, first at 3.966
}
local icon = {
	gossip = "inv_misc_head_dragon_01",
	adrenaline = "INV_Gauntlets_03",
	adrenalineDur = "spell_shadow_mindbomb",
	flameBreath = "spell_fire_fire",
	flameBreathDot = "spell_fire_incinerate",
	tailSweep = "inv_misc_monsterscales_05",
	fireNova = "spell_fire_sealoffire",
	parry = "ability_parry",
}
local color = {
	gossip = "White",
	
	adrenalineCd = "Orange",
	adrenalineDur = "Red",
	
	flameBreathCd = "Cyan",
	flameBreathCast = "Blue",
	flameBreathDot = "Magenta",
	
	fireNovaCd = "Black",
}
local syncName = {
	gossip1 = "VaelGossip1"..module.revision,
	gossip2 = "VaelGossip2"..module.revision,
	gossip3 = "VaelGossip3"..module.revision,
	
	adrenaline = "VaelAdrenaline2"..module.revision,
	adrenalinePlayer = "VaelAdrenalinePlayer"..module.revision,
	adrenalinePlayerFade = "VaelAdrenalinePlayerFade"..module.revision,
	
	flameBreath = "VaelBreath"..module.revision,
	flameBreathDot = "VaelBreathDot"..module.revision,
	flameBreathDotFade = "VaelBreathDotFade"..module.revision,
	
	fireNova = "VaelFireNova"..module.revision,
}

local engaged = nil
local adrenalineCount = 1
local adrenalinePlayers = {}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL") --trigger_gossip1,2,3
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {23513, "Essence of the Red"}, "EssenceEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {18173, "Burning Adrenaline"}, "AdrenalineEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {18173, "Burning Adrenaline"}, "AdrenalineFadeEvent")
	self:RegisterCombatLog("SPELL_CAST_START", {23461, "Flame Breath"}, "FlameBreathEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED_DOSE", {23461, "Flame Breath"}, "FlameBreathDotEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", {23461, "Flame Breath"}, "FlameBreathDotFadeEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE"}, {23462, "Fire Nova"}, "FireNovaEvent")
	self:RegisterCombatLog("SPELL_DAMAGE", {15847, "Tail Sweep"}, "TailSweepEvent")
	self:RegisterCombatLog("SWING_MISSED", nil, "ParryEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
	
	
	
	
	self:ThrottleSync(2, syncName.gossip1)
	self:ThrottleSync(2, syncName.gossip2)
	self:ThrottleSync(2, syncName.gossip3)
	
	self:ThrottleSync(10, syncName.adrenaline)
	self:ThrottleSync(0, syncName.adrenalinePlayer)
	self:ThrottleSync(0, syncName.adrenalinePlayerFade)
	
	self:ThrottleSync(3, syncName.flameBreath)
	self:ThrottleSync(3, syncName.flameBreathDot)
	self:ThrottleSync(3, syncName.flameBreathDotFade)
	
	self:ThrottleSync(1, syncName.fireNova)
end

function module:OnSetup()
	self.started = nil
	
end

function module:OnEngage()
	engaged = true
	adrenalineCount = 1
	adrenalinePlayers = {}
	
	self:RemoveBar(L["bar_gossip"])
	
	if self.db.profile.adrenaline then
		self:Bar(L["bar_adrenalineCd"], timer.adrenalineCd, icon.adrenaline, true, color.adrenalineCd)
	end
	
	if self.db.profile.flamebreath then
		self:IntervalBar(L["bar_flameBreathCd"], timer.flameBreathCd[1], timer.flameBreathCd[2], icon.flameBreath, true, color.flameBreathCd)
	end
	
	if self.db.profile.firenova then
		self:IntervalBar(L["bar_fireNova"], timer.fireNovaCd[1], timer.fireNovaCd[2], icon.fireNova, true, color.fireNovaCd)
	end
end

function module:OnDisengage()
end

-- UNIT_DIED: a raid member dying loses Burning Adrenaline
function module:UnitDied(ev)
	if not ev.destName or not BigWigs:IsGroupMember(ev.destFlags) then
		return
	end
	if engaged then
		BigWigs:CheckForWipe(self)
	end
	self:Sync(syncName.adrenalinePlayerFade .. " " .. ev.destName)
end

function module:CHAT_MSG_MONSTER_YELL(msg)
	if string.find(msg, L["trigger_gossip1"]) then
		self:Sync(syncName.gossip1)
	
	elseif string.find(msg, L["trigger_gossip2"]) then
		self:Sync(syncName.gossip2)
	
	elseif string.find(msg, L["trigger_gossip3"]) then
		self:Sync(syncName.gossip3)
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
local function IsMe(guid)
	return guid and guid == UnitGUID("player")
end

-- the gossip gives everyone Essence of the Red as the fight starts
function module:EssenceEvent(ev)
	module:SendEngageSync()
end

function module:AdrenalineEvent(ev)
	if ev.destName then
		self:Sync(syncName.adrenalinePlayer .. " " .. ev.destName)
	end
end

function module:AdrenalineFadeEvent(ev)
	if ev.destName then
		self:Sync(syncName.adrenalinePlayerFade .. " " .. ev.destName)
	end
end

function module:FlameBreathEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.flameBreath)
	end
end

-- Flame Breath stacks of 3 or more on a player (totems and pets that catch it are skipped)
function module:FlameBreathDotEvent(ev)
	if ev.destName and ev.amount and ev.amount >= 3 and BigWigs:IsGroupMember(ev.destFlags) and not string.find(ev.destName, " ", 1, true) then
		self:Sync(syncName.flameBreathDot .. " " .. ev.destName .. " " .. ev.amount)
	end
end

function module:FlameBreathDotFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.flameBreathDotFade .. " " .. ev.destName)
	end
end

function module:FireNovaEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.fireNova)
	end
end

function module:TailSweepEvent(ev)
	if ev.sourceName == self.translatedName and IsMe(ev.destGUID) and self.db.profile.tailsweep then
		self:TailSweep()
	end
end

-- your melee parried by Vaelastrasz while he isn't targeting you
function module:ParryEvent(ev)
	if ev.missType == "PARRY" and ev.destName == self.translatedName and IsMe(ev.sourceGUID) and self.db.profile.parry then
		if UnitName("Target") == self.translatedName and UnitName("TargetTarget") and UnitName("TargetTarget") ~= UnitName("Player") then
			self:ParryYou()
		end
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.gossip1 and self.db.profile.start then
		self:Gossip1()
	elseif sync == syncName.gossip2 and self.db.profile.start then
		self:Gossip2()
	elseif sync == syncName.gossip3 and self.db.profile.start then
		self:Gossip3()
	
	elseif sync == syncName.adrenaline and self.db.profile.adrenaline then
		self:Adrenaline()
		
	elseif sync == syncName.adrenalinePlayer and rest and self.db.profile.adrenaline then
		self:AdrenalinePlayer(rest)
	elseif sync == syncName.adrenalinePlayerFade and rest and self.db.profile.adrenaline then
		self:AdrenalinePlayerFade(rest)
	
	elseif sync == syncName.flameBreath and self.db.profile.flamebreath then
		self:FlameBreath()
		
	elseif sync == syncName.flameBreathDot and rest and self.db.profile.flamebreath then
		self:FlameBreathDot(rest)
	elseif sync == syncName.flameBreathDotFade and rest and self.db.profile.flamebreath then
		self:FlameBreathDotFade(rest)
	
	elseif sync == syncName.fireNova and self.db.profile.firenova then
		self:FireNova()
	end
end


function module:Gossip1()
	self:Bar(L["bar_gossip"], timer.gossip1, icon.gossip, true, color.gossip)
	self:Message(L["msg_gossip"], "Attention", false, nil, false)
end
function module:Gossip2()
	self:Bar(L["bar_gossip"], timer.gossip2, icon.gossip, true, color.gossip)
end
function module:Gossip3()
	self:Bar(L["bar_gossip"], timer.gossip3, icon.gossip, true, color.gossip)
end

function module:Adrenaline()
	self:RemoveBar(L["bar_adrenalineCd"])
	self:RemoveBar("2x "..L["bar_adrenalineCd"])
	
	adrenalineCount = adrenalineCount + 1
	
	if adrenalineCount == 3 or 
		adrenalineCount == 6 or 
		adrenalineCount == 9 or 
		adrenalineCount == 12 or 
		adrenalineCount == 15 or 
		adrenalineCount == 18 then
		self:Bar("2x "..L["bar_adrenalineCd"], timer.adrenalineCd, icon.adrenaline, true, color.adrenalineCd)
	else
		self:Bar(L["bar_adrenalineCd"], timer.adrenalineCd, icon.adrenaline, true, color.adrenalineCd)
	end
end

function module:AdrenalinePlayer(rest)
	local foundRest = nil
	for j,v in ipairs(adrenalinePlayers) do
		if v == rest then
			foundRest = true
			break
		end
	end
	
	if not foundRest then
		
		table.insert(adrenalinePlayers, rest)
		
		self:Bar(rest..L["bar_adrenalineDur"], timer.adrenalineDur, icon.adrenalineDur, true, color.adrenalineDur)
		self:Message(rest..L["msg_adrenaline"], "Urgent", false, nil, false)
		
		if rest == UnitName("Player") then
			SendChatMessage(UnitName("Player").." has Burning Adrenaline!","SAY")
			self:WarningSign(icon.adrenaline, 1)
			self:Sound("RunAway")
		end
		
		if self.db.profile.icon and (IsRaidLeader() or IsRaidOfficer()) then
			for i=1,GetNumRaidMembers() do
				if UnitName("Raid"..i) == rest then
					if UnitName("Raid"..i.."Target") == "Vaelastrasz the Corrupt" and UnitName("Raid"..i.."TargetTarget") ~= nil then
						if UnitName("Raid"..i.."TargetTarget") == rest then
							SetRaidTarget("Raid"..i, 6)
						else
							SetRaidTarget("Raid"..i, 8)
						end
					else
						SetRaidTarget("Raid"..i, 8)
					end
				end
			end
		end
		
		self:Sync(syncName.adrenaline)
	end
end

function module:AdrenalinePlayerFade(rest)
	for j,v in ipairs(adrenalinePlayers) do
		if v == rest then
			table.remove(adrenalinePlayers, j)
			
			self:RemoveBar(rest..L["bar_adrenalineDur"])
			
			if rest == UnitName("Player") then
				self:RemoveWarningSign(icon.adrenaline)
			end
		
			if self.db.profile.icon and (IsRaidLeader() or IsRaidOfficer()) then
				for i=1,GetNumRaidMembers() do
					if UnitName("Raid"..i) == rest then
						SetRaidTarget("Raid"..i, 0)
					end
				end
			end
			break
		end
	end
end

function module:FlameBreath()
	self:RemoveBar(L["bar_flameBreathCd"])
	
	self:Bar(L["bar_flameBreathCast"], timer.flameBreathCast, icon.flameBreath, true, color.flameBreathCast)
	
	self:DelayedIntervalBar(timer.flameBreathCast, L["bar_flameBreathCd"], timer.flameBreathCd[1], timer.flameBreathCd[2], icon.flameBreath, true, color.flameBreathCd)
end

function module:FlameBreathDot(rest)
	-- "<name> <stacks>"; split at the last space so a sync from an older build naming a totem can't break it
	local _, _, flameBreathDotPlayer, flameBreathDotQty = string.find(rest, "^(.+) (%d+)$")
	if not flameBreathDotPlayer then
		return
	end
	
	self:RemoveBar(flameBreathDotPlayer.." ".."3"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."4"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."5"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."6"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."7"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."8"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."9"..L["bar_flameBreathDot"])
	self:RemoveBar(flameBreathDotPlayer.." ".."10"..L["bar_flameBreathDot"])

	self:Bar(flameBreathDotPlayer.." "..flameBreathDotQty..L["bar_flameBreathDot"], timer.flameBreathDot, icon.flameBreathDot, true, color.flameBreathDot)
end

function module:FlameBreathDotFade(rest)
	self:RemoveBar(rest.." ".."3"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."4"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."5"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."6"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."7"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."8"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."9"..L["bar_flameBreathDot"])
	self:RemoveBar(rest.." ".."10"..L["bar_flameBreathDot"])
end

function module:TailSweep()
	self:Message(L["msg_tailSweep"], "Personal", false, nil, false)
	self:WarningSign(icon.tailSweep, 1)
end

function module:FireNova()
	self:IntervalBar(L["bar_fireNova"], timer.fireNovaCd[1], timer.fireNovaCd[2], icon.fireNova, true, color.fireNovaCd)
end

function module:ParryYou()
	self:WarningSign(icon.parry, 0.7)
	self:Message(L["msg_parryYou"], "Personal", false, nil, false)
	self:Sound("Info")
end
