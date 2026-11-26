
local module, L = BigWigs:ModuleDeclaration("Ossirian the Unscarred", "Ruins of Ahn'Qiraj")
local element = nil -- current weakness school

module.revision = 30012
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"bigicon", "warstomp", "cyclone", "sandstorm", "supreme", "weakness", "clickit", "bosskill"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Ossirian",
	
	bigicon_cmd = "bigicon",
	bigicon_name = "Big icon warnings signs",
	bigicon_desc = "Big warning signs for Sandstorm, Weakness and Shaman's grounding totem",
	
	warstomp_cmd = "warstomp",
	warstomp_name = "Warstomp bars",
	warstomp_desc = "Timers for Ossirian's Warstomp ability",
	
	cyclone_cmd = "cyclone",
	cyclone_name = "Cyclone bars",
	cyclone_desc = "Timers for Ossirian's Cyclone ability",
	
	sandstorm_cmd = "sandstorm",
	sandstorm_name = "Sand tornado damage warning",
	sandstorm_desc = "Warn if you are taking damage from a Sand tornado",
	
	supreme_cmd = "supreme",
	supreme_name = "Supreme Alert",
	supreme_desc = "Warn for Supreme Mode",
	
	weakness_cmd = "weakness",
	weakness_name = "Ossirian's weakness alert",
	weakness_desc = "Warns what Ossirian's new weakness is",
	
	clickit_cmd = "clickit",
	clickit_name = "Click a crystal now",
	clickit_desc = "Timers for if you click after this timer, he will go supreme",

	supreme_bar = "Supreme",
	supremewarn = "Ossirian Supreme Mode!",
	supremedelaywarn = "Supreme in %d seconds!",

	debuffwarn = "Ossirian now weak to ",


	expose = "Expose",
	
	cyclone_bar = "Cyclone",
	warstomp_bar = "War Stomp",
	
	
	clickit_bar = "Crystal or die",
	
	firstcrystal_bar = "Click 1st crystal at 0",
	firstcrystal_warn = "CLICK IT NOW!!!",
} end )


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "Ossirian",
	
    bigicon_cmd = "bigicon",
    bigicon_name = "大图标警告标志",
    bigicon_desc = "沙尘暴、虚弱和萨满的根基图腾的大警告标志",

	warstomp_cmd = "warstomp",
	warstomp_name = "战争践踏计时条",
	warstomp_desc = "奥斯里安的战争践踏计时条",

	cyclone_cmd = "cyclone",
	cyclone_name = "飓风术计时条",
	cyclone_desc = "奥斯里安的飓风术计时条",

	sandstorm_cmd = "sandstorm",
	sandstorm_name = "沙尘暴伤害警告",
	sandstorm_desc = "受到沙尘暴的伤害时进行警告",
	
	supreme_cmd = "supreme",
	supreme_name = "狂暴警报",
	supreme_desc = "狂暴姿态出现时进行警告",
	
	weakness_cmd = "weakness",
	weakness_name = "奥斯里安的弱点警报",
	weakness_desc = "警告奥斯里安的新弱点是什么",

	clickit_cmd = "clickit",
	clickit_name = "现在点击水晶",
	clickit_desc = "计时器，如果在此计时器后点击，他将变为狂暴状态",

	supreme_bar = "狂暴姿态",
	supremewarn = "无疤者奥斯里安狂暴姿态!",
	supremedelaywarn = "狂暴将在 %d 秒后出现！",

	debuffwarn = "奥斯里安现在弱点是：",


	expose = "虚弱",
	
	cyclone_bar = "飓风术",
	warstomp_bar = "战争践踏",
	
	
	clickit_bar = "点击水晶或死亡",

	firstcrystal_bar = "在0秒时点击第一个水晶",
	firstcrystal_warn = "现在点击它！！！",
} end )
local timer = {
	weakness = 45,
	supreme = 45,
	warstomp = 30,
	cyclone = 20,
	clickit = 10,
	firstcrystal = 10,
	firstWarstomp = 25,
}

