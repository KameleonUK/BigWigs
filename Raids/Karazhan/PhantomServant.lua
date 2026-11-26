
local module, L = BigWigs:ModuleDeclaration("Phantom Servant", "Karazhan")

module.revision = 30023
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {"phantomscream"}
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "phantomservant",

	phantomscream_cmd = "phantomscream",
	phantomscream_name = "Phantom Scream Alert",
	phantomscream_desc = "Warn for Phantom Scream",

	--trigger_phantomScreamFade = "Phantom Scream fades from (.+).",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
	
	bar_phantomScreamCd = "Phantom Scream CD",
	--bar_phantomScreamAfflicted = " Silenced",

	["You have slain %s!"] = true,
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "phantomservant",

    phantomscream_cmd = "phantomscream",
    phantomscream_name = "幻影尖叫警报",
    phantomscream_desc = "幻影尖叫出现时进行警告",

    --trigger_phantomScreamFade = "Phantom Scream fades from (.+).",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER

    bar_phantomScreamCd = "幻影尖叫冷却",
    --bar_phantomScreamAfflicted = " Silenced",

    ["You have slain %s!"] = "你杀死了%s！",
    you = "you",
} end )
local timer = {
	phantomScream = 10,
}
local icon = {
	phantomScream = "Spell_Shadow_PsychicScream",
}
local color = {
	phantomScreamCd = "White",
	phantomScreamAfflicted = "Red",
}
local syncName = {
	phantomScream2 = "PhantomServantPhantomScream2"..module.revision,
	--phantomScreamFade = "PhantomServantPhantomScreamFade"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Phantom Scream", "PhantomScreamEvent")
	
	--self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF", "Event")--trigger_phantomScreamFade
	--self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY", "Event")--trigger_phantomScreamFade
	--self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "Event")--trigger_phantomScreamFade
	
	self:ThrottleSync(5, syncName.phantomScream2)
	--self:ThrottleSync(0, syncName.phantomScreamFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:PhantomScreamEvent(ev)
	if BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.phantomScream2)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.phantomScream2 and self.db.profile.phantomscream then
		self:PhantomScream()
	--elseif sync == syncName.phantomScreamFade and rest and self.db.profile.phantomscream then
	--	self:PhantomScreamFade(rest)
	end
end


function module:PhantomScream()
	--self:Bar(rest..L["bar_phantomScreamAfflicted"], timer.phantomScream, icon.phantomScream, true, color.phantomScreamAfflicted)
	self:Bar(L["bar_phantomScreamCd"], timer.phantomScream, icon.phantomScream, true, color.phantomScreamCd)
end

function module:PhantomScreamFade(rest)
	self:RemoveBar(rest..L["bar_phantomScreamAfflicted"])
end
