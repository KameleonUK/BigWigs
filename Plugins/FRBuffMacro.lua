-- Reads buff names from ClassicAPI's aura data instead of scanning a hidden tooltip, and keeps the
-- old behaviour of matching any buff whose name contains the text (case-insensitive).
local function FR_FindBuff(obuff, unit)
	local buff = strlower(obuff)
	if not unit then
		unit = 'player'
	end

	local i = 1
	local aura = C_UnitAuras.GetAuraDataByIndex(unit, i, "HELPFUL")
	while aura do
		if aura.name and strfind(strlower(aura.name), buff, 1, true) then
			return "buff", i, aura.name
		end
		i = i + 1
		aura = C_UnitAuras.GetAuraDataByIndex(unit, i, "HELPFUL")
	end
end

-- 28 yards, the range CheckInteractDistance(unit, 4) used to test
local function InRange(unit)
	local distSq, checked = UnitDistanceSquared(unit)
	return checked and distSq <= 28 * 28
end

local function BuffFireResist()
	for i=1, GetNumRaidMembers() do
		if UnitExists("raidpet"..i) then
			if not FR_FindBuff("Resist Fire","raidpet"..i) and not FR_FindBuff("phase shift","raidpet"..i) then
				if InRange("raidpet"..i) then
					TargetUnit("raidpet"..i)
					CastPetAction(3)
					return
				end
			end
		end
	end

	for i=1, GetNumRaidMembers() do
		if not FR_FindBuff("Resist Fire", "raid"..i) then
			if InRange("raid"..i) then
				TargetUnit("raid"..i)
				CastPetAction(3)
				return
			end
		end
	end
end

SLASH_FRBUFF1 = "/frbuff"
SlashCmdList["FRBUFF"] = BuffFireResist
