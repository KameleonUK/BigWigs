
local module, L = BigWigs:ModuleDeclaration("Flesh Hunter", "Ruins of Ahn'Qiraj")

module.revision = 20041
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.enabletrigger = module.translatedName
module.toggleoptions = {}
module.trashMod = true

L:RegisterTranslations("enUS", function() return {
	cmd = "FleshHunter",
	consume_bar = " Consumed!",
} end )

module.defaultDB = {
	bosskill = nil,
}


L:RegisterTranslations("zhCN", function() return {
	-- Wind汉化修复Turtle-WOW中文数据
	-- Last update: 2024-06-22
	cmd = "FleshHunter",
	consume_bar = " 被吞噬!",
	clickme = " >点击我！<",
} end )
local timer = {
	consume = 15,
}

local icon = {
	consume = "spell_nature_drowsy",
}

local syncName = {
	consume = "FleshHunterConsume",
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Consume", "ConsumeEvent")
	self:ThrottleSync(1, syncName.consume)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.consume then
		if rest == UnitName("player") then
			self:Bar(string.format(UnitName("player") .. L["consume_bar"]), timer.consume, icon.consume)
		else
			self:Bar(string.format(rest .. L["consume_bar"] .. " >Click Me!<"), timer.consume, icon.consume)
			self:SetCandyBarOnClick("BigWigsBar "..string.format(rest .. L["consume_bar"] .. " >Click Me!<"), function(name, button, extra) TargetByName(extra, true) end, rest)
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:ConsumeEvent(ev)
	if ev.destName and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.consume .. " " .. ev.destName)
	end
end
