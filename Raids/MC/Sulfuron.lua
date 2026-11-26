
local module, L = BigWigs:ModuleDeclaration("Sulfuron Harbinger", "Molten Core")

module.revision = 30078
module.combatLog = true -- triggers come from the combat log; boss death from UNIT_DIED
module.enabletrigger = module.translatedName
module.toggleoptions = {"heal", "knockback", "flamespear", "inspire", "shadowwordpain", "immolate", "adds", "bosskill"}
module.wipemobs = {"Flamewaker Priest"}

L:RegisterTranslations("enUS", function() return {
	cmd = "Sulfuron",

	knockback_cmd = "knockback",
	knockback_name = "Hand of Ragnaros Alert",
	knockback_desc = "Warn for Hand of Ragnaros",

	heal_cmd = "heal",
	heal_name = "Dark Mending Alert",
	heal_desc = "Warn for Dark Mending",
	
	flamespear_cmd = "flamespear",
	flamespear_name = "Flame Spear Alert",
	flamespear_desc = "Warn for Flame Spear",
	
	inspire_cmd = "inspire",
	inspire_name = "Inspire Alert",
	inspire_desc = "Warn for Inspire",
	
	shadowwordpain_cmd = "shadowwordpain",
	shadowwordpain_name = "Shadow word: Pain Alert",
	shadowwordpain_desc = "Warn for Shadow word: Pain",
	
	immolate_cmd = "immolate",
	immolate_name = "Immolate Alert",
	immolate_desc = "Warn for Immolate",
	
	adds_cmd = "adds",
	adds_name = "Add Dies Alert",
	adds_desc = "Warn for Adds Deaths",
	
	
	bar_handOfRagnarosCd = "Hand of Ragnaros CD",
	bar_handOfRagnarosDur = "Hand of Ragnaros Stun",
	
	bar_darkMending = "Dark Mending",
	msg_darkMending = "Dark Mending - Interrupt!",
	
	bar_flameSpearCd = "Flame Spear CD",
	bar_flameSpearCast = "Flame Spear!",
	
	bar_inspireDur = "Inspire",
	msg_inspire = "Inspire - Attack Speed +100% & Damage +25%",
	
	msg_shadowWordPain = "Shadow Word: Pain - Dispel!",
	
	msg_immolate = "Immolate - Dispel!",
	
	msg_addDead = "/4 Flamewaker Protectors Dead",
} end)

local timer = {
	handOfRagnarosFirstCd = 6,
	handOfRagnarosCd = 10, --12 - 2
	handOfRagnarosDur = 2,
	
	darkMendingCast = 2,
	
	flameSpearFirstCd = 2,
	flameSpearCd = {12,16},
	flameSpearCast = 1,
	
	inspireDur = 10,
}
local icon = {
	handOfRagnaros = "Spell_Fire_Fireball",
	darkMending = "Spell_Shadow_ChillTouch",
	flameSpear = "Spell_Fire_FlameBlades",
	inspire = "ability_warrior_battleshout",
	shadowWordPain = "spell_shadow_shadowwordpain",
	immolate = "spell_fire_immolation",
}
local color = {
	handOfRagnarosCd = "Black",
	handOfRagnarosDur = "White",
	
	darkMendingCast = "Green",
	
	flameSpearCd = "Red",
	flameSpearCast = "Orange",
	
	inspire = "Blue",
}
local syncName = {
	handOfRagnaros = "SulfuronKnockback"..module.revision,
	darkMending = "SulfuronAddHeal"..module.revision,
	flameSpear = "SulfuronSpear"..module.revision,
	inspire = "SulfuronInspire"..module.revision,
	shadowWordPain = "SulfuronShadowWordPain"..module.revision,
	immolate = "SulfuronImmolate"..module.revision,
	addDead = "SulfuronAddDead"..module.revision,
}

local addDead = 0

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event") --Debug
	
	self:RegisterCombatLog({"SPELL_CAST_SUCCESS", "SPELL_AURA_APPLIED"}, {19780, "Hand of Ragnaros"}, "HandEvent")
	self:RegisterCombatLog("SPELL_CAST_START", {19775, "Dark Mending"}, "DarkMendingEvent")
	self:RegisterCombatLog("SPELL_CAST_START", {19781, "Flame Spear"}, "FlameSpearEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {19779, "Inspire"}, "InspireEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {19776, "Shadow Word: Pain"}, "ShadowWordPainEvent")
	self:RegisterCombatLog("SPELL_AURA_APPLIED", {20294, "Immolate"}, "ImmolateEvent")
	self:RegisterCombatLog("UNIT_DIED", nil, "UnitDied")
	
	
	
	
	
	self:ThrottleSync(1, syncName.darkMending)
	self:ThrottleSync(5, syncName.handOfRagnaros)
	self:ThrottleSync(5, syncName.flameSpear)
	self:ThrottleSync(3, syncName.inspire)
	self:ThrottleSync(3, syncName.shadowWordPain)
	self:ThrottleSync(3, syncName.immolate)
	self:ThrottleSync(0.5, syncName.addDead)
	
