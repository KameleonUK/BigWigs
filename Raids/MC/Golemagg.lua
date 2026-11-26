
local module, L = BigWigs:ModuleDeclaration("Golemagg the Incinerator", "Molten Core")

module.revision = 30075
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"enrage", "earthquake", "magma", "bosskill"}
module.wipemobs = {"Core Rager"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Golemagg",

	enrage_cmd = "enrage",
	enrage_name = "Enrage Alert",
	enrage_desc = "Warn for Enrage",

	earthquake_cmd = "earthquake",
	earthquake_name = "Earthquake Alert",
	earthquake_desc = "Warn for Earthquake",
	
	magma_cmd = "magma",
	magma_name = "Magma Splash Alert",
	magma_desc = "Warn for Magma Splash",
	
	
	msg_enrage = "Golemagg is Enraged - Casting Earthquakes!",
	msg_enrageSoon = "Enrage Soon (at 10%) - Earthquake Soon",
	
	bar_earthquake = "Earthquake",
	
	msg_magmaSplash = "Warning - High Magma Splash Stacks: ",
} end)

local timer = {
	earthquake = 3
}
local icon = {
	enrage = "spell_shadow_unholyfrenzy",
	earthquake = "spell_nature_earthquake",
	magmaSplash = "spell_fire_immolation",
}
local color = {
	earthquake = "Orange",
}
local syncName = {
	enrageSoon = "GolemaggEnrageSoon"..module.revision,
	enrage = "GolemaggEnrage"..module.revision,
	earthquake = "GolemaggEarthquake"..module.revision,
}

local enrageSoon = nil

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterEvent("UNIT_HEALTH")
	
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {19953, "Enrage"}, "EnrageEvent")
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_DAMAGE"}, {19798, "Earthquake"}, "EarthquakeEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED_DOSE", {13879, "Magma Splash"}, "MagmaSplashEvent")
	
	
	
	
	self:ThrottleSync(10, syncName.enrageSoon)
	self:ThrottleSync(10, syncName.enrage)
	self:ThrottleSync(1, syncName.earthquake)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	enrageSoon = nil
end

function module:OnDisengage()
end

function module:UNIT_HEALTH(msg)
	if UnitName(msg) == module.translatedName then
		local healthPct = UnitHealth(msg) * 100 / UnitHealthMax(msg)
		if healthPct > 15 and healthPct <= 20 and enrageSoon == nil and self.db.profile.enrage then
			self:Sync(syncName.enrageSoon)
		elseif healthPct > 21 and enrageSoon == true then
			enrageSoon = nil
		elseif healthPct <= 10 and enrageSoon == nil then
			enrageSoon = true
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:EnrageEvent(ev)
	if ev.destName == self.translatedName then
		self:Sync(syncName.enrage)
	end
end

function module:EarthquakeEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.earthquake)
	end
end

-- your own Magma Splash stacks
function module:MagmaSplashEvent(ev)
	if ev.destGUID and ev.destGUID == UnitGUID("player") and ev.amount and ev.amount >= 12 then
		self:MagmaSplash(ev.amount)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.enrageSoon and self.db.profile.enrage then
		self:EnrageSoon()
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	
	elseif sync == syncName.earthquake and self.db.profile.earthquake then
		self:Earthquake()
	end
end


function module:EnrageSoon()
	enrageSoon = true
	
	if BigWigs:PlayerClass() == "WARRIOR" or BigWigs:PlayerClass() == "ROGUE" or BigWigs:PlayerClass() == "PALADIN" or BigWigs:PlayerClass() == "SHAMAN" or BigWigs:PlayerClass() == "DRUID" then
		self:Message(L["msg_enrageSoon"], "Attention", false, nil, false)
	end
end

function module:Enrage()
	enrageSoon = true
	
	self:WarningSign(icon.enrage, 1)
	self:Message(L["msg_enrage"], "Urgent", false, nil, false)
	self:Sound("Beware")
	self:Earthquake()
end

function module:Earthquake()
	self:Bar(L["bar_earthquake"], timer.earthquake, icon.earthquake, true, color.earthquake)
end

function module:MagmaSplash(rest)
	self:Message(L["msg_magmaSplash"]..rest)
	self:WarningSign(icon.magmaSplash, 0.7)
end
