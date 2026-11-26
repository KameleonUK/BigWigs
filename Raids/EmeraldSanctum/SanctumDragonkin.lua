local module, L = BigWigs:ModuleDeclaration("Sanctum Dragonkin", "Emerald Sanctum")

module.revision = 30021
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = { "reflect" }
module.trashMod = true
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Emerald Sanctum"],
	AceLibrary("Babble-Zone-2.2")["Emerald Sanctum"],
}

L:RegisterTranslations("enUS", function()
	return {
		cmd = "SanctumDragonkin",

		reflect_cmd = "reflect",
		reflect_name = "Reflect Alert",
		reflect_desc = "Warn for Reflect",


		bar_reflect = "Dragonkin Spell Reflect",
		msg_reflect = "Dragonkin Spell Reflect",
		next_reflect = "Dragonkin Next Reflect in",

		["You have slain %s!"] = true,

	}
end)

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
    cmd = "SanctumDragonkin",

    reflect_cmd = "reflect",
    reflect_name = "反射警报",
    reflect_desc = "圣所龙人获得反射时进行警告",

        
    bar_reflect = "龙人法术反射",
    msg_reflect = "龙人法术反射",
    
    ["You have slain %s!"] = "你已经击败了%s！",
} end )
local timer = {
	reflect = 5,
}
local icon = {
	reflect = "Spell_Arcane_Blink",
}
local color = {
	reflect = "Blue",
}
local syncName = {
	reflect = "SanctumDragonkinReflect" .. module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {27564, "Reflection"}, "ReflectEvent")

	self:ThrottleSync(1, syncName.reflect)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:ReflectEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.reflect)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.reflect and self.db.profile.reflect then
		self:Reflect()
	end
end

function module:Reflect()
	self:Bar(L["bar_reflect"], timer.reflect, icon.reflect, true, color.reflect)
	if (BigWigs:PlayerClass() ~= "WARRIOR") and (BigWigs:PlayerClass() ~= "ROGUE") then
		self:DelayedBar(timer.reflect, L["next_reflect"], timer.reflect, icon.reflect, true, color.reflect)
	end

	if UnitName("Target") ~= nil then
		if UnitName("Target") == "Sanctum Dragonkin" then
			if BigWigs:PlayerClass() == "MAGE" then
				self:WarningSign(icon.reflect, 2)
			elseif BigWigs:PlayerClass() == "WARLOCK" then
				self:WarningSign(icon.reflect, 2)
			end

			if (BigWigs:PlayerClass() ~= "WARRIOR") and (BigWigs:PlayerClass() ~= "ROGUE") then
				self:Message(L["msg_reflect"], "Important", false, nil, false)
				self:Sound("Long")
			end
		end
	end
end