end

function module:OnSetup()
	self.started = nil

end

function module:OnEngage()
	addDead = 0
	
	if self.db.profile.knockback then
		self:Bar(L["bar_handOfRagnarosCd"], timer.handOfRagnarosFirstCd, icon.handOfRagnaros, true, color.handOfRagnarosCd)
	end
	if self.db.profile.flamespear then
		self:Bar(L["bar_flameSpearCd"], timer.flameSpearFirstCd, icon.flameSpear, true, color.flameSpearCd)
	end
end

function module:OnDisengage()
end

-- UNIT_DIED: the Flamewaker Priest counter (Sulfuron's own death comes from the core)
function module:UnitDied(ev)
	if ev.destName == "Flamewaker Priest" then
		addDead = addDead + 1
		if addDead <= 4 then
			self:Sync(syncName.addDead .. " " .. addDead)
		end
	end
end

-- combat log handlers; ev is described at RegisterCombatLog in Core.lua
function module:HandEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.handOfRagnaros)
	end
end

function module:DarkMendingEvent(ev)
	if ev.sourceName == "Flamewaker Priest" then
		self:Sync(syncName.darkMending)
	end
end

function module:FlameSpearEvent(ev)
	if ev.sourceName == self.translatedName then
		self:Sync(syncName.flameSpear)
	end
end

function module:InspireEvent(ev)
	if ev.sourceName == self.translatedName or ev.sourceName == "Flamewaker Priest" or ev.destName == self.translatedName then
		self:Sync(syncName.inspire)
	end
end

-- the priests' Shadow Word: Pain and Immolate on a raid member
function module:ShadowWordPainEvent(ev)
	if ev.sourceName == "Flamewaker Priest" and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.shadowWordPain)
	end
end

function module:ImmolateEvent(ev)
	if ev.sourceName == "Flamewaker Priest" and BigWigs:IsGroupMember(ev.destFlags) then
		self:Sync(syncName.immolate)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.handOfRagnaros and self.db.profile.knockback then
		self:HandOfRagnaros()
	
	elseif sync == syncName.darkMending and self.db.profile.heal then
		self:DarkMending()
	
	elseif sync == syncName.flameSpear and self.db.profile.flamespear then
		self:FlameSpear()
	
	elseif sync == syncName.inspire and self.db.profile.inspire then
		self:Inspire()
		
	elseif sync == syncName.shadowWordPain and self.db.profile.shadowwordpain then
		self:ShadowWordPain()
		
	elseif sync == syncName.immolate and self.db.profile.immolate then
		self:Immolate()
		
	elseif sync == syncName.addDead and rest and self.db.profile.adds then
		self:AddDead(rest)
	end
end


function module:HandOfRagnaros()
	self:RemoveBar(L["bar_handOfRagnarosCd"])
	
	self:Bar(L["bar_handOfRagnarosDur"], timer.handOfRagnarosDur, icon.handOfRagnaros, true, color.handOfRagnarosDur)
	self:DelayedBar(timer.handOfRagnarosDur, L["bar_handOfRagnarosCd"], timer.handOfRagnarosCd, icon.handOfRagnaros, true, color.handOfRagnarosCd)
end

function module:DarkMending()
	self:Bar(L["bar_darkMending"], timer.darkMendingCast, icon.darkMending, true, color.darkMendingCast)
	
	if BigWigs:PlayerClass() == "ROGUE" or BigWigs:PlayerClass() == "WARRIOR" or BigWigs:PlayerClass() == "MAGE" then
		self:Message(L["msg_darkMending"], "Urgent", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.darkMending, 0.7)
	end
end

function module:FlameSpear()
	self:RemoveBar(L["bar_flameSpearCd"])
	
	self:Bar(L["bar_flameSpearCast"], timer.flameSpearCast, icon.flameSpear, true, color.flameSpearCast)
	self:DelayedIntervalBar(timer.flameSpearCast, L["bar_flameSpearCd"], timer.flameSpearCd[1], timer.flameSpearCd[2], icon.flameSpear, true, color.flameSpearCd)
end

function module:Inspire()
	self:Bar(L["bar_inspireDur"], timer.inspireDur, icon.inspire, true, color.inspire)
	self:Message(L["msg_inspire"], "Attention", false, nil, false)
end

function module:ShadowWordPain()
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "PALADIN" then
		self:Message(L["msg_shadowWordPain"], "Important", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.shadowWordPain, 0.7)
	end
end

function module:Immolate()
	if BigWigs:PlayerClass() == "PRIEST" or BigWigs:PlayerClass() == "PALADIN" then
		self:Message(L["msg_immolate"], "Important", false, nil, false)
		self:Sound("Info")
		self:WarningSign(icon.immolate, 0.7)
	end
end

function module:AddDead(rest)
	self:Message(rest..L["msg_addDead"], "Positive", false, nil, false)
end
