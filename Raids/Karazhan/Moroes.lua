
local module, L = BigWigs:ModuleDeclaration("Moroes", "Karazhan")

module.revision = 30027
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"smokebomb", "reflect", "shufflekick", "curse", "dust", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Moroes",

	smokebomb_cmd = "smokebomb",
	smokebomb_name = "Smoke Bomb Alert",
	smokebomb_desc = "Warn for Smoke Bomb",

	reflect_cmd = "reflect",
	reflect_name = "Spell Reflect Alert",
	reflect_desc = "Warn for Spell Reflect",
	
	shufflekick_cmd = "shufflekick",
	shufflekick_name = "Shuffle Kick Alert",
	shufflekick_desc = "Warns for Shuffle Kick",
	
	curse_cmd = "curse",
	curse_name = "Curse Alert",
	curse_desc = "Warns for Curse",
	
	dust_cmd = "dust",
	dust_name = "Glittering Dust Alert",
	dust_desc = "Warns for Glittering Dust",
	
	
	
	trigger_p1 = "New guests? It has been a while since we have had those. I assume your arrival has taken -some- effort even if you were uninvited!",--CHAT_MSG_MONSTER_YELL
	bar_p1 = "Moroes Phase 1",
	
	trigger_p1End = "Now now, why don't we save such pleasantries for a more, entertaining show. Meet me at the stage, and we shall truly decide the outcome of our engagement.",--CHAT_MSG_MONSTER_YELL
	trigger_p2 = "It is my duty to protect and watch over this tower, as approved by my master. I shall make sure to endulge in your little spectacle. Why don't we put on a show for those in attendance, hmm? Legalbrow, if you would please, play my theme.",--CHAT_MSG_MONSTER_YELL
	bar_p2 = "Moroes Phase 2",
	
	bar_smokeBomb = "Players Smoke Bombed",
	
	bar_reflect = "Spell Reflect!",
	msg_reflect = "Spell Reflect!",
	
	bar_shuffleKick = " Kicked",
	
	msg_curse = "Moroes Curse, Decurse!",
	
	bar_dust = " Dusted",
	bar_dust_cd = "Tank Stun (use fap soon)",
	
	trigger_yellSmt = "Most impressive, it would appear your skills do match your bravery.",-- CHAT_MSG_MONSTER_YELL
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "Moroes",

    smokebomb_cmd = "smokebomb",
    smokebomb_name = "烟雾弹警报",
    smokebomb_desc = "烟雾弹出现时进行警告",

    reflect_cmd = "reflect",
    reflect_name = "法术反射警报",
    reflect_desc = "法术反射出现时进行警告",
    
    shufflekick_cmd = "shufflekick",
    shufflekick_name = "乱踢警报",
    shufflekick_desc = "乱踢出现时进行警告",
    
    curse_cmd = "curse",
    curse_name = "诅咒警报",
    curse_desc = "诅咒出现时进行警告",
    
    dust_cmd = "dust",
    dust_name = "闪光尘警报",
    dust_desc = "闪光尘出现时进行警告",
    


    trigger_p1 = "New guests? It has been a while since we have had those. I assume your arrival has taken -some- effort even if you were uninvited!",--CHAT_MSG_MONSTER_YELL
    bar_p1 = "莫罗斯阶段1",
    
    trigger_p1End = "Now now, why don't we save such pleasantries for a more, entertaining show. Meet me at the stage, and we shall truly decide the outcome of our engagement.",--CHAT_MSG_MONSTER_YELL
    trigger_p2 = "It is my duty to protect and watch over this tower, as approved by my master. I shall make sure to endulge in your little spectacle. Why don't we put on a show for those in attendance, hmm? Legalbrow, if you would please, play my theme.",--CHAT_MSG_MONSTER_YELL
    bar_p2 = "莫罗斯阶段2",
    
    bar_smokeBomb = "玩家中了烟雾弹",
    
    bar_reflect = "法术反射！",
    msg_reflect = "法术反射！",
    
    bar_shuffleKick = " 被踢",
    
    msg_curse = "莫罗斯的诅咒，快驱散！",
    
    bar_dust = " 中了闪光尘",
    
    trigger_yellSmt = "Most impressive, it would appear your skills do match your bravery.",-- CHAT_MSG_MONSTER_YELL
    you = "you",
} end )
local timer = {
	p1 = 7,
	p2 = 12,
	smokeBomb = 10,
	reflect = 5,
	shuffleKick = 4,
	dust = 10,
	dust_cd = 20, -- 20-26
}
local icon = {
	p1 = "Inv_Misc_Pocketwatch_01",
	p2 = "Inv_Misc_Pocketwatch_01",
	smokeBomb = "Ability_Vanish",
	reflect = "Spell_Arcane_Blink",
	shuffleKick = "Ability_Kick",
	curse = "Spell_Shadow_GatherShadows",
	dust = "Ability_Hibernation",--unknown
	dust_cd = "Inv_Potion_04"
}
local color = {
	p1 = "White",
	p2 = "White",
	smokeBomb = "Black",
	reflect = "Red",
	shuffleKick = "Blue",
	dust = "Cyan",
}
local syncName = {
	p1 = "MoroesP1"..module.revision,
	smokeBomb2 = "MoroesSmokeBomb2"..module.revision,
	reflect = "MoroesReflect"..module.revision,
	reflectFade = "MoroesReflectFade"..module.revision,
	p1End = "MoroesP1End"..module.revision,
	p2 = "MoroesP2"..module.revision,
	shuffleKick = "MoroesShuffleKick"..module.revision,
	shuffleKickFade = "MoroesShuffleKickFade"..module.revision,
	curse = "MoroesCurse"..module.revision,
	dust = "MoroesDust"..module.revision,
	dustFade = "MoroesDustFade"..module.revision,
}

