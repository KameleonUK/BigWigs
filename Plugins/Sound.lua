assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsSound")
--~~ local dewdrop = DewdropLib:GetInstance("1.0")

local sounds = {
	Long = "Interface\\AddOns\\BigWigs\\Sounds\\Long.mp3",
	Info = "Interface\\AddOns\\BigWigs\\Sounds\\Info.ogg",
	Alert = "Interface\\AddOns\\BigWigs\\Sounds\\Alert.mp3",
	Alarm = "Interface\\AddOns\\BigWigs\\Sounds\\Alarm.mp3",
	Victory = "Interface\\AddOns\\BigWigs\\Sounds\\Victory.mp3",

	Beware = "Interface\\AddOns\\BigWigs\\Sounds\\Beware.wav",
	RunAway = "Interface\\AddOns\\BigWigs\\Sounds\\RunAway.wav",

	One = "Interface\\AddOns\\BigWigs\\Sounds\\1.ogg",
	Two = "Interface\\AddOns\\BigWigs\\Sounds\\2.ogg",
	Three = "Interface\\AddOns\\BigWigs\\Sounds\\3.ogg",
	Four = "Interface\\AddOns\\BigWigs\\Sounds\\4.ogg",
	Five = "Interface\\AddOns\\BigWigs\\Sounds\\5.ogg",
	Six = "Interface\\AddOns\\BigWigs\\Sounds\\6.ogg",
	Seven = "Interface\\AddOns\\BigWigs\\Sounds\\7.ogg",
	Eight = "Interface\\AddOns\\BigWigs\\Sounds\\8.ogg",
	Nine = "Interface\\AddOns\\BigWigs\\Sounds\\9.ogg",
	Ten = "Interface\\AddOns\\BigWigs\\Sounds\\10.ogg",

	Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
	Pain = "Sound\\Creature\\Thaddius\\THAD_NAXX_ELECT.wav",

	Plague = "Interface\\AddOns\\BigWigs\\Sounds\\Plague.mp3",

	ShackleBroke = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleBroke.mp3",
	ShackleOne = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleOne.mp3",
	ShackleTwo = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleTwo.mp3",
	ShackleThree = "Interface\\AddOns\\BigWigs\\Sounds\\ShackleThree.mp3",

	MarkOne = "Interface\\AddOns\\BigWigs\\Sounds\\MarkOne.mp3",
	MarkTwo = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTwo.mp3",
	MarkThree = "Interface\\AddOns\\BigWigs\\Sounds\\MarkThree.mp3",
	MarkFour = "Interface\\AddOns\\BigWigs\\Sounds\\MarkFour.mp3",
	MarkFive = "Interface\\AddOns\\BigWigs\\Sounds\\MarkFive.mp3",
	MarkSix = "Interface\\AddOns\\BigWigs\\Sounds\\MarkSix.mp3",
	MarkSeven = "Interface\\AddOns\\BigWigs\\Sounds\\MarkSeven.mp3",
	MarkEight = "Interface\\AddOns\\BigWigs\\Sounds\\MarkEight.mp3",
	MarkNine = "Interface\\AddOns\\BigWigs\\Sounds\\MarkNine.mp3",
	MarkTen = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTen.mp3",
	MarkEleven = "Interface\\AddOns\\BigWigs\\Sounds\\MarkEleven.mp3",
	MarkTwelve = "Interface\\AddOns\\BigWigs\\Sounds\\MarkTwelve.mp3",
	HealerOneRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerOneRotate.mp3",
	HealerTwoRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerTwoRotate.mp3",
	HealerThreeRotate = "Interface\\AddOns\\BigWigs\\Sounds\\HealerThreeRotate.mp3",
	VoidZoneMove = "Interface\\AddOns\\BigWigs\\Sounds\\VoidZoneMove.mp3",

	ShadowFissure = "Interface\\AddOns\\BigWigs\\Sounds\\ShadowFissure.mp3",
	MindControl = "Interface\\AddOns\\BigWigs\\Sounds\\MindControl.mp3",
	FrostBlast = "Interface\\AddOns\\BigWigs\\Sounds\\FrostBlast.mp3",

	Negative = "Interface\\AddOns\\BigWigs\\Sounds\\Negative.mp3",
	Positive = "Interface\\AddOns\\BigWigs\\Sounds\\Positive.mp3",
	NegativeSwitchSides = "Interface\\AddOns\\BigWigs\\Sounds\\NegativeSwitchSides.mp3",
	PositiveSwitchSides = "Interface\\AddOns\\BigWigs\\Sounds\\PositiveSwitchSides.mp3",

	DispelPoison = "Interface\\AddOns\\BigWigs\\Sounds\\DispelPoison.mp3",

	GoBow = "Interface\\AddOns\\BigWigs\\Sounds\\GoBow.mp3",

	Dance = "Interface\\AddOns\\BigWigs\\Sounds\\Dance.mp3",
	FunDance = "Interface\\AddOns\\BigWigs\\Sounds\\FunDance.mp3",

	Scorch = "Interface\\AddOns\\BigWigs\\Sounds\\Scorch.mp3",
	ScorchResist = "Interface\\AddOns\\BigWigs\\Sounds\\ScorchResist.mp3",
	stopcasting = "Interface\\AddOns\\BigWigs\\Sounds\\stopcasting.mp3",
	IgniteDanger = "Interface\\AddOns\\BigWigs\\Sounds\\IgniteDanger.mp3",
	Pyro = "Interface\\AddOns\\BigWigs\\Sounds\\Pyro.mp3",
	DropIgnite = "Interface\\AddOns\\BigWigs\\Sounds\\DropIgnite.mp3",
}


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["Sounds"] = true,
		["sounds"] = true,
		["Options for sounds."] = true,

		["toggle"] = true,
		["Use sounds"] = true,
		["Toggle sounds on or off."] = true,
		["default"] = true,
		["Default only"] = true,
		["Use only the default sound."] = true,
		["channel"] = true,
		["Sound channel"] = true,
		["Volume slider for alert sounds. Master plays them even when game sound effects are muted."] = true,
		["voice"] = true,
		["Spoken warnings"] = true,
		["Speak boss warnings with the voice lines in Sounds\\Voice, in place of the alert sound. Warnings without a voice line play the alert sound as before."] = true,
		["voicepersonal"] = true,
		["Personal warnings"] = true,
		["Speak warnings aimed at you, such as Spark on you or Don't move."] = true,
		["voiceraid"] = true,
		["Raid calls"] = true,
		["Speak calls for the raid, such as Decurse, Interrupt and Taunt now."] = true,
		["voicephase"] = true,
		["Phase changes"] = true,
		["Speak phase changes, such as Phase two and Air phase soon."] = true,
		["voicevuln"] = true,
		["Vulnerabilities"] = true,
		["Speak boss vulnerabilities, such as Chromaggus' and Ossirian's."] = true,
	}