local icon = {
	supreme = "Ability_warrior_innerrage",
	warstomp = "Ability_warstomp",
	cyclone = "Spell_Nature_Cyclone",
	grounding = "spell_nature_groundingtotem",
	sandstorm = "spell_nature_earthbind",
	
	shadow = "spell_shadow_shadowbolt",
	fire = "Spell_Fire_Fire",
	frost = "Spell_Frost_ChillingBlast",
	nature = "spell_nature_healingtouch",
	arcane = "spell_nature_starfall",
	
	clickit = "inv_misc_pocketwatch_01",
}

local syncName = {
	weakness = "OssirianWeakness"..module.revision,
	supreme = "OssirianSupreme"..module.revision,
	warstomp = "OssirianWarstomp"..module.revision,
	cyclone = "OssirianCyclone"..module.revision,
}

local _, playerClass = UnitClass("player")
local bwOssiWeaknessTime = GetTime()
local bwOssiSupreme = nil
local bwOssiFirstWarstop = nil

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Strength of Ossirian", "SupremeEvent")
	self:RegisterCombatLog("SPELL_AURA_REMOVED", "Strength of Ossirian", "SupremeFadeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {"Fire Weakness", "Frost Weakness", "Nature Weakness", "Arcane Weakness", "Shadow Weakness"}, "WeaknessEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED", "SPELL_MISSED"}, "Enveloping Winds", "CycloneEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE", "SPELL_MISSED"}, "War Stomp", "WarStompEvent")
	self:RegisterCombatLog("SPELL_DAMAGE", "Harsh Winds", "SandstormEvent")


	
	self:ThrottleSync(3, syncName.weakness)
	self:ThrottleSync(3, syncName.supreme)
	self:ThrottleSync(3, syncName.cyclone)
	self:ThrottleSync(3, syncName.warstomp)
end

function module:OnSetup()
end

function module:OnEngage()
	bwOssiSupreme = true
	bwOssiFirstWarstop = true
	bwOssiWeaknessTime = GetTime()
	
	self:Sync(syncName.warstomp)
	self:Sync(syncName.cyclone)
	self:Sync(syncName.supreme)
	
	if self.db.profile.clickit then
		self:Bar(L["firstcrystal_bar"], timer.firstcrystal, icon.clickit, true, "blue")
		self:DelayedMessage(timer.firstcrystal, L["firstcrystal_warn"], "Urgent")
	end
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
-- after a weakness has run 46s without a new one, the Supreme timer can't be known any more
local function CheckSupremeUnknown(self)
	if ((bwOssiWeaknessTime + 46) < GetTime()) and bwOssiSupreme == false then
		self:Bar("UNKNOWN Supreme timer", 30, icon.supreme, true, "red")
		self:Message("WARNING! Supreme timer unknown!", "Attention", nil, "Beware")
		bwOssiSupreme = nil
	end
end

function module:SupremeEvent(ev)
	CheckSupremeUnknown(self)
	if ev.destName == self.translatedName then
		self:Sync(syncName.supreme)
	end
end

function module:SupremeFadeEvent(ev)
	if ev.destName == self.translatedName then
		bwOssiSupreme = false
	end
	CheckSupremeUnknown(self)
end

-- "Fire Weakness" etc. on Ossirian: the school word is synced
function module:WeaknessEvent(ev)
	CheckSupremeUnknown(self)
	if ev.destName == self.translatedName and ev.spellName then
		local _, _, school = string.find(ev.spellName, "^(%a+) Weakness$")
		if school and school ~= L["expose"] then
			self:Sync(syncName.weakness .. " " .. school)
		end
	end
end

function module:CycloneEvent(ev)
	CheckSupremeUnknown(self)
	if ev.sourceName == self.translatedName or ev.subevent == "SPELL_AURA_APPLIED" then
		self:Sync(syncName.cyclone)
	end
end

function module:WarStompEvent(ev)
	CheckSupremeUnknown(self)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.warstomp)
	end
end

-- standing in a Sand Vortex
function module:SandstormEvent(ev)
	if ev.sourceName == "Sand Vortex" and ev.destGUID and ev.destGUID == UnitGUID("player") and self.db.profile.sandstorm then
		if self.db.profile.bigicon then
			self:WarningSign(icon.sandstorm, 1)
		end
		self:Sound("RunAway")
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.weakness and rest and self.db.profile.weakness then
		self:Weakness(rest)
	elseif sync == syncName.supreme and self.db.profile.supreme then
		self:Supreme()
	elseif sync == syncName.cyclone and self.db.profile.cyclone then
		self:Cyclone()
	elseif sync == syncName.warstomp and self.db.profile.warstomp then
		self:WarStomp()
	end