local bwMoroesPhase = nil

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	bwMoroesPhase = nil
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Smoke Bomb", "SmokeBombEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Reflection", "ReflectionEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Reflection", "ReflectionFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Shuffle Kick", "ShuffleKickEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Shuffle Kick", "ShuffleKickFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Moroes Curse", "CurseEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Glittering Dust", "DustEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Glittering Dust", "DustFadeEvent")
	
	
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_p1, trigger_p2
	
	self:ThrottleSync(10, syncName.p1)
	self:ThrottleSync(10, syncName.p1End)
	self:ThrottleSync(10, syncName.p2)
	self:ThrottleSync(3, syncName.smokeBomb2)
	self:ThrottleSync(5, syncName.reflect)
	self:ThrottleSync(5, syncName.reflectFade)
	self:ThrottleSync(5, syncName.shuffleKick)
	self:ThrottleSync(5, syncName.shuffleKickFade)
	self:ThrottleSync(5, syncName.curse)
	self:ThrottleSync(5, syncName.dust)
	self:ThrottleSync(5, syncName.dustFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.dust then
		self:Bar(L["bar_dust_cd"], timer.dust_cd, icon.dust_cd, true, color.dust)
	end
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_p1"] then
		module:SendEngageSync()
		self:Sync(syncName.p1)
		
	elseif msg == L["trigger_p1End"] then
		self:Sync(syncName.p1End)
		
	elseif msg == L["trigger_p2"] then
		module:SendEngageSync()
		self:Sync(syncName.p2)
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:SmokeBombEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.smokeBomb2)
	end
end

function module:ReflectionEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.reflect)
	end
end

function module:ReflectionFadeEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.reflectFade)
	end
end

function module:ShuffleKickEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.shuffleKick .. " " .. ev.destName)
	end
end

function module:ShuffleKickFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.shuffleKickFade .. " " .. ev.destName)
	end
end

function module:CurseEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.curse)
	end
end

function module:DustEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.dust .. " " .. ev.destName)
	end
end

function module:DustFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.dustFade .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.p1 then
		self:P1()
	elseif sync == syncName.p1End then
		self:P1End()
	elseif sync == syncName.p2 then
		self:P2()
	elseif sync == syncName.smokeBomb2 and self.db.profile.smokebomb then
		self:SmokeBomb()
	elseif sync == syncName.reflect and self.db.profile.reflect then
		self:Reflect()
	elseif sync == syncName.reflectFade and self.db.profile.reflect then
		self:ReflectFade()
	elseif sync == syncName.shuffleKick and rest and self.db.profile.shufflekick then
		self:ShuffleKick(rest)
	elseif sync == syncName.shuffleKickFade and rest and self.db.profile.shufflekick then
		self:ShuffleKickFade(rest)
	elseif sync == syncName.curse and self.db.profile.curse then
		self:Curse()
	elseif sync == syncName.dust and rest and self.db.profile.dust then
		self:Dust(rest)
	elseif sync == syncName.dustFade and rest and self.db.profile.dust then
		self:DustFade(rest)
	end
end


function module:P1()
	bwMoroesPhase = "p1"
	self:Bar(L["bar_p1"], timer.p1, icon.p1, true, color.p1)
end

function module:P1End()
	bwMoroesPhase = "p2"
end

function module:P2()
	bwMoroesPhase = "p2"
	self:Bar(L["bar_p2"], timer.p2, icon.p2, true, color.p2)
end

function module:SmokeBomb()
	self:Bar(L["bar_smokeBomb"], timer.smokeBomb, icon.smokeBomb, true, color.smokeBomb)
	
	if BigWigs:PlayerClass() == "PRIEST" then
		self:WarningSign(icon.smokeBomb, 0.7)
	elseif BigWigs:PlayerClass() == "PALADIN" then
		self:WarningSign(icon.smokeBomb, 0.7)
	end
end

function module:Reflect()
	self:Bar(L["bar_reflect"], timer.reflect, icon.reflect, true, color.reflect)
	
	if BigWigs:PlayerClass() == "MAGE" then
		self:WarningSign(icon.reflect, timer.reflect)
	elseif BigWigs:PlayerClass() == "WARLOCK" then
		self:WarningSign(icon.reflect, timer.reflect)
	end
	
	if (BigWigs:PlayerClass() ~= "WARRIOR") and (BigWigs:PlayerClass() ~= "ROGUE") then
		self:Message(L["msg_reflect"], "Important", false, nil, false)
		self:Sound("Long")
	end
end

function module:ReflectFade()
	self:RemoveBar(L["bar_reflect"])
end

function module:ShuffleKick(rest)
	self:Bar(rest..L["bar_shuffleKick"], timer.shuffleKick, icon.shuffleKick, true, color.shuffleKick)
end

function module:ShuffleKickFade(rest)
	self:RemoveBar(rest..L["bar_shuffleKick"])
end

function module:Curse()
	self:Message(L["msg_curse"], "Urgent", false, nil, false)
	
	if BigWigs:PlayerClass() == "MAGE" then
		self:WarningSign(icon.curse, 0.7)
	elseif BigWigs:PlayerClass() == "DRUID" then
		self:WarningSign(icon.curse, 0.7)
	end
end

function module:Dust(rest)
	self:Bar(rest..L["bar_dust"], timer.dust, icon.dust, true, color.dust)
end

function module:DustFade(rest)
	self:RemoveBar(rest..L["bar_dust"])
end
