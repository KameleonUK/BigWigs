local module, L = BigWigs:ModuleDeclaration("Blackwing Alchemist", "Blackwing Lair")

-- module variables
module.revision = 30141
module.combatLog = true -- triggers from the combat log; the pack is done when none of this name is still fighting (UNIT_DIED)
module.trashMod = true
module.enabletrigger = module.translatedName
module.toggleoptions = { "fire", "firesay", "fireother", "firemark" }

-- module defaults
module.defaultDB = {
	fire = true,
	firesay = true,
	fireother = true,
	firemark = false,
}

-- localization
L:RegisterTranslations("enUS", function()
	return {
		cmd = "BlackwingAlchemist",

		fire_cmd = "fire",
		fire_name = "Alchemist's Fire Alert",
		fire_desc = "Get a personal warning when a Blackwing Alchemist puts Alchemist's Fire on you",

		firesay_cmd = "firesay",
		firesay_name = "Alchemist's Fire Say",
		firesay_desc = "Announce to /say that you have the Alchemist's Fire debuff",

		fireother_cmd = "fireother",
		fireother_name = "Alchemist's Fire Warning",
		fireother_desc = "Get warnings about other players suffering from Alchemist's Fire",

		firemark_cmd = "firemark",
		firemark_name = "Alchemist's Fire Mark",
		firemark_desc = "Mark players suffering from Alchemist's Fire (note: engaging the next pack will clear the mark storage and prevent resetting marks)",


		msg_fire = "Get out of the raid! - Alchemist's Fire",
		msg_fireOther = "Alchemist's Fire on %s",
		bar_fire = "Alchemist's Fire",
		say_fire = "Don't be near me - Alchemist's Fire!",
	}
end)

-- timer and icon variables
local timer = {
	fire = 8,
}

local icon = {
	fire = "INV_Potion_33",
}

local syncName = {
	fire = "BlackwingAlchemistFire" .. module.revision,
}

function module:OnEnable()
	self:RegisterCombatLog("SPELL_AURA_APPLIED", "Alchemist's Fire", "FireEvent")

	self:ThrottleSync(1, syncName.fire)
end

function module:OnSetup()
end

function module:OnEngage()
end

function module:OnDisengage()
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:FireEvent(ev)
	if ev.destName then
		self:Sync(syncName.fire .. " " .. ev.destName)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.fire and rest then
		self:AlchemistsFire(rest)
		return
	end
	local _, _, player = string.find(sync, syncName.fire .. "(.+)")
	if player then
		self:AlchemistsFire(player)
		return
	end
end

function module:AlchemistsFire(player)
	if player == UnitName("player") and self.db.profile.fire then
		self:Message(L["msg_fire"], "Important", true, "RunAway")
		self:Bar(L["bar_fire"], timer.fire, icon.fire, true, "Red")
		if self.db.profile.firesay then
			SendChatMessage(L["say_fire"], "SAY")
		end
	elseif self.db.profile.fireother then
		self:Message(string.format(L["msg_fireOther"],player), "Urgent")
	end
	if self.db.profile.firemark then
		local markToUse = self:GetAvailableRaidMark()
		if markToUse then
			self:SetRaidTargetForPlayer(player, markToUse)
		end
		self:ScheduleEvent("RemoveFireMark"..player, self.RestoreInitialRaidTargetForPlayer, timer.fire, self, player)
	end
end

function module:Test()
	self:Engage()
	
	-- test characters
	local player = UnitName("player")
	local raid1 = UnitName("raid1") or "Raid1"
	local raid2 = UnitName("raid2") or "Raid2"
	local raid3 = UnitName("raid3") or "Raid2"
	
	local events = {
		-- Party Victim
		{ time = 2, func = function()
			local msg = raid1.." is afflicted by Alchemist's Fire."
			print("Test: " .. msg)
			BigWigs:TestCombatLogText(msg)
		end },

		-- Self
		{ time = 10, func = function()
			local msg = "You are afflicted by Alchemist's Fire."
			print("Test: " .. msg)
			BigWigs:TestCombatLogText(msg)
		end },

		-- Spread
		{ time = 18, func = function()
			local msg = raid1.." is afflicted by Alchemist's Fire."
			print("Test: " .. msg)
			BigWigs:TestCombatLogText(msg)
		end },
		{ time = 18, func = function()
			local msg = raid2.." is afflicted by Alchemist's Fire."
			print("Test: " .. msg)
			BigWigs:TestCombatLogText(msg)
		end },
		{ time = 18, func = function()
			local msg = raid3.." is afflicted by Alchemist's Fire."
			print("Test: " .. msg)
			BigWigs:TestCombatLogText(msg)
		end },

		-- End of Test
		{ time = 28, func = function()
			print("Test: Disengage")
			module:Disengage()
		end },
	}
	
	-- Schedule each event
	for i, event in ipairs(events) do
		self:ScheduleEvent("BlackwingAlchemistTest" .. i, event.func, event.time)
	end

	self:Message(module.translatedName .. " test started", "Positive")
	return true
end

-- Test command: /run BigWigs:GetModule("Blackwing Alchemist"):Test()