end)

L:RegisterTranslations("esES", function()
	return {
		["Sounds"] = "Sonidos",
		--["sounds"] = true,
		["Options for sounds."] = "Opciones para sonidos",

		--["toggle"] = "Alternar",
		["Use sounds"] = "Usar sonidos",
		["Toggle sounds on or off."] = "Alterna los sonidos activos o desactivos",
		--["default"] = "defecto",
		["Default only"] = "Solamente defecto",
		["Use only the default sound."] = "Solamente usa el sonido por defecto",
	}
end)

L:RegisterTranslations("koKR", function()
	return {
		["Sounds"] = "효과음",
		["Options for sounds."] = "효과음 옵션.",

		["Use sounds"] = "효과음 사용",
		["Toggle sounds on or off."] = "효과음을 켜거나 끔.",
		["Default only"] = "기본음",
		["Use only the default sound."] = "기본음만 사용.",
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["Sounds"] = "Sound",
		["Options for sounds."] = "Optionen f\195\188r Sound.",
		["Use sounds"] = "Sound nutzen",
		["Toggle sounds on or off."] = "Sound aktivieren/deaktivieren.",
		["Default only"] = "Nur Standard",
		["Use only the default sound."] = "Nur Standard Sound.",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Sounds"] = "声音",
		["sounds"] = "声音",
		["Options for sounds."] = "声音相关设置。",
		["toggle"] = "切换",
		["Use sounds"] = "启用声音",
		["Toggle sounds on or off."] = "打开或关闭声音提醒。",
		["default"] = "默认",
		["Default only"] = "仅默认音效",
		["Use only the default sound."] = "仅使用默认报警音。",
	}
end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsSound = BigWigs:NewModule(L["Sounds"])
BigWigsSound.defaultDB = {
	defaultonly = false,
	sound = true,
	channel = "Master",
	voice = false,
	voicepersonal = true,
	voiceraid = true,
	voicephase = true,
	voicevuln = true,
}

local function VoiceGroupToggle(key, name, desc)
	return {
		type = "toggle",
		name = name,
		desc = desc,
		get = function()
			return BigWigsSound.db.profile[key]
		end,
		set = function(v)
			BigWigsSound.db.profile[key] = v
		end,
		disabled = function()
			return not BigWigsSound.db.profile.voice
		end,
	}
end

-- PlaySound takes no channel, so the default raid warning is played from its file instead
local raidWarningFile = "Sound\\Interface\\RaidWarning.wav"

-- Spoken warnings. Each rule is { voice file, group, words that must all appear, words that must not },
-- checked against the lower-cased English warning text; the first rule that fits picks the line,
-- so specific rules come before general ones. The files are in Sounds\Voice (VoiceLines.csv lists them).
local voicePath = "Interface\\AddOns\\BigWigs\\Sounds\\Voice\\"
local voiceGroupOption = { personal = "voicepersonal", raid = "voiceraid", phase = "voicephase", vuln = "voicevuln" }
local voiceRules = {
	{ "SparkOnYou", "personal", {"spark on you"}, {} },
	{ "SparkOnYou", "personal", {"spark attacking you"}, {} },
	{ "YouAreTheBomb", "personal", {"bomb on you"}, {} },
	{ "YouAreTheBomb", "personal", {"you are a bomb"}, {} },
	{ "ChainsOnYou", "personal", {"chains on you"}, {} },
	{ "StackInMelee", "personal", {"on you", "stack in melee"}, {} },
	{ "StackWithRanged", "personal", {"on you", "stack with ranged"}, {} },
	{ "GetOut", "personal", {"mark of the highlord on you"}, {} },
	{ "MoveAwayFromOthers", "personal", {"on you", "get away from others"}, {} },
	{ "MoveAwayFromOthers", "personal", {"you have corruption"}, {} },
	{ "DontMove", "personal", {"you are shackled"}, {} },
	{ "OutOfTheLava", "personal", {"standing in lava"}, {} },
	{ "YouAreTanking", "personal", {"you are tanking"}, {} },
	{ "PositiveCharge", "personal", {"you changed to a positive"}, {} },
	{ "NegativeCharge", "personal", {"you changed to a negative"}, {} },
	{ "RedMoon", "personal", {"you have red moon"}, {} },
	{ "BlueMoon", "personal", {"you have blue moon"}, {} },
	{ "BowToTheQueen", "personal", {"bow to the queen"}, {} },
	{ "YouAreCursed", "personal", {"you are cursed"}, {} },
	{ "FearWardOnYou", "personal", {"you have fear ward"}, {} },
	{ "PoisonedGetDispelled", "personal", {"you've been poisoned"}, {} },
	{ "DirtMoundChasing", "personal", {"chasing you"}, {} },
	{ "LowMana", "personal", {"you have low mana"}, {} },
	{ "KillNetherwalkers", "personal", {"phase shift on you"}, {} },
	{ "StopAttacking", "personal", {"stop killing"}, {} },
	{ "VulnFire", "vuln", {"vulnerability - fire"}, {} },
	{ "VulnFrost", "vuln", {"vulnerability - frost"}, {} },
	{ "VulnNature", "vuln", {"vulnerability - nature"}, {} },
	{ "VulnShadow", "vuln", {"vulnerability - shadow"}, {} },
	{ "VulnArcane", "vuln", {"vulnerability - arcane"}, {} },
	{ "VulnFire", "vuln", {"weak to fire"}, {} },
	{ "VulnFrost", "vuln", {"weak to frost"}, {} },
	{ "VulnNature", "vuln", {"weak to nature"}, {} },
	{ "VulnShadow", "vuln", {"weak to shadow"}, {} },
	{ "VulnArcane", "vuln", {"weak to arcane"}, {} },
	{ "AirPhaseSoon", "phase", {"air phase soon"}, {} },
	{ "LandingSoon", "phase", {"lands very soon"}, {} },
	{ "PhaseFour", "phase", {"phase 4"}, {"soon"} },
	{ "PhaseThree", "phase", {"phase 3"}, {"soon"} },
	{ "PhaseTwo", "phase", {"phase 2"}, {"soon"} },
	{ "PhaseTwo", "phase", {"phase2"}, {"soon"} },
	{ "DontMove", "raid", {"do not move"}, {} },
	{ "TranqNow", "raid", {"tranq"}, {"you cast"} },
	{ "TauntNow", "raid", {"taunt"}, {} },
	{ "WingBuffetSoon", "raid", {"wing buffet in"}, {} },
	{ "Decurse", "raid", {"decurse!"}, {} },
	{ "Decurse", "raid", {"decurse ("}, {} },
	{ "CleanseDisease", "raid", {"cleanse disease"}, {} },
	{ "CleanseDisease", "raid", {"cleanse them"}, {} },
	{ "SoakPoison", "raid", {"soak poison"}, {} },
	{ "Interrupt", "raid", {"interrupt"}, {} },
	{ "MindControl", "raid", {"mind control"}, {} },
	{ "MindControl", "raid", {"mc - dispel"}, {} },
	{ "Dispel", "raid", {"- dispel"}, {} },
	{ "Dispel", "raid", {"dispel!"}, {} },
	{ "Dispel", "raid", {"dispel it"}, {} },
	{ "Dispel", "raid", {"dispel them"}, {} },
	{ "Dispel", "raid", {"dispel the"}, {} },
	{ "Dispel", "raid", {"dispel freeze"}, {} },
	{ "EnrageSoon", "raid", {"enrage in"}, {} },
	{ "EnrageSoon", "raid", {"enrages soon"}, {} },
	{ "EnrageSoon", "raid", {"enrage soon"}, {} },
	{ "Enraged", "raid", {"enraged"}, {"no longer"} },
	{ "BerserkSoon", "raid", {"berserk soon"}, {} },
	{ "BerserkSoon", "raid", {"berserk in"}, {} },
	{ "Berserk", "raid", {"berserk!"}, {} },
	{ "Berserk", "raid", {"is berserk"}, {} },
	{ "Frenzy", "raid", {"frenzy"}, {"fail"} },
	{ "KillTheTotems", "raid", {"kill totems"}, {} },
	{ "KillTheAdds", "raid", {"kill the adds"}, {} },
	{ "KillTheAdds", "raid", {"kill the spawns"}, {} },
	{ "AddsSoon", "raid", {"adds soon"}, {} },
	{ "AddsIncoming", "raid", {"fiends incoming"}, {} },
	{ "AddsIncoming", "raid", {"constructs incoming"}, {} },
	{ "AddsIncoming", "raid", {"mobs incoming"}, {} },
	{ "AddsIncoming", "raid", {"ravens incoming"}, {} },
	{ "AddsIncoming", "raid", {"incoming sons of flame"}, {} },
	{ "SwitchTargets", "raid", {"switch to"}, {} },
	{ "SpreadOut", "raid", {"spread"}, {"spreads on"} },
	{ "VoidZoneMove", "raid", {"void zone"}, {} },
	{ "MoveFromCloud", "raid", {"cloud", "move"}, {"move grobbulus"} },
	{ "MoveFromCloud", "raid", {"poison cloud"}, {} },
	{ "MoveFromCloud", "raid", {"out of the lightning cloud"}, {} },
	{ "MoveFromConflagrate", "raid", {"conflag"}, {} },
	{ "DontStandInFront", "raid", {"stand in front"}, {} },
	{ "DeepBreath", "raid", {"deep breath"}, {} },
	{ "FearSoon", "raid", {"fear soon"}, {} },
	{ "Fear", "raid", {"casting fear"}, {} },
	{ "TeleportSoon", "raid", {"teleport within"}, {} },
	{ "Teleport", "raid", {"teleport!"}, {} },
	{ "HealThroughIt", "raid", {"spam heals"}, {} },
	{ "MeleeRunOut", "raid", {"melee run out"}, {} },
	{ "RunAway", "raid", {"run away"}, {} },
	{ "RunAway", "raid", {"run from"}, {} },
	{ "Move", "raid", {"move!"}, {} },
	{ "Move", "raid", {" - move"}, {} },
}

-- Wyrmguard vulnerabilities ("Skull Wyrmguard: Fire Vulnerability"): one line per mark and school,
-- and the school alone for an unmarked Wyrmguard. They go first, ahead of the general rules.
do
	local marks = { "Star", "Circle", "Diamond", "Triangle", "Moon", "Square", "Cross", "Skull" }
	local schools = { "Fire", "Frost", "Nature", "Shadow", "Arcane" }
	local wyrmguardRules = {}
	for _, mark in ipairs(marks) do
		for _, school in ipairs(schools) do
			table.insert(wyrmguardRules, { "Vuln_" .. mark .. "_" .. school, "vuln",
				{ string.lower(mark) .. " wyrmguard", string.lower(school) .. " vulnerability" }, {} })
		end
	end
	for _, school in ipairs(schools) do
		table.insert(wyrmguardRules, { "Vuln" .. school, "vuln", { "wyrmguard", string.lower(school) .. " vulnerability" }, {} })
	end
	for i = table.getn(wyrmguardRules), 1, -1 do
		table.insert(voiceRules, 1, wyrmguardRules[i])
	end
end

local function FindVoiceLine(text)
	local low = string.lower(text)
	for _, rule in ipairs(voiceRules) do
		local fits = true
		for _, word in ipairs(rule[3]) do
			if not string.find(low, word, 1, true) then
				fits = false
				break
			end
		end
		if fits then
			for _, word in ipairs(rule[4]) do
				if string.find(low, word, 1, true) then
					fits = false
					break
				end
			end
		end
		if fits then
			return rule[1], rule[2]
		end
	end
end

BigWigsSound.consoleCmd = L["sounds"]
BigWigsSound.consoleOptions = {
	type = "group",
	name = L["Sounds"],
	desc = L["Options for sounds."],
	args = {
		[L["toggle"]] = {
			type = "toggle",
			name = L["Sounds"],
			desc = L["Toggle sounds on or off."],
			get = function()
				return BigWigsSound.db.profile.sound
			end,
			set = function(v)
				BigWigsSound.db.profile.sound = v
				BigWigs:ToggleModuleActive(L["Sounds"], v)
			end,
		},
		[L["default"]] = {
			type = "toggle",
			name = L["Default only"],
			desc = L["Use only the default sound."],
			get = function()
				return BigWigsSound.db.profile.defaultonly
			end,
			set = function(v)
				BigWigsSound.db.profile.defaultonly = v
			end,
		},
		[L["channel"]] = {
			type = "text",
			name = L["Sound channel"],
			desc = L["Volume slider for alert sounds. Master plays them even when game sound effects are muted."],
			get = function()
				return BigWigsSound.db.profile.channel
			end,
			set = function(v)
				BigWigsSound.db.profile.channel = v
			end,
			validate = { "Master", "SFX", "Ambience", "Music" },
		},
		[L["voice"]] = {
			type = "toggle",
			name = L["Spoken warnings"],
			desc = L["Speak boss warnings with the voice lines in Sounds\\Voice, in place of the alert sound. Warnings without a voice line play the alert sound as before."],
			get = function()
				return BigWigsSound.db.profile.voice
			end,
			set = function(v)
				BigWigsSound.db.profile.voice = v
			end,
		},
		[L["voicepersonal"]] = VoiceGroupToggle("voicepersonal", L["Personal warnings"], L["Speak warnings aimed at you, such as Spark on you or Don't move."]),
		[L["voiceraid"]] = VoiceGroupToggle("voiceraid", L["Raid calls"], L["Speak calls for the raid, such as Decurse, Interrupt and Taunt now."]),
		[L["voicephase"]] = VoiceGroupToggle("voicephase", L["Phase changes"], L["Speak phase changes, such as Phase two and Air phase soon."]),
		[L["voicevuln"]] = VoiceGroupToggle("voicevuln", L["Vulnerabilities"], L["Speak boss vulnerabilities, such as Chromaggus' and Ossirian's."]),
	}
}

------------------------------
--      Initialization      --
------------------------------

function BigWigsSound:OnEnable()
	self:RegisterEvent("BigWigs_Message")
	self:RegisterEvent("BigWigs_Sound")
end
function BigWigsSound:OnDisable()
	BigWigs:DebugMessage("OnDisable")
end

function BigWigsSound:BigWigs_Message(text, color, noraidsay, sound, broadcastonly)
	if self.db.profile.sound then
		if not text or sound == false or broadcastonly then
			return
		end

		if self:PlayVoice(text) then
			return
		end
		self:Play(sound)
	end
end

-- Spoken warnings: plays the voice line for this warning text, if the option and its group are on.
-- Returns true when a voice line played, so the usual alert sound is skipped.
function BigWigsSound:PlayVoice(text)
	if not self.db.profile.voice or type(text) ~= "string" then
		return
	end
	local file, group = FindVoiceLine(text)
	if file and self.db.profile[voiceGroupOption[group]] then
		PlaySoundFile(voicePath .. file .. ".mp3", self.db.profile.channel or "Master")
		return true
	end
end

function BigWigsSound:BigWigs_Sound(sound)
	if self.db.profile.sound then
		self:Play(sound)
	end
end

-- ClassicAPI's PlaySoundFile takes a channel; on Master, alerts play even with sound effects muted
function BigWigsSound:Play(sound)
	local file = raidWarningFile
	if sounds[sound] and not self.db.profile.defaultonly then
		file = sounds[sound]
	end
	PlaySoundFile(file, self.db.profile.channel or "Master")
end