end

function module:Weakness(rest)
	if self.db.profile.clickit then
		self:ClickIt()
	end
	
	self:RemoveBar("UNKNOWN Supreme timer")
	bwOssiWeaknessTime = GetTime()
	bwOssiSupreme = false
	element = tostring(rest)
	
	if element == "Shadow" and self.db.profile.weakness then
		self:RemoveBar("Shadow weakness!")
		self:Message(string.format(L["debuffwarn"].."Shadow!"), "Important")
		self:Bar("Shadow weakness!", timer.weakness, icon.shadow, true, "green")
		if self.db.profile.bigicon then
			self:WarningSign(icon.shadow, 0.7)
		end
	end
	if element == "Fire" and self.db.profile.weakness then
		self:RemoveBar("Fire weakness!")
		self:Message(string.format(L["debuffwarn"].."Fire!"), "Important")
		self:Bar("Fire weakness!", timer.weakness, icon.fire, true, "green")
		if self.db.profile.bigicon then
			self:WarningSign(icon.fire, 0.7)
		end
	end
	if element == "Frost" and self.db.profile.weakness then
		self:RemoveBar("Frost weakness!")
		self:Message(string.format(L["debuffwarn"].."Frost!"), "Important")
		self:Bar("Frost weakness!", timer.weakness, icon.frost, true, "green")
		if self.db.profile.bigicon then
			self:WarningSign(icon.frost, 0.7)
		end
	end
	if element == "Nature" and self.db.profile.weakness then
		self:RemoveBar("Nature weakness!")
		self:Message(string.format(L["debuffwarn"].."Nature!"), "Important")
		self:Bar("Nature weakness!", timer.weakness, icon.nature, true, "green")
		if self.db.profile.bigicon then
			self:WarningSign(icon.nature, 0.7)
		end
	end
	if element == "Arcane" and self.db.profile.weakness then
		self:RemoveBar("Arcane weakness!")
		self:Message(string.format(L["debuffwarn"].."Arcane!"), "Important")
		self:Bar("Arcane weakness!", timer.weakness, icon.arcane, true, "green")
		if self.db.profile.bigicon then
			self:WarningSign(icon.arcane, 0.7)
		end
	end	
	if self.db.profile.supreme then
		self:CancelDelayedMessage(string.format(L["supremedelaywarn"], 5))
		self:RemoveBar(L["supreme_bar"])
		self:DelayedMessage(timer.supreme-5, string.format(L["supremedelaywarn"], 5), "Important")
		self:Bar(L["supreme_bar"], timer.supreme, icon.supreme, true, "red")
	end
end

function module:Supreme()
	bwOssiSupreme = true
	self:Message(L["supremewarn"], "Attention", nil, "Beware")
	self:RemoveBar("UNKNOWN Supreme timer")
end

function module:Cyclone()
	self:RemoveBar(L["cyclone_bar"])
	self:Bar(L["cyclone_bar"], timer.cyclone, icon.cyclone, true, "white")
	
	if playerClass == "SHAMAN" and self.db.profile.bigicon then
		self:DelayedWarningSign(timer.cyclone - 5, icon.grounding, 1)
	end
end

function module:WarStomp()
	if bwOssiFirstWarstop == false then
		self:RemoveBar(L["warstomp_bar"])
	
		self:Bar(L["warstomp_bar"], timer.warstomp, icon.warstomp, true, "yellow")
		self:DelayedWarningSign(timer.warstomp - 5, icon.warstomp, 1)
	else
		self:Bar(L["warstomp_bar"], timer.firstWarstomp, icon.warstomp, true, "yellow")
		bwOssiFirstWarstop = false
	end
end

function module:ClickIt()
	self:RemoveBar(L["clickit_bar"])
	self:DelayedBar(timer.weakness-16.2, L["clickit_bar"], timer.clickit, icon.clickit, true, "blue")
end
