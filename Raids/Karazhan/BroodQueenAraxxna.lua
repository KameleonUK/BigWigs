
local module, L = BigWigs:ModuleDeclaration("Brood Queen Araxxna", "Karazhan")

module.revision = 30037
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"volley", "leechingbite", "egg", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "BroodQueenAraxxna",

	volley_cmd = "volley",
	volley_name = "Brood Venom Volley Alert",
	volley_desc = "Warn for Brood Venom Volley",

	leechingbite_cmd = "leechingbite",
	leechingbite_name = "Leeching Bite Alert",
	leechingbite_desc = "Warn for Leeching Bite",
	
	egg_cmd = "egg",
	egg_name = "Egg Spawn Alert",
	egg_desc = "Warns for Egg Spawn",
	
	
	
	bar_volley = "Brood Venom Volley",
	
	bar_leechingBite = " Leeching Bite",

	trigger_eggSpawn = "My minions shall consume you!",--CHAT_MSG_MONSTER_YELL
	bar_eggHatch = "Skitterweb Egg Hatch",
	msg_eggSpawn = "2 Eggs Spawned!",
	
	trigger_engage = "What goes there, new prey to be entangled?",--CHAT_MSG_MONSTER_YELL
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "BroodQueenAraxxna",

	volley_cmd = "volley",
	volley_name = "巢毒齐射警报",
	volley_desc = "巢毒齐射出现时进行警告",

	leechingbite_cmd = "leechingbite",
	leechingbite_name = "水蛭叮咬警报",
	leechingbite_desc = "水蛭叮咬出现时进行警告",
	
	egg_cmd = "egg",
	egg_name = "产卵警报",
	egg_desc = "产卵时进行警告",
	
	
	
	bar_volley = "巢毒齐射",
	
	bar_leechingBite = " 水蛭叮咬",

	trigger_eggSpawn = "My minions shall consume you!",--CHAT_MSG_MONSTER_YELL
	bar_eggHatch = "掠网蛛卵孵化",
	msg_eggSpawn = "2个卵即将孵化！",
	
	trigger_engage = "What goes there, new prey to be entangled?",--CHAT_MSG_MONSTER_YELL
	you = "you",
} end )
local timer = {
	volley = 8,
	leechingBite = 10,
	eggHatch = 20,
}
local icon = {
	volley = "Spell_Nature_InsectSwarm",
	leechingBite = "ability_poisonsting",
	eggHatch = "inv_egg_02",
}
local color = {
	volley = "Green",
	leechingBite = "Blue",
	eggHatch = "Red",
}
local syncName = {
	volley = "BroodQueenAraxxnaVolley"..module.revision,
	leechingBite = "BroodQueenAraxxnaLeechingBite"..module.revision,
	leechingBiteFade = "BroodQueenAraxxnaLeechingBiteFade"..module.revision,
	eggSpawn = "BroodQueenAraxxnaEggSpawn"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE"}, "Brood Venom Volley", "VolleyEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Leeching Bite", "LeechingBiteEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Leeching Bite", "LeechingBiteFadeEvent")
	
	
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_eggSpawn
	
	self:ThrottleSync(5, syncName.volley)
	self:ThrottleSync(5, syncName.leechingBite)
	self:ThrottleSync(0, syncName.leechingBiteFade)
	self:ThrottleSync(5, syncName.eggSpawn)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	if self.db.profile.volley then
		self:Bar(L["bar_volley"], timer.volley, icon.volley, true, color.volley)
	end
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	elseif msg == L["trigger_eggSpawn"] then
		self:Sync(syncName.eggSpawn)
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:VolleyEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.volley)
	end
end

function module:LeechingBiteEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.leechingBite .. " " .. ev.destName)
	end
end

function module:LeechingBiteFadeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.leechingBiteFade .. " " .. ev.destName)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.volley and self.db.profile.volley then
		self:Volley()
	elseif sync == syncName.leechingBite and rest and self.db.profile.leechingbite then
		self:LeechingBite(rest)
	elseif sync == syncName.leechingBiteFade and rest and self.db.profile.leechingbite then
		self:LeechingBiteFade(rest)
	elseif sync == syncName.eggSpawn and self.db.profile.egg then
		self:EggSpawn()
	end
end


function module:Volley()
	self:Bar(L["bar_volley"], timer.volley, icon.volley, true, color.volley)
	
	if BigWigs:PlayerClass() == "SHAMAN" then
		self:WarningSign(icon.volley, 0.7)
	end
end

function module:LeechingBite(rest)
	self:Bar(rest..L["bar_leechingBite"], timer.leechingBite, icon.leechingBite, true, color.leechingBite)
end

function module:LeechingBiteFade(rest)
	self:RemoveBar(rest..L["bar_leechingBite"])
end

function module:EggSpawn()
	local bwPlayerIsAttacking = nil
	if IsRaidLeader() or IsRaidOfficer() then
		if BigWigs:PlayerClass() ~= "ROGUE" and BigWigs:PlayerClass() ~= "DRUID" then
			if PlayerFrame.inCombat then
				bwPlayerIsAttacking = true
			end
			
			TargetByName("Skitterweb Egg",true)
			SetRaidTarget("target",8)
			TargetLastTarget()
			if bwPlayerIsAttacking then
				AttackTarget()
			end
		end
	end
	
	self:Bar(L["bar_eggHatch"], timer.eggHatch, icon.eggHatch, true, color.eggHatch)
	self:Message(L["msg_eggSpawn"], "Urgent", false, nil, false)
end