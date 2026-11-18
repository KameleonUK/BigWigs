-- First file in BigWigs_ClassicAPI.toc.
-- ClassicAPI selects that TOC, so the DLL is loaded; this checks the DLL is new enough to provide
-- every function BigWigs calls. If anything is missing, BigWigs:OnInitialize / OnEnable keep the
-- addon in standby (they check BIGWIGS_CLASSICAPI_MISSING) instead of erroring mid-fight.
-- Keep REQUIRED in sync with the code: grep the addon for C_ namespaces and other ClassicAPI globals.

local REQUIRED = {
	'C_UnitAuras.GetAuraDataByIndex',
	'C_UnitAuras.GetUnitAuraBySpellID',
	'CancelUnitBuff',
	'C_Timer.NewTimer',
	'UnitGUID',
	'UnitDistanceSquared',
}

local function resolve(path)
	local value = getfenv(0)
	for part in string.gfind(path, '[^%.]+') do
		if type(value) ~= 'table' then return nil end
		value = value[part]
	end
	return value
end

local missing = {}
if not CLASSIC_API_VERSION then
	tinsert(missing, 'CLASSIC_API_VERSION')
end
for _, path in ipairs(REQUIRED) do
	if type(resolve(path)) ~= 'function' then
		tinsert(missing, path)
	end
end

if getn(missing) > 0 then
	BIGWIGS_CLASSICAPI_MISSING = missing
	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_LOGIN')
	f:SetScript('OnEvent', function()
		DEFAULT_CHAT_FRAME:AddMessage('|cffff4040BigWigs: your ClassicAPI is too old. Missing: '
			.. table.concat(missing, ', ') .. '. BigWigs is disabled.|r')
		this:UnregisterAllEvents()
	end)
end
