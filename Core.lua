------------------------------
--      Are you local?      --
------------------------------

local BZ = AceLibrary("Babble-Zone-2.2")
local BB = AceLibrary("Babble-Boss-2.2")
local L = AceLibrary("AceLocale-2.2"):new("BigWigs")

local surface = AceLibrary("Surface-1.0")

surface:Register("Armory", "Interface\\AddOns\\BigWigs\\Textures\\Armory")
surface:Register("BantoBar", "Interface\\AddOns\\BigWigs\\Textures\\default")
surface:Register("Charcoal", "Interface\\AddOns\\BigWigs\\Textures\\Charcoal")
surface:Register("DragonFlight", "Interface\\AddOns\\BigWigs\\Textures\\DF-bar")
surface:Register("Glaze", "Interface\\AddOns\\BigWigs\\Textures\\glaze")
surface:Register("Otravi", "Interface\\AddOns\\BigWigs\\Textures\\otravi")
surface:Register("Smooth", "Interface\\AddOns\\BigWigs\\Textures\\smooth")



----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["%s mod enabled"] = true,
		["Target monitoring enabled"] = true,
		["Target monitoring disabled"] = true,
		["%s engaged!"] = true,
		["%s has been defeated"] = true, -- "<boss> has been defeated"
		["%s have been defeated"] = true, -- "<bosses> have been defeated"

		-- AceConsole strings
		["boss"] = true,
		["Bosses"] = true,
		["Options for boss modules."] = true,
		["Options for bosses in %s."] = true, -- "Options for bosses in <zone>"
		["Options for %s (r%s)."] = true, -- "Options for <boss> (<revision>)"
		["plugin"] = true,
		["Plugins"] = true,
		["Options for plugins."] = true,
		["extra"] = true,
		["Extras"] = true,
		["Options for extras."] = true,
		["toggle"] = true,
		["Active"] = true,
		["Activate or deactivate this module."] = true,
		["reboot"] = true,
		["rebootall"] = true,
		["Reboot"] = true,
		["Reboot All"] = true,
		["Reboot this module."] = true,
		["debug"] = true,
		["Debugging"] = true,
		["Show debug messages."] = true,
		["Forces the module to reset for everyone in the raid.\n\n(Requires assistant or higher)"] = true,
		["%s has requested forced reboot for the %s module."] = true,
		bosskill_cmd = "kill",
		bosskill_name = "Boss death",
		bosskill_desc = "Announce when boss is defeated",

		["Other"] = true,
		["Load"] = true,
		["Load All"] = true,
		["Load all %s modules."] = true,

		-- AceConsole zone commands
		["Zul'Gurub"] = "ZG",
		["Molten Core"] = "MC",
		["Blackwing Lair"] = "BWL",
		["Ahn'Qiraj"] = "AQ40",
		["Ruins of Ahn'Qiraj"] = "AQ20",
		["Onyxia's Lair"] = "Onyxia",
		["Naxxramas"] = "Naxxramas",
		["Emerald Sanctum"] = "EmeraldSanctum",
		["Tower of Karazhan"] = "Karazhan",
		["Dire Maul"] = "DireMaul",
		["Blackrock Spire"] = "BlackrockSpire",
		["The Black Morass"] = "BlackMorass",
		["Timbermaw Hold"] = "TMH",
		["Silithus"] = true,
		["Outdoor Raid Bosses"] = "Outdoor",
		["Outdoor Raid Bosses Zone"] = "Outdoor Raid Bosses", -- DO NOT EVER TRANSLATE untill I find a more elegant option

		["Battlegrounds"] = true,
		["Alterac Valley"] = true,
		["Arathi Basin"] = true,

		--Name for exception bosses (neutrals that enable modules)
		["Vaelastrasz the Corrupt"] = true,
		["Lord Victor Nefarius"] = true,
		["Solnius"] = true,
		["Lieutenant General Andorov"] = true,

		["You have slain %s!"] = true,
	}
end)

L:RegisterTranslations("esES", function()
	return {
		["%s mod enabled"] = "Módulo de %s activado",
		["Target monitoring enabled"] = "Monitorización del objetivo activado",
		["Target monitoring disabled"] = "Monitorización del objetivo desactivado",
		["%s engaged!"] = "¡Entrando en combate con %s!",
		["%s has been defeated"] = "%s fue derrotado", -- "<boss> has been defeated"
		["%s have been defeated"] = "%s fueron derrotados", -- "<bosses> have been defeated"

		-- AceConsole strings
		--["boss"] = "jefe",
		["Bosses"] = "Jefes",
		["Options for boss modules."] = "Opciones para módulos del jefe",
		["Options for bosses in %s."] = "Opciones para jefes en %s", -- "Options for bosses in <zone>"
		["Options for %s (r%s)."] = "Opciones para %s (r%s).", -- "Options for <boss> (<revision>)"
		--["plugin"] = "plugin",
		["Plugins"] = "Plugins",
		["Options for plugins."] = "Opciones para plugins",
		--["extra"] = "extra",
		["Extras"] = "Extras",
		["Options for extras."] = "Opciones para extras",
		--["toggle"] = "alternar",
		["Active"] = "Activo",
		["Activate or deactivate this module."] = "Activa o desactiva este módulo",
		--["reboot"] = "reiniciar",
		--["rebootall"] = "reiniciartodos",
		["Reboot"] = "Reiniciar",
		["Reboot All"] = "Reiniciar Todos",
		["Reboot this module."] = "Reinicia este módulo",
		--["debug"] = "depurar",
		["Debugging"] = "Depurando",
		["Show debug messages."] = "Muestra mensajes de depura",
		["Forces the module to reset for everyone in the raid.\n\n(Requires assistant or higher)"] = "Obliga al módulo que se reinicia para todos en la banda.\n\n(Requiere que seas asistente o líder)",
		["%s has requested forced reboot for the %s module."] = "%s solicita un reinicio para el módulo %s",
		--bosskill_cmd = "kill",
		bosskill_name = "Muerte del Jefe",
		bosskill_desc = "Anuncia cuando sea derrotado el jefe",

		["Other"] = "Otro",
		["Load"] = "Cargar",
		["Load All"] = "Cargar todos",
		["Load all %s modules."] = "Carga todos los módulos %s",

		-- AceConsole zone commands
		["Zul'Gurub"] = "ZG",
		["Molten Core"] = "NM",
		["Blackwing Lair"] = "GAN",
		["Ahn'Qiraj"] = "AQ40",
		["Ruins of Ahn'Qiraj"] = "AQ20",
		["Onyxia's Lair"] = "Onyxia",
		["Naxxramas"] = "Naxxramas",
		["Emerald Sanctum"] = "EmeraldSanctum",
		["Silithus"] = "Silithus",
		["Outdoor Raid Bosses"] = "Afuera",
		-- ["Outdoor Raid Bosses Zone"] = "Outdoor Raid Bosses", -- DO NOT EVER TRANSLATE untill I find a more elegant option

		--Name for exception bosses (neutrals that enable modules)
		["Vaelastrasz the Corrupt"] = "Vaelastrasz el Corrupto",
		["Lord Victor Nefarius"] = "Lord Victor Nefarius",

		["You have slain %s!"] = "¡Has matado %s!",
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["%s mod enabled"] = "%s Modul aktiviert",
		["Target monitoring enabled"] = "Zielüberwachung aktiviert",
		["Target monitoring disabled"] = "Zielüberwachung deaktiviert",
		["%s engaged!"] = "%s angegriffen!",
		["%s has been defeated"] = "%s wurde besiegt", -- "<boss> has been defeated"
		["%s have been defeated"] = "%s wurden besiegt", -- "<bosses> have been defeated"

		-- AceConsole strings
		-- ["boss"] = true,
		["Bosses"] = "Bosse",
		["Options for boss modules."] = "Optionen für Boss Module.",
		["Options for bosses in %s."] = "Optionen für Bosse in %s.", -- "Options for bosses in <zone>"
		["Options for %s (r%s)."] = "Optionen für %s (r%s).", -- "Options for <boss> (<revision>)"
		-- ["plugin"] = true,
		["Plugins"] = "Plugins",
		["Options for plugins."] = "Optionen für Plugins.",
		-- ["extra"] = true,
		["Extras"] = "Extras",
		["Options for extras."] = "Optionen für Extras.",
		-- ["toggle"] = true,
		["Active"] = "Aktivieren",
		["Activate or deactivate this module."] = "Aktiviert oder deaktiviert dieses Modul.",
		-- ["reboot"] = true,
		["Reboot"] = "Neustarten",
		["Reboot All"] = "Alles Neustarten",
		["Reboot this module."] = "Startet dieses Modul neu.",
		-- ["debug"] = true,
		["Debugging"] = "Debugging",
		["Show debug messages."] = "Zeige Debug Nachrichten.",
		["Forces the module to reset for everyone in the raid.\n\n(Requires assistant or higher)"] = "Erzwingt dass das Modul für jeden im Raid zurückgesetzt wird.\n\n(Benötigt Schlachtzugleiter oder Assistent)",
		["%s has requested forced reboot for the %s module."] = "%s hat einen Zwangsneustart für das %s-Modul beantragt.",
		-- bosskill_cmd = "kill",
		bosskill_name = "Boss besiegt",
		bosskill_desc = "Melde, wenn ein Boss besiegt wurde.",

		-- AceConsole zone commands
		["Zul'Gurub"] = "ZG",
		["Molten Core"] = "MC",
		["Blackwing Lair"] = "BWL",
		["Ahn'Qiraj"] = "AQ40",
		["Ruins of Ahn'Qiraj"] = "AQ20",
		["Onyxia's Lair"] = "Onyxia",
		["Naxxramas"] = "Naxxramas",
		["Emerald Sanctum"] = "EmeraldSanctum",
		-- ["Silithus"] = true,
		["Outdoor Raid Bosses"] = "Outdoor",
		-- ["Outdoor Raid Bosses Zone"] = "Outdoor Raid Bosses", -- DO NOT EVER TRANSLATE untill I find a more elegant option

		["You have slain %s!"] = "Ihr habt %s getötet!",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["%s mod enabled"] = "%s 模块已启用",
		["Target monitoring enabled"] = "目标监视已启用",
		["Target monitoring disabled"] = "目标监视已禁用",
		["%s engaged!"] = "%s 开战！",
		["%s has been defeated"] = "%s 已被击败",
		["%s have been defeated"] = "%s 已被击败",

		["boss"] = "boss",
		["Bosses"] = "Boss 模块",
		["Options for boss modules."] = "Boss 模块设置。",
		["Options for bosses in %s."] = "%s 的 Boss 模块设置。",
		["Options for %s (r%s)."] = "%s (r%s) 的设置。",
		["plugin"] = "插件",
		["Plugins"] = "插件模块",
		["Options for plugins."] = "插件模块设置。",
		["extra"] = "额外",
		["Extras"] = "额外功能",
		["Options for extras."] = "额外功能设置。",
		["toggle"] = "切换",
		["Active"] = "启用",
		["Activate or deactivate this module."] = "启用或停用此模块。",
		["reboot"] = "重启",
		["rebootall"] = "重启全部",
		["Reboot"] = "重启",
		["Reboot All"] = "重启全部",
		["Reboot this module."] = "重启此模块。",
		["debug"] = "调试",
		["Debugging"] = "调试",
		["Show debug messages."] = "显示调试信息。",
		["Forces the module to reset for everyone in the raid.\n\n(Requires assistant or higher)"] = "强制重置团队中所有人的模块。\n\n(需要助理或更高权限)",
		["%s has requested forced reboot for the %s module."] = "%s 请求强制重启 %s 模块。",
		bosskill_cmd = "kill",
		bosskill_name = "Boss 死亡",
		bosskill_desc = "当 Boss 被击败时通告",

		["Other"] = "其他",
		["Load"] = "加载",
		["Load All"] = "加载全部",
		["Load all %s modules."] = "加载所有 %s 模块。",

		["Zul'Gurub"] = "ZG",
		["Molten Core"] = "MC",
		["Blackwing Lair"] = "BWL",
		["Ahn'Qiraj"] = "AQ40",
		["Ruins of Ahn'Qiraj"] = "AQ20",
		["Onyxia's Lair"] = "Onyxia",
		["Naxxramas"] = "Naxxramas",
		["Emerald Sanctum"] = "EmeraldSanctum",
		["Tower of Karazhan"] = "Karazhan",
		["Dire Maul"] = "DireMaul",
		["Blackrock Spire"] = "BlackrockSpire",
		["The Black Morass"] = "BlackMorass",
		["Silithus"] = "Silithus",
		["Outdoor Raid Bosses"] = "Outdoor",
		["Outdoor Raid Bosses Zone"] = "Outdoor Raid Bosses",

		["Battlegrounds"] = "战场",
		["Alterac Valley"] = "Alterac Valley",
		["Arathi Basin"] = "Arathi Basin",

		["Vaelastrasz the Corrupt"] = "堕落的瓦拉斯塔兹",
		["Lord Victor Nefarius"] = "维克多·奈法里奥斯领主",
		["Solnius"] = "索尔纽斯",
		["Lieutenant General Andorov"] = "安多洛夫中将",

		["You have slain %s!"] = "你击杀了 %s！",
	}
end)


---------------------------------
--      Addon Declaration      --
---------------------------------

BigWigs = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1")
BigWigs:SetModuleMixins("AceDebug-2.0", "AceEvent-2.0", "CandyBar-2.2")
BigWigs:RegisterDB("BigWigsDB", "BigWigsDBPerChar")
BigWigs.cmdtable = {
	type = "group",
	handler = BigWigs,
	args = {
		[L["boss"]] = {
			type = "group",
			name = L["Bosses"],
			desc = L["Options for boss modules."],
			order = 1,
			args = {},
			disabled = function()
				return not BigWigs:IsActive()
			end,
		},
		[L["plugin"]] = {
			type = "group",
			name = L["Plugins"],
			desc = L["Options for plugins."],
			order = 2,
			args = {},
			disabled = function()
				return not BigWigs:IsActive()
			end,
		},
		[L["extra"]] = {
			type = "group",
			name = L["Extras"],
			desc = L["Options for extras."],
			order = 3,
			args = {},
			disabled = function()
				return not BigWigs:IsActive()
			end,
		},
		["editlayout"] = {
			type = "execute",
			name = "Edit Layout",
			order = 4,
			desc = "Edit frame layout and alert sizes",
			func = function()
				BigWigs:EditLayout()
			end,
			disabled = function()
				return not BigWigs:IsActive()
			end,
		},
		["priest"] = {
			type = "execute",
			name = "Priest Healer Profile",
			order = 5,
			desc = "Optimize BigWigs for Priest Healers (compact bars, no screen flash, clutter disabled).",
			func = function()
				BigWigs:OptimizeHealerProfile()
			end,
		},
		["test"] = {
			type = "execute",
			name = "Test / Preview",
			order = 6,
			desc = "Start or stop a test of BigWigs timer bars, messages, and warning icons.",
			func = function()
				if not BigWigs:IsModuleActive("Test") and BigWigs:HasModule("Test") then
					BigWigs:ToggleModuleActive("Test", true)
				end
				if BigWigsTest and BigWigsTest.BigWigs_Test then
					BigWigsTest:BigWigs_Test()
				else
					BigWigs:TriggerEvent("BigWigs_Test")
				end
			end,
		},
		["preview"] = {
			type = "execute",
			name = "Preview Bars & Layout",
			order = 7,
			desc = "Preview timer bars, messages, and layout.",
			func = function()
				if not BigWigs:IsModuleActive("Test") and BigWigs:HasModule("Test") then
					BigWigs:ToggleModuleActive("Test", true)
				end
				if BigWigsTest and BigWigsTest.BigWigs_Test then
					BigWigsTest:BigWigs_Test()
				else
					BigWigs:TriggerEvent("BigWigs_Test")
				end
			end,
		},
	}
}
BigWigs:RegisterChatCommand({ "/bw", "/BigWigs" }, BigWigs.cmdtable)
BigWigs.debugFrame = ChatFrame1
BigWigs.revision = tonumber(GetAddOnMetadata("BigWigs", "X-Revision")) or 0
BigWigs.markUnitsWhenNotRaidLeader = false -- too many people marking causes issues, can turn on if needed

function BigWigs:OptimizeHealerProfile()
	if not self:IsActive() then
		self:ToggleActive(true)
	end

	-- 1. Configure Bars: compact, clean anchor, no screen flashes, no jumping
	if BigWigsBars and BigWigsBars.db and BigWigsBars.db.profile then
		BigWigsBars.db.profile.scale = 0.85
		BigWigsBars.db.profile.width = 185
		BigWigsBars.db.profile.height = 14
		BigWigsBars.db.profile.growup = false
		BigWigsBars.db.profile.texture = "BantoBar"
		BigWigsBars.db.profile.posx = 960
		BigWigsBars.db.profile.posy = 700
		BigWigsBars.db.profile.emphasize = true
		BigWigsBars.db.profile.emphasizeMove = false
		BigWigsBars.db.profile.emphasizeFlash = false
		BigWigsBars.db.profile.emphasizeScale = 1.05
		BigWigsBars.db.profile.duration = 0.5
		BigWigsBars.db.profile.intervalbar = true
		if BigWigsBars.frames and BigWigsBars.frames.anchor then
			BigWigsBars.frames.anchor:ClearAllPoints()
			BigWigsBars.frames.anchor:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", 960, 700)
		end
	end

	-- 2. Configure Messages: compact, clean top-center anchor
	if BigWigsMessages and BigWigsMessages.db and BigWigsMessages.db.profile then
		BigWigsMessages.db.profile.scale = 0.85
		BigWigsMessages.db.profile.usecolors = true
		BigWigsMessages.db.profile.posx = 650
		BigWigsMessages.db.profile.posy = 720
		if BigWigsMessages.frames and BigWigsMessages.frames.anchor then
			BigWigsMessages.frames.anchor:ClearAllPoints()
			BigWigsMessages.frames.anchor:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", 650, 720)
		end
		if BigWigsMessages.msgframe then
			BigWigsMessages.msgframe:SetScale(0.85)
		end
	end

	-- 3. Configure Common Auras: keep tank & dispel defensives, silence toy & portal spam
	if BigWigsCommonAuras and BigWigsCommonAuras.db and BigWigsCommonAuras.db.profile then
		local cap = BigWigsCommonAuras.db.profile
		cap.fearward = true
		cap.shieldwall = true
		cap.laststand = true
		cap.lifegivinggem = true
		cap.challengingshout = true
		cap.challengingroar = true
		cap.spiritlink = true
		cap.di = true
		cap.bop = true
		cap.powerinfusion = true
		cap.lip = true
		cap.portal = false
		cap.wormhole = false
		cap.orange = false
		cap.soulwell = false
		cap.shutdown = false
		cap.invis = false
		cap.deepwood = false
		cap.broadcast = false
		cap.aq40artifact = false
		cap.aq40insignia = false
	end

	-- 4. Configure BossBlock: suppress chat and emote clutter during encounters
	if BigWigsBossBlock and BigWigsBossBlock.db and BigWigsBossBlock.db.profile then
		local bbp = BigWigsBossBlock.db.profile
		bbp.hideraidchat = true
		bbp.hideraidwarnchat = true
		bbp.hideraidwarn = true
		bbp.hideraidsay = true
		bbp.hidetells = true
	end

	-- 5. Configure Spell Requests: disable floating button frames
	if BigWigsSpellRequests and BigWigsSpellRequests.db and BigWigsSpellRequests.db.profile then
		local srp = BigWigsSpellRequests.db.profile
		srp.showrequestsframe = false
		srp.showcooldownsframe = false
		srp.barDuration = 4
	end

	-- 6. Configure Warning Sign: compact and clean
	if BigWigsWarningSign and BigWigsWarningSign.db and BigWigsWarningSign.db.profile then
		local wsp = BigWigsWarningSign.db.profile
		wsp.scale = 0.65
		wsp.alpha = 0.75
		wsp.posx = 640
		wsp.posy = 560
	end

	-- 7. Disable noisy non-healer plugins
	local noiseModules = {
		"MageTools",
		"Tranq",
		"Zombie Food",
		"Target Monitor",
		"Threat",
		"Resist Check",
		"RaidOfficer",
		"Combat Announcement",
	}
	for _, modName in ipairs(noiseModules) do
		if self:HasModule(modName) and self:IsModuleActive(modName) then
			self:ToggleModuleActive(modName, false)
		end
	end

	-- 8. Ensure essential plugins are active
	local essentialPlugins = {
		"Bars",
		"Messages",
		"Colors",
		"Sounds",
		"BossBlock",
		"Common Auras",
		"WarningSign",
		"Range",
		"Proximity",
	}
	for _, plugName in ipairs(essentialPlugins) do
		if self:HasModule(plugName) and not self:IsModuleActive(plugName) then
			self:ToggleModuleActive(plugName, true)
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[BigWigs]|r Profile optimized for |cffffd100Priest Healer|r! Visual clutter reduced, timers slimmed, and screen flashes disabled.")
end

function BigWigs:EditLayout()
	BigWigsBars:BigWigs_ShowAnchors()
	BigWigsMessages:BigWigs_ShowAnchors()
	BigWigsWarningSign:ShowAnchor()

	-- if mage show mage tools anchor
	local _, englishClass = UnitClass("player");
	if englishClass == "MAGE" then
		BigWigsMageTools:ShowAnchors()
	end
end

function BigWigs:DebugMessage(msg, module)
	if not msg then
		msg = ""
	end
	local prefix = "|cfB34DFFf[BigWigs Debug]|r - ";
	local core = BigWigs
	local debugFrame = DEFAULT_CHAT_FRAME
	if module then
		if module.core then
			core = module.core
		end
		if module.debugFrame then
			debugFrame = self.debugFrame
		end
	end

	if core:IsDebugging() then
		(debugFrame or DEFAULT_CHAT_FRAME):AddMessage(prefix .. msg)
	end
end

--------------------------------
--      Module Prototype      --
--------------------------------

-- do not override
BigWigs.modulePrototype.core = BigWigs
BigWigs.modulePrototype.debugFrame = ChatFrame1
BigWigs.modulePrototype.engaged = false
BigWigs.modulePrototype.bossSync = nil -- "Ouro"

-- override
BigWigs.modulePrototype.revision = 1 -- To be overridden by the module!
BigWigs.modulePrototype.started = false
BigWigs.modulePrototype.zonename = nil -- AceLibrary("Babble-Zone-2.2")["Ahn'Qiraj"]
BigWigs.modulePrototype.enabletrigger = nil -- boss
BigWigs.modulePrototype.wipemobs = nil -- adds that will be considered in CheckForEngage
BigWigs.modulePrototype.toggleoptions = nil -- {"sweep", "sandblast", "scarab", -1, "emerge", "submerge", -1, "berserk", "bosskill"}
BigWigs.modulePrototype.proximityCheck = nil -- function(unit) return CheckInteractDistance(unit, 2) end
BigWigs.modulePrototype.proximitySilent = nil -- false

-- do not override
function BigWigs.modulePrototype:IsBossModule()
	return self.zonename and self.enabletrigger and true
end
-- do not override
function BigWigs.modulePrototype:DebugMessage(msg)
	self.core:DebugMessage(msg, self)
end
-- do not override
function BigWigs.modulePrototype:OnInitialize()
	-- Unconditionally register, this shouldn't happen from any other place
	-- anyway.
	self.core:RegisterModule(self.name, self)

	-- Notify observers that we have loaded.
	self:TriggerEvent("BigWigs_ModuleLoaded", self.name, self)

	-- workaround to trigger OnSetup if enabled manually
	self:RegisterEvent("Ace2_AddonEnabled")
end
function BigWigs.modulePrototype:Ace2_AddonEnabled(module)
	if module and type(module) == "table" and module:ToString() == self:ToString() and self:IsBossModule() then
		BigWigs:SetupModule(module:ToString())
	end
end


-- override
function BigWigs.modulePrototype:OnSetup()
end
function BigWigs.modulePrototype:OnEngage()
end
function BigWigs.modulePrototype:OnDisengage()
end

-- do not override
function BigWigs.modulePrototype:Engage()
	self:DebugMessage("Engage() " .. self:ToString())

	if not BigWigs:IsActive() then
		BigWigs:ToggleActive(true)
	end

	if not BigWigs:IsModuleActive(self) then
		BigWigs:EnableModule(self:ToString())
	end

	if self.bossSync and not self.engaged then
		self.engaged = true
		self:Message(string.format(L["%s engaged!"], self.translatedName), "Positive")

		BigWigsBossRecords:StartBossfight(self)

		self.storedPlayerMarks = {}

		-- store initial marks for disengage
		self.initialPlayerMarks = {}
		self.recentlyUsedMarks = {}

		if IsRaidLeader() or BigWigs.markUnitsWhenNotRaidLeader then
			for i = 1, GetNumRaidMembers() do
				local playerUnit = "raid" .. i
				local playerName = UnitName(playerUnit)
				if playerName then
					self.initialPlayerMarks[playerName] = GetRaidTargetIndex(playerUnit) or 0
				end
			end
		end

		self:OnEngage()
	end
end
function BigWigs.modulePrototype:Disengage()
	if BigWigs:IsModuleActive(self) then
		self.engaged = false
		self.started = false

		self:CancelAllScheduledEvents()

		BigWigsAutoReply:EndBossfight()

		self:RemoveIcon()
		self:RemoveWarningSign("", true)
		BigWigsBars:Disable(self)
		if BigWigsBars.BigWigs_HideCounterBars then
			BigWigsBars:BigWigs_HideCounterBars()
		end

		self:RemoveProximity()

		if self.initialPlayerMarks then
			for player in pairs(self.initialPlayerMarks) do
				self:RestoreInitialRaidTargetForPlayer(player)
			end
			self.initialPlayerMarks = {}
		end

		self.recentlyUsedMarks = {}

		self:OnDisengage()
	end
end
function BigWigs.modulePrototype:Victory()
	if self.engaged then
		if self.db.profile.bosskill then
			self:Message(string.format(L["%s has been defeated"], self.translatedName), "Bosskill", nil)
			--Screenshot()
		end

		BigWigsBossRecords:EndBossfight(self)

		self:DebugMessage("Boss dead, disabling module [" .. self:ToString() .. "].")
		self.core:DisableModule(self:ToString())
	end
end
function BigWigs.modulePrototype:Disable()
	self.castEventUnits = nil

	self:Disengage()
	self.core:ToggleModuleActive(self, false)
end

-- synchronize functions
function BigWigs.modulePrototype:GetEngageSync()
	return "BossEngaged"
end

function BigWigs.modulePrototype:SendEngageSync()
	if self.bossSync then
		--self:TriggerEvent("BigWigs_SendSync", "BossEngaged "..self:ToString())
		self:Sync(self:GetEngageSync() .. " " .. self.bossSync)
	end
end

function BigWigs.modulePrototype:GetWipeSync()
	return "BossWipe"
end
--[[function BigWigs.modulePrototype:SendWipeSync()
if self.bossSync then
--self:TriggerEvent("BigWigs_SendSync", "BossEngaged "..self:ToString())
self:Sync(self:GetWipeSync() .. " " .. self.bossSync)
end
end]]

function BigWigs.modulePrototype:GetBossDeathSync()
	return "BossDeath"
end
function BigWigs.modulePrototype:SendBossDeathSync()
	if self.bossSync then
		--self:TriggerEvent("BigWigs_SendSync", "Bosskill "..self.bossSync)
		self:Sync(self:GetBossDeathSync() .. " " .. self.bossSync)
	end
end

-- Add to BigWigs.modulePrototype section in Core.lua
function BigWigs.modulePrototype:SetRaidTargetForPlayer(player, mark)
	if not IsRaidLeader() and not BigWigs.markUnitsWhenNotRaidLeader then
		return false
	end

	local playerUnit = nil
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid" .. i) == player then
			playerUnit = "raid" .. i
			break
		end
	end

	if not playerUnit then
		return false
	end

	-- Store previous mark before changing it
	local previousMark = GetRaidTargetIndex(playerUnit) or 0
	if not self.storedPlayerMarks then
		self.storedPlayerMarks = {}
	end
	self.storedPlayerMarks[player] = previousMark

	-- Store initial mark if not already stored
	if not self.initialPlayerMarks then
		self.initialPlayerMarks = {}
	end
	if self.initialPlayerMarks[player] == nil then
		self.initialPlayerMarks[player] = previousMark
	end

	-- look up mark index if name string was input
	if type(mark) == "string" then
		mark = BigWigs:RaidTargetLookup(mark)
	end

	SetRaidTarget(playerUnit, mark)
	return true
end

function BigWigs.modulePrototype:GetAvailableRaidMark(excludeMarks, reverse)
	excludeMarks = excludeMarks or {}
	local usedMarks = {}
	local currentTime = GetTime()

	-- Initialize recentlyUsedMarks if needed
	if not self.recentlyUsedMarks then
		self.recentlyUsedMarks = {}
	end

	-- Mark existing raid targets as used
	for i = 1, GetNumRaidMembers() do
		local mark = GetRaidTargetIndex("raid" .. i)
		if mark then
			usedMarks[mark] = true
		end
	end

	-- Add excluded marks to used marks
	for _, mark in ipairs(excludeMarks) do
		local markIndex = type(mark) == "string" and BigWigs:RaidTargetLookup(mark) or mark
		if markIndex then
			usedMarks[markIndex] = true
		end
	end

	-- Add recently used marks (within the last second) to used marks
	for mark, timestamp in pairs(self.recentlyUsedMarks) do
		if currentTime - timestamp < 1 then
			usedMarks[mark] = true
		end
	end

	local start, stop, step = 8, 1, -1
	if reverse then start, stop, step = 1, 8, 1 end

	-- Find first available mark (prioritizing skull/8, then down to 1)
	for i = start, stop, step do
		if not usedMarks[i] then
			-- Record this mark as recently used with current timestamp
			self.recentlyUsedMarks[i] = currentTime
			return i
		end
	end

	return nil -- No marks available
end

function BigWigs.modulePrototype:RestorePreviousRaidTargetForPlayer(player)
	if not IsRaidLeader() and not BigWigs.markUnitsWhenNotRaidLeader then
		return false
	end

	if not self.storedPlayerMarks or not self.storedPlayerMarks[player] then
		return false
	end

	local playerUnit = nil
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid" .. i) == player then
			playerUnit = "raid" .. i
			break
		end
	end

	if not playerUnit then
		return false
	end

	SetRaidTarget(playerUnit, self.storedPlayerMarks[player])
	self.storedPlayerMarks[player] = nil

	return true
end

function BigWigs.modulePrototype:RestoreInitialRaidTargetForPlayer(player)
	if not IsRaidLeader() and not BigWigs.markUnitsWhenNotRaidLeader then
		return false
	end

	if not self.initialPlayerMarks or not self.initialPlayerMarks[player] then
		return false
	end

	local playerUnit = nil
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid" .. i) == player then
			playerUnit = "raid" .. i
			break
		end
	end

	if not playerUnit then
		return false
	end

	SetRaidTarget(playerUnit, self.initialPlayerMarks[player])

	return true
end


-- event handler
local yellTriggers = {} -- [i] = {yell, bossmod}
function BigWigs.modulePrototype:RegisterYellEngage(yell)
	-- Bosses with Yells as Engagetrigger should go through even when the bossmod isn't active yet.
	tinsert(yellTriggers, { yell, self })
end
function BigWigs:CHAT_MSG_MONSTER_YELL(msg)
	for i = 1, table.getn(yellTriggers) do
		local yell = yellTriggers[i][1]
		local mod = yellTriggers[i][2]
		if string.find(msg, yell) then
			-- enable and engage
			self:EnableModule(mod:ToString())
			--self:TriggerEvent("BigWigs_SendSync", "BossEngaged "..self:ToString())
			mod:DebugMessage(mod:ToString() .. " CHAT_MSG_MONSTER_YELL Engage")
			mod:SendEngageSync()
		end
	end
end
BigWigs:RegisterEvent("CHAT_MSG_MONSTER_YELL")

-- ClassicAPI fires UI_SCALE_CHANGED whenever UIParent gets a new scale: the first time at login,
-- and when the UI scale or window size changes. Anchor positions are saved in screen units, so each
-- plugin places its anchors again with the new scale and they stay where the player put them.
function BigWigs:UI_SCALE_CHANGED()
	for name, module in self:IterateModules() do
		if type(module.RestorePosition) == "function" and self:IsModuleActive(module) then
			module:RestorePosition()
		end
	end
end
BigWigs:RegisterEvent("UI_SCALE_CHANGED")

function BigWigs:CheckForEngage(module)
	if module and module:IsBossModule() and not module.engaged then
		local function IsBossInCombat()
			local trigger = module.enabletrigger
			local a = module.wipemobs
			if not trigger then
				return false
			end
			-- build a local list: adding the wipe mobs to module.enabletrigger itself grew it on every scan
			local t = {}
			if type(trigger) == "string" then
				table.insert(t, trigger)
			else
				for _, v in pairs(trigger) do
					table.insert(t, v)
				end
			end
			if a then
				if type(a) == "string" then
					a = { a }
				end
				for k, v in pairs(a) do
					table.insert(t, v)
				end
			end

			if UnitExists("target") and UnitAffectingCombat("target") then
				local target = UnitName("target")
				for _, mob in pairs(t) do
					if target == mob then
						return true
					end
				end
			end

			local num = GetNumRaidMembers()
			for i = 1, num do
				local raidUnit = string.format("raid%starget", i)
				if UnitExists(raidUnit) and UnitAffectingCombat(raidUnit) then
					local target = UnitName(raidUnit)
					for _, mob in pairs(t) do
						if target == mob then
							return true
						end
					end
				end
			end
			return false
		end

		local inCombat = IsBossInCombat()
		local running = module:IsEventScheduled(module:ToString() .. "_CheckStart")
		if inCombat then
			module:DebugMessage("Scan returned true, engaging [" .. module:ToString() .. "].")
			module:CancelScheduledEvent(module:ToString() .. "_CheckStart")
			module:Engage()
			module:SendEngageSync()
		elseif not running then
			module:ScheduleRepeatingEvent(module:ToString() .. "_CheckStart", module.CheckForEngage, .5, module)
		end
	end
end
function BigWigs.modulePrototype:CheckForEngage()
	BigWigs:CheckForEngage(self)
end

function BigWigs:CheckForWipe(module)
	if module and module:IsBossModule() then
		-- prevent reset from someone outside the instance
		local isInZone = false
		if type(module.zonename) == "string" and module.zonename == GetRealZoneText() then
			isInZone = true
		elseif type(module.zonename) == "table" then
			for _, v in pairs(module.zonename) do
				if v == GetRealZoneText() then
					isInZone = true
					break
				end
			end
		end
		if not isInZone then
			return
		end

		--module:DebugMessage("BigWigs." .. module:ToString() .. ":CheckForWipe()")

		-- start wipe check in regular intervals
		local running = module:IsEventScheduled(module:ToString() .. "_CheckWipe")
		if not running then
			module:DebugMessage("CheckForWipe not running")
			module:ScheduleRepeatingEvent(module:ToString() .. "_CheckWipe", module.CheckForWipe, 5, module)
			return
		end

		local function RaidMemberInCombat()
			if UnitAffectingCombat("player") then
				return true
			end

			for i = 1, GetNumRaidMembers() do
				local raidUnit = string.format("raid%s", i)
				if UnitExists(raidUnit) and UnitAffectingCombat(raidUnit) then
					return true
				end
			end

			return false
		end

		local function RaidMemberAlive()
			if not UnitIsDeadOrGhost("player") then
				return true
			end

			for i = 1, GetNumRaidMembers() do
				local raidUnit = string.format("raid%s", i)
				if UnitExists(raidUnit) and not UnitIsDeadOrGhost(raidUnit) then
					return true
				end
			end
			return false
		end

		if not RaidMemberAlive() or not RaidMemberInCombat() then
			module:DebugMessage("Wipe detected for module [" .. module:ToString() .. "].")
			module:CancelScheduledEvent(module:ToString() .. "_CheckWipe")
			self:TriggerEvent("BigWigs_RebootModule", module:ToString())
			--module:SendWipeSync()
		end
	end
end

function BigWigs.modulePrototype:CheckForWipe()
	BigWigs:CheckForWipe(self)
end

function BigWigs.modulePrototype:OnFriendlyDeath(msg)
end

-- don't override
function BigWigs.modulePrototype:CHAT_MSG_COMBAT_FRIENDLY_DEATH(msg)
	self:OnFriendlyDeath(msg)
	self:CheckForWipe()
end

function BigWigs:CheckForBossDeath(msg, module)
	if module and module:IsBossModule() then
		if msg == string.format(UNITDIESOTHER, module:ToString()) or msg == string.format(L["You have slain %s!"], module.translatedName) then
			module:SendBossDeathSync()
		end
	end
end

function BigWigs.modulePrototype:CheckForBossDeath(msg)
	BigWigs:CheckForBossDeath(msg, self)
end

function BigWigs.modulePrototype:OnEnemyDeath(msg)
end

-- don't override
function BigWigs.modulePrototype:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
	self:OnEnemyDeath(msg)
	self:CheckForBossDeath(msg)
end

-- override
function BigWigs.modulePrototype:BigWigs_RecvSync(sync, rest, nick)
end

-- test function
function BigWigs.modulePrototype:Test()
	BigWigs:Print("No tests defined for module " .. self:ToString())
end

------------------------------
--   Combat log dispatcher  --
------------------------------
-- One COMBAT_LOG_EVENT_UNFILTERED frame for every boss module, in place of matching English chat
-- lines. A module registers what it wants, usually in OnEnable:
--   self:RegisterCombatLog(subevents, spells, handler)
-- subevents: a subevent name, or a list of them ("SPELL_AURA_APPLIED", {"SWING_DAMAGE", "SWING_MISSED"}).
-- spells: nil for every event of those subevents, or a spell ID, an English spell name, or a list
--   of both. An event matches by ID first, then by name, so a missing or wrong ID still works on an
--   English client; other clients need the right ID. With debugging on, a match by name prints the
--   ID the server used, so IDs can be collected from a raid.
-- handler: a method name or a function, called as handler(self, ev) while the module is active.
--   A module has one handler per subevent and spell.
-- ev is one table, reused for every event: read it in the handler, don't keep it. Its fields are
-- named as in CombatLogGetCurrentEventInfo (sourceName, destGUID, spellId, amount, missType...).

local combatLogListeners = {} -- [subevent][spell ID, spell name or "*"] = { [module] = handler }
local combatLogCore = {}      -- [subevent] = function(), the core's own uses below
local ev = {}
local evFields = {
	"timestamp", "subevent", "hideCaster", "sourceGUID", "sourceName", "sourceFlags", "sourceRaidFlags",
	"destGUID", "destName", "destFlags", "destRaidFlags", "spellId", "spellName", "spellSchool",
	"environmentalType", "amount", "overkill", "school", "resisted", "blocked", "absorbed", "critical",
	"glancing", "crushing", "isOffHand", "missType", "amountMissed", "overhealing", "auraType",
	"extraSpellId", "extraSpellName", "extraSchool", "itemId", "itemName", "failedType", "powerType",
	"extraAmount",
}
local numEvFields = table.getn(evFields)

-- where each subevent's own values start, and what they are; worked out once per subevent
local layouts = {}
local function Layout(sub)
	local l = layouts[sub]
	if l then
		return l
	end
	local prefix = 0
	if string.find(sub, "^ENVIRONMENTAL_") then
		prefix = 1
	elseif string.find(sub, "^SPELL_") or string.find(sub, "^RANGE_") or string.find(sub, "^DAMAGE_SHIELD") or sub == "DAMAGE_SPLIT" then
		prefix = 3
	end
	local suffix
	if string.find(sub, "_DURABILITY_DAMAGE$") then
		suffix = "durability"
	elseif string.find(sub, "_DAMAGE$") or sub == "DAMAGE_SHIELD" or sub == "DAMAGE_SPLIT" then
		suffix = "damage"
	elseif string.find(sub, "_MISSED$") then
		suffix = "missed"
	elseif string.find(sub, "_HEAL$") then
		suffix = "heal"
	elseif string.find(sub, "_DOSE$") then
		suffix = "dose"
	elseif string.find(sub, "_AURA_APPLIED$") or string.find(sub, "_AURA_REMOVED$") or string.find(sub, "_AURA_REFRESH$") then
		suffix = "aura"
	elseif string.find(sub, "_INTERRUPT$") or string.find(sub, "_DISPEL_FAILED$") or string.find(sub, "_DISPEL$") then
		suffix = "extra"
	elseif string.find(sub, "_CAST_FAILED$") then
		suffix = "failed"
	elseif string.find(sub, "_ENERGIZE$") or string.find(sub, "_DRAIN$") or string.find(sub, "_LEECH$") or string.find(sub, "_EXTRA_ATTACKS$") then
		suffix = "power"
	end
	l = { prefix, suffix }
	layouts[sub] = l
	return l
end

local function SetSuffix(kind, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	if kind == "damage" then
		ev.amount, ev.overkill, ev.school, ev.resisted, ev.blocked = a1, a2, a3, a4, a5
		ev.absorbed, ev.critical, ev.glancing, ev.crushing, ev.isOffHand = a6, a7, a8, a9, a10
	elseif kind == "missed" then
		ev.missType, ev.isOffHand, ev.amountMissed = a1, a2, a3
	elseif kind == "heal" then
		ev.amount, ev.overhealing, ev.absorbed, ev.critical = a1, a2, a3, a4
	elseif kind == "aura" then
		ev.auraType = a1
	elseif kind == "dose" then
		ev.auraType, ev.amount = a1, a2
	elseif kind == "extra" then
		ev.extraSpellId, ev.extraSpellName, ev.extraSchool, ev.auraType = a1, a2, a3, a4
	elseif kind == "durability" then
		ev.itemId, ev.itemName = a1, a2
	elseif kind == "failed" then
		ev.failedType = a1
	elseif kind == "power" then
		ev.amount, ev.powerType, ev.extraAmount = a1, a2, a3
	end
end

local function Fill(timestamp, sub, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
		destGUID, destName, destFlags, destRaidFlags, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13)
	for i = 1, numEvFields do
		ev[evFields[i]] = nil
	end
	ev.timestamp, ev.subevent, ev.hideCaster = timestamp, sub, hideCaster
	ev.sourceGUID, ev.sourceName, ev.sourceFlags, ev.sourceRaidFlags = sourceGUID, sourceName, sourceFlags, sourceRaidFlags
	ev.destGUID, ev.destName, ev.destFlags, ev.destRaidFlags = destGUID, destName, destFlags, destRaidFlags
	local l = Layout(sub)
	if l[1] == 3 then
		ev.spellId, ev.spellName, ev.spellSchool = p1, p2, p3
		SetSuffix(l[2], p4, p5, p6, p7, p8, p9, p10, p11, p12, p13)
	elseif l[1] == 1 then
		ev.environmentalType = p1
		SetSuffix(l[2], p2, p3, p4, p5, p6, p7, p8, p9, p10, p11)
	else
		SetSuffix(l[2], p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	end
end

local function CallSafely(f, a, b)
	local ok, err = pcall(f, a, b)
	if not ok then
		geterrorhandler()(err)
	end
end

local function CallListeners(set, skipA, skipB, byName)
	for module, handler in pairs(set) do
		if (not skipA or skipA[module] ~= handler) and (not skipB or skipB[module] ~= handler)
				and BigWigs:IsModuleActive(module) then
			if byName then
				module:DebugMessage("combat log: " .. tostring(ev.spellName) .. " matched by name, spell ID " .. tostring(ev.spellId))
			end
			if type(handler) == "string" then
				CallSafely(module[handler], module, ev)
			else
				CallSafely(handler, module, ev)
			end
		end
	end
end

local function Dispatch(bySub)
	local byId = ev.spellId and bySub[ev.spellId]
	local byName = ev.spellName and bySub[ev.spellName]
	local all = bySub["*"]
	if byId then
		CallListeners(byId)
	end
	if byName then
		CallListeners(byName, byId, nil, true)
	end
	if all then
		CallListeners(all, byId, byName)
	end
end

do
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function()
		local sub = arg2
		local bySub = combatLogListeners[sub]
		local core = combatLogCore[sub]
		if not bySub and not core then
			return
		end
		Fill(CombatLogGetCurrentEventInfo())
		if core then
			CallSafely(core)
		end
		if bySub then
			Dispatch(bySub)
		end
	end)
end

-- For module Test() functions written as English chat lines: turns one line into the combat log event
-- it stands for and runs it through the dispatcher, so old test scripts drive converted modules.
-- Returns nil for a line it doesn't recognise (yells, emotes). "You"/"you" is the player.
local testLinePatterns = {
	{ "^(.-) is afflicted by (.-) %((%d+)%)%.?$", "SPELL_AURA_APPLIED_DOSE", "dest", "spell", "amount" },
	{ "^(.-) are afflicted by (.-) %((%d+)%)%.?$", "SPELL_AURA_APPLIED_DOSE", "dest", "spell", "amount" },
	{ "^(.-) is afflicted by (.-)%.?$", "SPELL_AURA_APPLIED", "dest", "spell" },
	{ "^(.-) are afflicted by (.-)%.?$", "SPELL_AURA_APPLIED", "dest", "spell" },
	{ "^(.-) fades from (.-)%.?$", "SPELL_AURA_REMOVED", "spell", "dest" },
	{ "^(.-) gains? (.-) %((%d+)%)%.?$", "SPELL_AURA_APPLIED_DOSE", "self", "spell", "amount" },
	{ "^(.-) gains? (.-)%.?$", "SPELL_AURA_APPLIED", "self", "spell" },
	{ "^(.-) begins to cast (.-)%.?$", "SPELL_CAST_START", "source", "spell" },
	{ "^(.-) begins to perform (.-)%.?$", "SPELL_CAST_START", "source", "spell" },
	{ "^(.-) performs? (.-) on (.-)%.?$", "SPELL_CAST_SUCCESS", "source", "spell", "dest" },
	{ "^(.-) performs? (.-)%.?$", "SPELL_CAST_SUCCESS", "source", "spell" },
	{ "^(.-) casts? (.-) on (.-)%.?$", "SPELL_CAST_SUCCESS", "source", "spell", "dest" },
	{ "^(.-) casts? (.-)%.?$", "SPELL_CAST_SUCCESS", "source", "spell" },
	{ "^(.-)'s (.-) [hc]r?i?t?s (.-) for (%d+)", "SPELL_DAMAGE", "source", "spell", "dest", "amount" },
	{ "^(.-) suffers? (%d+) %a+ damage from (.-)'s (.-)%.", "SPELL_PERIODIC_DAMAGE", "dest", "amount", "source", "spell" },
	{ "^(.-)'s (.-) was resisted by (.-)%.?$", "SPELL_MISSED", "source", "spell", "dest", "RESIST" },
	{ "^(.-)'s (.-) was (%a+)ed by (.-)%.?$", "SPELL_MISSED", "source", "spell", "miss", "dest" },
	{ "^(.-)'s (.-) fails%.", "SPELL_MISSED", "source", "spell", "IMMUNE" },
	{ "^(.-)'s (.-) was resisted", "SPELL_MISSED", "source", "spell", "RESIST" },
	{ "^You attack%. (.-) (%a+)%.?$", "SWING_MISSED", "dest", "miss" },
	{ "^(.-) dies%.?$", "UNIT_DIED", "dest" },
	{ "^You die%.?$", "UNIT_DIED", "me" },
}
function BigWigs:TestCombatLogText(line)
	local me = UnitName("player")
	local function Who(name)
		if name == "You" or name == "you" or name == "Your" then
			return me
		end
		return name
	end
	for _, p in ipairs(testLinePatterns) do
		local c = { string.find(line, p[1]) }
		if c[1] then
			local v = { }
			local miss
			for i = 3, table.getn(p) do
				local field, value = p[i], c[i]
				if field == "RESIST" or field == "IMMUNE" then
					miss = field
				elseif field == "miss" then
					miss = string.upper(value)
					if miss == "PARRIE" or miss == "PARRIES" then miss = "PARRY" end
					if miss == "DODG" or miss == "DODGES" then miss = "DODGE" end
					if miss == "BLOCK" or miss == "BLOCKS" then miss = "BLOCK" end
				elseif field == "me" then
					v.dest = me
				else
					v[field] = value
				end
			end
			local sub = p[2]
			local source, dest = Who(v.source), Who(v.dest)
			if v.self then
				source, dest = Who(v.self), Who(v.self)
			end
			local amount = v.amount and tonumber(v.amount)
			if sub == "UNIT_DIED" then
				self:TestCombatLog(sub, nil, dest)
			elseif sub == "SWING_MISSED" then
				self:TestCombatLog(sub, me, dest, nil, nil, miss)
			elseif sub == "SPELL_MISSED" then
				self:TestCombatLog(sub, source, dest, nil, v.spell, miss)
			elseif sub == "SPELL_DAMAGE" or sub == "SPELL_PERIODIC_DAMAGE" then
				self:TestCombatLog(sub, source, dest, nil, v.spell, amount, 0, 1)
			elseif sub == "SPELL_AURA_APPLIED_DOSE" then
				self:TestCombatLog(sub, source, dest, nil, v.spell, "DEBUFF", amount)
			elseif sub == "SPELL_AURA_APPLIED" or sub == "SPELL_AURA_REMOVED" then
				self:TestCombatLog(sub, source, dest, nil, v.spell, "DEBUFF")
			else
				self:TestCombatLog(sub, source, dest, nil, v.spell)
			end
			return true
		end
	end
end

local function AsList(v)
	if type(v) == "table" then
		return v
	end
	return { v }
end

-- For module Test() functions: run a made-up combat log event through the same dispatcher, e.g.
--   BigWigs:TestCombatLog("SPELL_AURA_APPLIED", "Nefarian", UnitName("player"), 22687, "Veil of Shadow", "DEBUFF")
-- The values after spellName are the suffix (auraType; amount ...; missType ...). A unit named like a
-- module's boss, or the source unit, is flagged as a hostile NPC; anyone else as a raid member, with
-- your own GUID when it is you. Pass spellId/spellName nil for SWING_ and UNIT_ events.
local testFlagsNPC = 0x0A48 -- outsider, hostile, NPC control, NPC type
local testFlagsRaid = 0x0514 -- raid, friendly, player control, player type
function BigWigs:TestCombatLog(subevent, sourceName, destName, spellId, spellName, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	local me = UnitName("player")
	local function Unit(name, hostile)
		if not name then
			return nil, nil, 0
		end
		if name == me then
			return UnitGUID("player"), name, testFlagsRaid
		end
		return "0xTEST" .. name, name, hostile and testFlagsNPC or testFlagsRaid
	end
	local sg, sn, sf = Unit(sourceName, sourceName and sourceName ~= me)
	local dg, dn, df = Unit(destName, destName and destName == sourceName)
	if spellId or spellName then
		Fill(GetTime(), subevent, false, sg, sn, sf, 0, dg, dn, df, 0, spellId, spellName, 1, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	else
		Fill(GetTime(), subevent, false, sg, sn, sf, 0, dg, dn, df, 0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	end
	if combatLogCore[subevent] then
		CallSafely(combatLogCore[subevent])
	end
	if combatLogListeners[subevent] then
		Dispatch(combatLogListeners[subevent])
	end
end

function BigWigs.modulePrototype:RegisterCombatLog(subevents, spells, handler)
	local keys = spells and AsList(spells) or { "*" }
	for _, sub in ipairs(AsList(subevents)) do
		local bySub = combatLogListeners[sub]
		if not bySub then
			bySub = {}
			combatLogListeners[sub] = bySub
		end
		for _, key in ipairs(keys) do
			if not bySub[key] then
				bySub[key] = {}
			end
			bySub[key][self] = handler
		end
	end
end

-- The player's English class token ("WARRIOR", "MAGE"...), the same on every client language.
-- Class checks compare against this, never UnitClass's first (localised) return.
function BigWigs:PlayerClass()
	local _, class = UnitClass("player")
	return class
end

-- The raid mark (1 star ... 8 skull) from a sourceRaidFlags or destRaidFlags value, or nil.
function BigWigs:RaidFlagsToMark(flags)
	if not flags or flags == 0 then
		return nil
	end
	local bit = 1
	for i = 1, 8 do
		if math.mod(math.floor(flags / bit), 2) == 1 then
			return i
		end
		bit = bit * 2
	end
	return nil
end

-- True when the flags are a player, pet or guardian in your group (you included).
local groupMemberMask = COMBATLOG_OBJECT_AFFILIATION_MINE + COMBATLOG_OBJECT_AFFILIATION_PARTY + COMBATLOG_OBJECT_AFFILIATION_RAID
	+ COMBATLOG_OBJECT_REACTION_FRIENDLY + COMBATLOG_OBJECT_REACTION_NEUTRAL + COMBATLOG_OBJECT_REACTION_HOSTILE
	+ COMBATLOG_OBJECT_CONTROL_PLAYER + COMBATLOG_OBJECT_CONTROL_NPC
	+ COMBATLOG_OBJECT_TYPE_PLAYER + COMBATLOG_OBJECT_TYPE_PET + COMBATLOG_OBJECT_TYPE_GUARDIAN
function BigWigs:IsGroupMember(flags)
	return flags and CombatLog_Object_IsA(flags, groupMemberMask) and true or false
end

-- Boss death from UNIT_DIED (O2), in any client language and for units that share a name. Modules
-- converted to the combat log (module.combatLog) get it in place of the chat death line; other modules
-- get it as well as the chat line, unless they handle CHAT_MSG_COMBAT_HOSTILE_DEATH or
-- CheckForBossDeath themselves (e.g. a fight that ends only when several units have died, or trash that
-- ends when none of that name is still fighting). A trash module (module.trashMod) on the combat log
-- ends only when no other unit of its name is still in combat. A module can override BossUnitDied.
function BigWigs.modulePrototype:BossUnitDied(ev)
	local proto = BigWigs.modulePrototype
	if not self.combatLog and (self.CHAT_MSG_COMBAT_HOSTILE_DEATH ~= proto.CHAT_MSG_COMBAT_HOSTILE_DEATH or self.CheckForBossDeath ~= proto.CheckForBossDeath) then
		return
	end
	if self.trashMod and self:IsEnableTriggerInCombat() then
		return
	end
	self:SendBossDeathSync()
end

-- True when a unit named in enabletrigger is alive and in combat on your target, a raid member's
-- target or a nameplate (the check trash modules used before declaring their pack dead).
function BigWigs.modulePrototype:IsEnableTriggerInCombat()
	local t = self.enabletrigger
	if not t then
		return false
	end
	if type(t) == "string" then
		t = { t }
	end
	local function Fighting(unit)
		if UnitExists(unit) and UnitAffectingCombat(unit) and not UnitIsDead(unit) then
			local name = UnitName(unit)
			for _, mob in pairs(t) do
				if name == mob then
					return true
				end
			end
		end
	end
	if Fighting("target") then
		return true
	end
	for i = 1, GetNumRaidMembers() do
		if Fighting("raid" .. i .. "target") then
			return true
		end
	end
	for i = 1, 40 do
		if Fighting("nameplate" .. i) then
			return true
		end
	end
	return false
end

combatLogCore["UNIT_DIED"] = function()
	local name = ev.destName
	if not name then
		return
	end
	for _, module in BigWigs:IterateModules() do
		if module.translatedName == name and module:IsBossModule() and BigWigs:IsModuleActive(module) then
			module:BossUnitDied(ev)
		end
	end
end

-- Engage on the first hit between your group and a boss (O3): no polling, and it works when nobody
-- has the boss targeted. The target scan in CheckForEngage stays as a fallback. The list of names to
-- watch is rebuilt at most once a second. A module can opt out with module.combatLogEngage = false.
do
	local watch = {} -- [unit name] = { module, ... }
	local builtAt = 0
	local function AddWatch(name, module)
		if type(name) ~= "string" then
			return
		end
		if not watch[name] then
			watch[name] = {}
		end
		table.insert(watch[name], module)
	end
	local function Watch()
		local now = GetTime()
		if now - builtAt < 1 then
			return watch
		end
		builtAt = now
		for k in pairs(watch) do
			watch[k] = nil
		end
		for _, module in BigWigs:IterateModules() do
			if module:IsBossModule() and not module.engaged and module.combatLogEngage ~= false and BigWigs:IsModuleActive(module) then
				for _, list in ipairs({ module.enabletrigger, module.wipemobs }) do
					if type(list) == "table" then
						for _, name in pairs(list) do
							AddWatch(name, module)
						end
					else
						AddWatch(list, module)
					end
				end
			end
		end
		return watch
	end

	local function Engage()
		local w = Watch()
		local modules
		if ev.sourceName and w[ev.sourceName] and BigWigs:IsGroupMember(ev.destFlags) then
			modules = w[ev.sourceName]
		elseif ev.destName and w[ev.destName] and BigWigs:IsGroupMember(ev.sourceFlags) then
			modules = w[ev.destName]
		end
		if not modules then
			return
		end
		for _, module in ipairs(modules) do
			if not module.engaged and BigWigs:IsModuleActive(module) then
				module:DebugMessage("Combat log engage [" .. module:ToString() .. "].")
				module:CancelScheduledEvent(module:ToString() .. "_CheckStart")
				module:Engage()
				module:SendEngageSync()
			end
		end
		builtAt = 0
	end
	for _, sub in ipairs({ "SWING_DAMAGE", "SWING_MISSED", "RANGE_DAMAGE", "RANGE_MISSED", "SPELL_DAMAGE",
			"SPELL_MISSED", "SPELL_PERIODIC_DAMAGE", "SPELL_PERIODIC_MISSED" }) do
		combatLogCore[sub] = Engage
	end
end

-- Cast events by unit name (O4), on every client, in place of SuperWoW's UNIT_CASTEVENT. Callbacks
-- keep SuperWoW's arguments: (casterGuid, targetGuid, eventType, spellId, castTime), with eventType
-- "START", "CAST", "CHANNEL" or "FAIL" and castTime in milliseconds. Differences from SuperWoW:
-- START has no target (the combat log doesn't give one); CHANNEL needs the caster on a unit token
-- (target, nameplate, a raid member's target...), otherwise a channel arrives as CAST; FAIL comes
-- only from an interrupt.
do
	local castModules = {} -- [module] = true

	local function Token(guid)
		return guid and UnitTokenFromGUID and UnitTokenFromGUID(guid)
	end

	local function CastEvent()
		local sub = ev.subevent
		local casterGUID, casterName, targetGUID, eventType, spellId, castTime
		if sub == "SPELL_INTERRUPT" then
			casterGUID, casterName, spellId, eventType, castTime = ev.destGUID, ev.destName, ev.extraSpellId, "FAIL", 0
		else
			casterGUID, casterName, spellId = ev.sourceGUID, ev.sourceName, ev.spellId
		end
		if not casterName then
			return
		end
		local any
		for module in pairs(castModules) do
			if module.castEventUnits and module.castEventUnits[casterName] and BigWigs:IsModuleActive(module) then
				any = true
				break
			end
		end
		if not any then
			return
		end

		if sub == "SPELL_CAST_START" then
			eventType = "START"
			local token = Token(casterGUID)
			local startMs, endMs
			if token then
				local _, _, _, s, e = C_Spell.UnitCastingInfo(token)
				startMs, endMs = s, e
			end
			if startMs and endMs then
				castTime = endMs - startMs
			else
				local _, _, _, _, _, _, ms = GetSpellInfo(spellId)
				castTime = ms or 0
			end
		elseif sub == "SPELL_CAST_SUCCESS" then
			eventType, castTime, targetGUID = "CAST", 0, ev.destGUID
			local token = Token(casterGUID)
			if token then
				local _, _, _, startMs, endMs, _, _, channelId = C_Spell.UnitChannelInfo(token)
				if channelId == spellId then
					eventType = "CHANNEL"
					castTime = (startMs and endMs) and (endMs - startMs) or 0
				end
			end
		end

		for module in pairs(castModules) do
			local callback = module.castEventUnits and module.castEventUnits[casterName]
			if callback and BigWigs:IsModuleActive(module) then
				local f = callback
				if type(f) == "string" then
					f = module[f]
				end
				if type(f) == "function" then
					local ok, err = pcall(f, module, casterGUID, targetGUID, eventType, spellId, castTime)
					if not ok then
						geterrorhandler()(err)
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage("Invalid callback for unit " .. casterName)
					module.castEventUnits[casterName] = nil
				end
			end
		end
	end
	combatLogCore["SPELL_CAST_START"] = CastEvent
	combatLogCore["SPELL_CAST_SUCCESS"] = CastEvent
	combatLogCore["SPELL_INTERRUPT"] = CastEvent

	function BigWigs.modulePrototype:RegisterCastEventsForUnitName(unitName, callback)
		castModules[self] = true
		if not self.castEventUnits then
			self.castEventUnits = {}
		end
		if not self.castEventUnits[unitName] then
			self.castEventUnits[unitName] = callback
		end
	end
end

------------------------------
--      Provided API      --
------------------------------

local delayPrefix = "ScheduledEventPrefix"

function BigWigs.modulePrototype:Sync(sync)
	self:TriggerEvent("BigWigs_SendSync", sync)
end
function BigWigs.modulePrototype:DelayedSync(delay, sync)
	self:ScheduleEvent(delayPrefix .. "Sync" .. self:ToString() .. sync, "BigWigs_SendSync", delay, sync)
end
function BigWigs.modulePrototype:CancelDelayedSync(sync)
	self:CancelScheduledEvent(delayPrefix .. "Sync" .. self:ToString() .. sync)
end
function BigWigs.modulePrototype:ThrottleSync(throttle, sync)
	self:TriggerEvent("BigWigs_ThrottleSync", sync, throttle)
end

function BigWigs.modulePrototype:Message(text, priority, noRaidSay, sound, broadcastOnly)
	self:TriggerEvent("BigWigs_Message", text, priority, noRaidSay, sound, broadcastOnly)
end
function BigWigs.modulePrototype:DelayedMessage(delay, text, priority, noRaidSay, sound, broadcastOnly)
	return self:ScheduleEvent(delayPrefix .. "Message" .. self:ToString() .. text, "BigWigs_Message", delay, text, priority, noRaidSay, sound, broadcastOnly)
end
function BigWigs.modulePrototype:CancelDelayedMessage(text)
	self:CancelScheduledEvent(delayPrefix .. "Message" .. self:ToString() .. text)
end

function BigWigs.modulePrototype:Bar(text, time, icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
	self:TriggerEvent("BigWigs_StartBar", self, text, time, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
end
function BigWigs.modulePrototype:RemoveBar(text)
	self:TriggerEvent("BigWigs_StopBar", self, text)
end

function BigWigs.modulePrototype:IntervalBar(text, intervalMin, intervalMax, icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	self:TriggerEvent("BigWigs_StartIntervalBar", self, text, intervalMin, intervalMax, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
end
function BigWigs.modulePrototype:DelayedIntervalBar(delay, text, intervalMin, intervalMax, icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	return self:ScheduleEvent(delayPrefix .. "Bar" .. self:ToString() .. text, "BigWigs_StartIntervalBar", delay, self, text, intervalMin, intervalMax, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
end

function BigWigs.modulePrototype:DelayedBar(delay, text, time, icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
	return self:ScheduleEvent(delayPrefix .. "Bar" .. self:ToString() .. text, "BigWigs_StartBar", delay, self, text, time, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
end
function BigWigs.modulePrototype:CancelDelayedBar(text)
	self:CancelScheduledEvent(delayPrefix .. "Bar" .. self:ToString() .. text)
end

function BigWigs.modulePrototype:ClickBar(text, time, icon, target, spell, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize)
	if not otherColor then otherColor = "ClickToTarget" end
	if emphasize == nil then emphasize = false end
	self:TriggerEvent("BigWigs_StartBar", self, text, time, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
end
function BigWigs.modulePrototype:DelayedClickBar(delay, text, time, icon, target, spell, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize)
	if not otherColor then otherColor = "ClickToTarget" end
	if emphasize == nil then emphasize = false end
	return self:ScheduleEvent(delayPrefix .. "Bar" .. self:ToString() .. text, "BigWigs_StartBar", delay, self, text, time, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell)
end

function BigWigs.modulePrototype:MonitorBar(barName, icon, guid, type, displayText, insertMark, emphazise, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	self:TriggerEvent("BigWigs_StartMonitorBar", self, barName, "Interface\\Icons\\" .. icon, guid, type, displayText, insertMark, emphazise, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
end
function BigWigs.modulePrototype:DelayedMonitorBar(delay, barName, icon, guid, type, displayText, insertMark, emphazise, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	return self:ScheduleEvent(delayPrefix .. "Bar" .. self:ToString() .. barName, "BigWigs_StartMonitorBar", delay, self, barName, "Interface\\Icons\\" .. icon, guid, type, displayText, insertMark, emphazise, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
end

function BigWigs.modulePrototype:CounterBar(barName, max, icon, target, spell, emphasize, timeFormat, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	if emphasize == nil then emphasize = false end
	self:TriggerEvent("BigWigs_StartCounterBar", self, barName, max, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell, timeFormat)
end
function BigWigs.modulePrototype:DelayedCounterBar(delay, barName, max, icon, target, spell, emphasize, timeFormat, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	return self:ScheduleEvent(delayPrefix .. "Bar" .. self:ToString() .. barName, "BigWigs_StartCounterBar", delay, self, barName, max, "Interface\\Icons\\" .. icon, otherColor, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, emphasize, target, spell, timeFormat)
end

function BigWigs.modulePrototype:UpdateBar(barName, value, displayText, paused)
	self:TriggerEvent("BigWigs_UpdateBar", self, barName, value, displayText, paused)
end
function BigWigs.modulePrototype:SetBar(barName, timeLeft, timeTotal, timeFormat)
	self:TriggerEvent("BigWigs_SetBar", self, barName, timeLeft, timeTotal, timeFormat)
end
function BigWigs.modulePrototype:ColorBar(barName, color, bgcolor)
	self:TriggerEvent("BigWigs_ColorBar", self, barName, color, bgcolor)
end
function BigWigs.modulePrototype:BarStatus(text)
	local registered, time, elapsed, running = BigWigsBars:GetBarStatus(self, text)
	return registered, time, elapsed, running
end

function BigWigs.modulePrototype:Sound(sound)
	self:TriggerEvent("BigWigs_Sound", sound)
end

function BigWigs.modulePrototype:DelayedSound(delay, sound, id)
	if not id then
		id = "_"
	end
	return self:ScheduleEvent(delayPrefix .. "Sound" .. self:ToString() .. sound .. id, "BigWigs_Sound", delay, sound)
end

function BigWigs.modulePrototype:CancelDelayedSound(sound, id)
	if not id then
		id = "_"
	end
	self:CancelScheduledEvent(delayPrefix .. "Sound" .. self:ToString() .. sound .. id)
end

function BigWigs.modulePrototype:Icon(name, iconnumber)
	self:TriggerEvent("BigWigs_SetRaidIcon", name, iconnumber)
end
function BigWigs.modulePrototype:RemoveIcon()
	self:TriggerEvent("BigWigs_RemoveRaidIcon")
end

function BigWigs.modulePrototype:WarningSign(icon, duration, force, text)
	self:TriggerEvent("BigWigs_ShowWarningSign", "Interface\\Icons\\" .. icon, duration, force, text)
end
function BigWigs.modulePrototype:RemoveWarningSign(icon, forceHide)
	self:TriggerEvent("BigWigs_HideWarningSign", "Interface\\Icons\\" .. icon, forceHide)
end
function BigWigs.modulePrototype:DelayedWarningSign(delay, icon, duration, id)
	if not id then
		id = "_"
	end
	self:ScheduleEvent(delayPrefix .. "WarningSign" .. self:ToString() .. icon .. id, "BigWigs_ShowWarningSign", delay, "Interface\\Icons\\" .. icon, duration)
end
function BigWigs.modulePrototype:CancelDelayedWarningSign(icon, id)
	if not id then
		id = "_"
	end
	self:CancelScheduledEvent(delayPrefix .. "WarningSign" .. self:ToString() .. icon .. id)
end

function BigWigs.modulePrototype:Say(msg)
	SendChatMessage(msg, "SAY")
end

-- proximity
function BigWigs:Proximity(moduleName)
	self:TriggerEvent("BigWigs_ShowProximity", moduleName)
end
function BigWigs.modulePrototype:Proximity()
	BigWigs:Proximity(self:ToString())
end

function BigWigs:RemoveProximity()
	self:TriggerEvent("BigWigs_HideProximity")
end
function BigWigs.modulePrototype:RemoveProximity()
	BigWigs:RemoveProximity()
end


------------------------------
--      Initialization      --
------------------------------

function BigWigs:OnInitialize()
	if not self.version then
		self.version = GetAddOnMetadata("BigWigs", "Version")
	end
	local rev = self.revision
	for name, module in self:IterateModules() do
		--self:RegisterModule(name,module)
		rev = math.max(rev, module.revision)
	end
	self.version = (self.version or "2.0") .. " |cffff8888r" .. rev .. "|r"
	--self:RegisterEvent("ADDON_LOADED")

	-- classicapi_check.lua found ClassicAPI missing or too old: stay in standby
	if BIGWIGS_CLASSICAPI_MISSING then
		return
	end

	self.loading = true
	-- Activate ourselves, or at least try to. If we were disabled during a reloadUI, OnEnable isn't called,
	-- and self.loading will never be set to something else, resulting in a BigWigs that doesn't enable.
	self:ToggleActive(true)
end

function BigWigs:OnEnable()
	if BIGWIGS_CLASSICAPI_MISSING then
		self:ToggleActive(false)
		return
	end
	-- Standby unregisters every core event, including the two registered at file load, so
	-- register them again each time BigWigs comes out of standby.
	if not self:IsEventRegistered("CHAT_MSG_MONSTER_YELL") then
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	end
	if not self:IsEventRegistered("UI_SCALE_CHANGED") then
		self:RegisterEvent("UI_SCALE_CHANGED")
	end
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:AceEvent_FullyInitialized()
	else
		self:RegisterEvent("AceEvent_FullyInitialized")
	end
end

function BigWigs:AceEvent_FullyInitialized()
	if (GetNumRaidMembers() > 0) or ((GetZoneText() == "The Black Morass") or (GetZoneText() == "Dire Maul") or (GetZoneText() == "Stratholme")) or not self.loading then
		-- Enable all disabled modules that are not boss modules.
		for name, module in self:IterateModules() do
			if type(module.IsBossModule) ~= "function" or not module:IsBossModule() then
				self:ToggleModuleActive(module, true)
			end
		end

		if BigWigsLoD then
			self:CreateLoDMenu()
		end

		self:TriggerEvent("BigWigs_CoreEnabled")

		self:RegisterEvent("BigWigs_TargetSeen")
		self:RegisterEvent("BigWigs_RebootModule")

		self:RegisterEvent("BigWigs_RecvSync")
	else
		self:ToggleActive(false)
	end
	self.loading = nil

	if self.db.profile.showfirsttimepopup == nil then
		self.db.profile.showfirsttimepopup = false
		self:ToggleActive(true)
		BigWigs:ShowFirstTimePopup()
	end
end

function BigWigs:ShowFirstTimePopup()
	StaticPopupDialogs["BigWigsFirstTimeDialog"] = {
		text = "Pepo's Bigwigs is now enabled!  \n\n I recommend editing your alert positions and sizes to your liking by clicking 'Edit Layout'. If you don't want to do it now, you can always do it later right clicking the BigWigs minimap icon and choosing 'Edit Layout'.",
		button1 = "Edit Layout",
		button2 = "Close",
		OnAccept = function()
			StaticPopup_Hide("BigWigsFirstTimeDialog")
			BigWigs:EditLayout()
		end,
		OnCancel = function()
			StaticPopup_Hide("BigWigsFirstTimeDialog")
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3, -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("BigWigsFirstTimeDialog")
end

function BigWigs:OnDisable()
	-- Disable all modules
	for name, module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
	end

	self:TriggerEvent("BigWigs_CoreDisabled")
end


-------------------------------
--      Module Handling      --
-------------------------------

function BigWigs:ADDON_LOADED(addon)
	local gname = GetAddOnMetadata(addon, "X-BigWigsModule")
	if not gname then
		return
	end

	local g = getglobal(gname)
	if not g or not g.name then
		return
	end

	g.external = true

	self:RegisterModule(g.name, g)
end

function BigWigs:ModuleDeclaration(bossName, zoneName)
	local translatedName = BB:HasTranslation(bossName) and BB[bossName] or bossName
	local module = BigWigs:NewModule(translatedName)
	local L = AceLibrary("AceLocale-2.2"):new("BigWigs" .. translatedName)
	module.translatedName = translatedName

	local name = string.gsub(bossName, "%s", "") -- untranslated, unique string
	module.bossSync = bossName


	-- zone
	local raidZones = { "Blackwing Lair", "Ruins of Ahn'Qiraj", "Ahn'Qiraj", "Molten Core", "Naxxramas", "Emerald Sanctum", "Zul'Gurub", "Timbermaw Hold" }
	local isOutdoorraid = true
	for i, value in ipairs(raidZones) do
		if value == zoneName then
			module.zonename = BZ:HasTranslation(zoneName) and BZ[zoneName] or zoneName
			isOutdoorraid = false
			break
		end
	end
	if isOutdoorraid then
		module.zonename = {
			AceLibrary("AceLocale-2.2"):new("BigWigs")["Outdoor Raid Bosses Zone"],
			BZ:HasTranslation(zoneName) and BZ[zoneName] or zoneName
		}
	end

	return module, L
end

function BigWigs:RegisterModule(name, module)
	if module:IsBossModule() then
		self:ToggleModuleActive(module, false)
	end

	-- Set up DB
	local opts
	if module:IsBossModule() and module.toggleoptions then
		opts = {}
		for _, v in pairs(module.toggleoptions) do
			if module.defaultDB and module.defaultDB[v] ~= nil then
				opts[v] = module.defaultDB[v]
			elseif v ~= -1 then
				opts[v] = true
			end
		end
	end

	if module.db and module.RegisterDefaults and type(module.RegisterDefaults) == "function" then
		module:RegisterDefaults("profile", opts or module.defaultDB or {})
	else
		self:RegisterDefaults(name, "profile", opts or module.defaultDB or {})
	end

	if not module.db then
		module.db = self:AcquireDBNamespace(name)
	end

	-- Set up AceConsole
	local cons
	if module:IsBossModule() then
		local revision = type(module.revision) == "number" and module.revision or -1
		local L2 = AceLibrary("AceLocale-2.2"):new("BigWigs" .. name)
		if module.toggleoptions then
			local m = module
			cons = {
				type = "group",
				name = name,
				desc = string.format(L["Options for %s (r%s)."], name, revision),
				args = {
					[L["toggle"]] = {
						type = "toggle",
						name = L["Active"],
						order = 1,
						desc = L["Activate or deactivate this module."],
						get = function()
							return m.core:IsModuleActive(m)
						end,
						set = function()
							m.core:ToggleModuleActive(m)
						end,
					},
					[L["reboot"]] = {
						type = "execute",
						name = L["Reboot"],
						order = 2,
						desc = L["Reboot this module."],
						func = function()
							m.core:TriggerEvent("BigWigs_RebootModule", m:ToString())
						end,
						hidden = function()
							return not m.core:IsModuleActive(m)
						end,
					},
					[L["rebootall"]] = {
						type = "execute",
						name = L["Reboot All"],
						desc = L["Forces the module to reset for everyone in the raid.\n\n(Requires assistant or higher)"],
						order = 3,
						func = function()
							if (IsRaidLeader() or IsRaidOfficer()) then
								m.core:TriggerEvent("BigWigs_SendSync", "RebootModule " .. tostring(module))
							end
						end,
						hidden = function()
							return not m.core:IsModuleActive(m)
						end,
					},
					[L["debug"]] = {
						type = "toggle",
						name = L["Debugging"],
						desc = L["Show debug messages."],
						order = 4,
						get = function()
							return m:IsDebugging()
						end,
						set = function(v)
							m:SetDebugging(v)
						end,
						hidden = function()
							return not m:IsDebugging() and not BigWigs:IsDebugging()
						end,
					},
				},
			}
			local x = 10
			for _, v in pairs(module.toggleoptions) do
				local val = v
				x = x + 1
				if x == 11 and v ~= "bosskill" then
					cons.args["headerblankspotthingy"] = {
						type = "header",
						order = 4,
					}
				end
				if v == -1 then
					cons.args["blankspacer" .. x] = {
						type = "header",
						order = x,
					}
				else
					local l = v == "bosskill" and L or L2
					if l:HasTranslation(v .. "_validate") then
						cons.args[l[v .. "_cmd"]] = {
							type = "text",
							order = v == "bosskill" and -1 or x,
							name = l[v .. "_name"],
							desc = l[v .. "_desc"],
							get = function()
								return m.db.profile[val]
							end,
							set = function(v)
								m.db.profile[val] = v
							end,
							validate = l[v .. "_validate"],
						}
					else
						cons.args[l[v .. "_cmd"]] = {
							type = "toggle",
							order = v == "bosskill" and -1 or x,
							name = l[v .. "_name"],
							desc = l[v .. "_desc"],
							get = function()
								return m.db.profile[val]
							end,
							set = function(v)
								m.db.profile[val] = v
							end,
						}
					end
				end
			end
		end

		if cons or module.consoleOptions then
			local zonename = type(module.zonename) == "table" and module.zonename[1] or module.zonename
			local zone = zonename
			if BZ:HasReverseTranslation(zonename) and L:HasTranslation(BZ:GetReverseTranslation(zonename)) then
				zone = L[BZ:GetReverseTranslation(zonename)]
			elseif L:HasTranslation(zonename) then
				zone = L[zonename]
			end
			if not self.cmdtable.args[L["boss"]].args[zone] then
				self.cmdtable.args[L["boss"]].args[zone] = {
					type = "group",
					name = zonename,
					desc = string.format(L["Options for bosses in %s."], zonename),
					args = {},
				}
			end
			if module.external then
				self.cmdtable.args[L["extra"]].args[L2["cmd"]] = cons or module.consoleOptions
			else
				self.cmdtable.args[L["boss"]].args[zone].args[L2["cmd"]] = cons or module.consoleOptions
			end
		end
	elseif module.consoleOptions then
		if module.external then
			self.cmdtable.args[L["extra"]].args[module.consoleCmd or name] = cons or module.consoleOptions
		else
			self.cmdtable.args[L["plugin"]].args[module.consoleCmd or name] = cons or module.consoleOptions
		end
	end

	module.registered = true
	if module.OnRegister and type(module.OnRegister) == "function" then
		module:OnRegister()
	end

	-- Set up target monitoring, in case the monitor module has already initialized
	--if module.zonename and module.enabletrigger then
	self:TriggerEvent("BigWigs_RegisterForTargetting", module.zonename, module.enabletrigger)
	--end
end

function BigWigs:EnableModule(moduleName, nosync)
	local m = self:GetModule(moduleName)
	if m and not self:IsModuleActive(moduleName) then
		self:ToggleModuleActive(moduleName, true)
		if m:IsBossModule() then
			if not m.translatedName then
				m.translatedName = m:ToString()
				self:DebugMessage("translatedName for module " .. m:ToString() .. " missing")
			end
			self:TriggerEvent("BigWigs_Message", string.format(L["%s mod enabled"], m.translatedName or "??"), "Core", true)
		end

		-- balakethelock -
		--if not nosync then self:TriggerEvent("BigWigs_SendSync", (m.external and "EnableExternal " or "EnableModule ") .. (m.synctoken or BB:GetReverseTranslation(moduleName))) end

		-- balakethelock +
		if not nosync then
			local syncToken = m.synctoken or BB:HasReverseTranslation(moduleName) and BB:GetReverseTranslation(moduleName) or moduleName
			self:TriggerEvent("BigWigs_SendSync", (m.external and "EnableExternal " or "EnableModule ") .. syncToken)
		end
		self:SetupModule(moduleName)
	end
end

-- registers generic events
function BigWigs:SetupModule(moduleName)
	local m = self:GetModule(moduleName)
	if m and m:IsBossModule() then
		m:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage") -- addition
		m:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")
		m:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")
		if not m.combatLog then
			m:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH") -- addition; combat-log modules get UNIT_DIED
		end

		m:RegisterEvent("BigWigs_RecvSync")

		m.engaged = false

		m:OnSetup()
	end
end

function BigWigs:DisableModule(moduleName)
	local m = self:GetModule(moduleName)
	if m then
		if m:IsBossModule() then
			m:Disengage()
		end
		self:ToggleModuleActive(m, false)
	end
end

-- event handler
function BigWigs:BigWigs_RebootModule(moduleName)
	local moduleName = BB:HasTranslation(moduleName) and BB[moduleName] or moduleName
	local m = self:GetModule(moduleName)
	if m and m:IsBossModule() then
		self:DebugMessage("BigWigs:BigWigs_RebootModule(): " .. m:ToString())
		m:Disengage()
		self:SetupModule(moduleName)
	end
end


-------------------------------
--      Event Handler        --
-------------------------------

function BigWigs:BigWigs_RecvSync(sync, moduleName, nick)
	local s, m, n, playername = "-", "-", "-", UnitName("player")
	if sync then
		if type(sync) == "string" then
			s = sync
		else
			s = type(sync)
		end
	end
	if moduleName then
		if type(moduleName) == "string" then
			m = moduleName
		else
			m = type(moduleName)
		end
	end
	if nick then
		if type(nick) == "string" then
			if nick == playername then
				n = "you"
			else
				n = nick
			end
		else
			n = type(nick)
		end
	end
	self:DebugMessage("sync: " .. s .. " rest: " .. m .. " nick: " .. n)

	local moduleName = BB:HasTranslation(moduleName) and BB[moduleName] or moduleName
	local module = nil
	if self:HasModule(moduleName) then
		module = self:GetModule(moduleName)
	end

	if module and sync == "EnableModule" then
		moduleName = BB:HasTranslation(moduleName) and BB[moduleName] or moduleName

		local isInZone = false
		if type(module.zonename) == "string" and module.zonename == GetRealZoneText() then
			isInZone = true
		elseif type(module.zonename) == "table" then
			for _, v in pairs(module.zonename) do
				if v == GetRealZoneText() then
					isInZone = true
					break
				end
			end
		end

		if isInZone then
			self:EnableModule(moduleName, true)
		end
	elseif module and sync == "EnableExternal" then
		if module.zonename == GetRealZoneText() then
			self:EnableModule(moduleName, true)
		end
	elseif sync == "RebootModule" and moduleName then
		if nick ~= UnitName("player") then
			self:Print(string.format(L["%s has requested forced reboot for the %s module."], nick, moduleName))
		end
		self:TriggerEvent("BigWigs_RebootModule", moduleName)
	elseif module and sync == module:GetEngageSync() then
		if module:IsBossModule() then
			module:Engage()
		end
		--[[elseif module and sync == module:GetWipeSync() then
		if module:IsBossModule() and BigWigs:IsModuleActive(module) then
		self:TriggerEvent("BigWigs_RebootModule", moduleName)
		end]]
	elseif module and sync == module:GetBossDeathSync() then
		if module:IsBossModule() and BigWigs:IsModuleActive(module) then
			module:Victory()
		end
	end
end

function BigWigs:BigWigs_TargetSeen(mobname, unit)
	for name, module in self:IterateModules() do
		if module:IsBossModule() and self:ZoneIsTrigger(module, GetRealZoneText()) and self:MobIsTrigger(module, mobname)
				and (not module.VerifyEnable or module:VerifyEnable(unit)) then
			self:EnableModule(name)

			--[[if UnitExists(unit.."target") then
			-- if this is true the boss is apparantely already in combat!
			-- this situation can happen on bosses which spawn the same time they enter combat (Arlokk/Mandokir) or when a player without BigWigs engages the boss
			module:SendEngageSync()
			end]]
		end
	end
end

-------------------------------
--      	Utility		     --
-------------------------------

function BigWigs:ZoneIsTrigger(module, zone)
	local t = module.zonename
	if type(t) == "string" then
		return zone == t
	elseif type(t) == "table" then
		for _, mzone in pairs(t) do
			if mzone == zone then
				return true
			end
		end
	end
end

function BigWigs:MobIsTrigger(module, name)
	local t = module.enabletrigger
	if type(t) == "string" then
		return name == t
	elseif type(t) == "table" then
		for _, mob in pairs(t) do
			if mob == name then
				return true
			end
		end
	end
end

function BigWigs:CreateLoDMenu()
	local zonelist = BigWigsLoD:GetZones()
	for k, v in pairs(zonelist) do
		if type(v) ~= "table" then
			self:AddLoDMenu(k)
		else
			self:AddLoDMenu(L["Other"])
		end
	end
end

function BigWigs:AddLoDMenu(zonename)
	local zone = nil
	if L:HasTranslation(zonename) then
		zone = L[zonename]
	else
		zone = L["Other"]
	end
	if zone then
		if BZ:HasReverseTranslation(zonename) and L:HasTranslation(BZ:GetReverseTranslation(zonename)) then
			zone = L[BZ:GetReverseTranslation(zonename)]
		elseif L:HasTranslation(zonename) then
			zone = L[zonename]
		end

		if not self.cmdtable.args[L["boss"]].args[zone] then
			self.cmdtable.args[L["boss"]].args[zone] = {
				type = "group",
				name = zonename,
				desc = string.format(L["Options for bosses in %s."], zonename),
				args = {}
			}
		end
	end
end

-- ClassicAPI's aura data carries the spell ID, so this no longer needs SuperWoW's GetPlayerBuffID.
-- CancelUnitBuff counts in C_UnitAuras order, so both must use the same filter.
function BigWigs:CancelAuraId(spellId)
	local i = 1
	local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
	while aura do
		if aura.spellId == spellId then
			CancelUnitBuff("player", i, "HELPFUL")
			return true
		end
		i = i + 1
		aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
	end
	return false
end

-- Coloured raid mark names for chat and tooltips (was SpellStatusV2's SpellstatusV2IndexToIcon)
BigWigs.raidIconText = {
	[1] = "|cFFF7EF52[Star]|r",
	[2] = "|cFFE76100[Circle]|r",
	[3] = "|cFFDE55E7[Diamond]|r",
	[4] = "|cFF2BD923[Triangle]|r",
	[5] = "|cFF8FB9D0[Moon]|r",
	[6] = "|cFF00B9F3[Square]|r",
	[7] = "|cFFB20A05[X]|r",
	[8] = "|cFFF1EFE4[Skull]|r",
}

-- Spell names in the client's language, in place of Babble-Spell. English clients use the English
-- name as written; other clients look it up from a spell ID (any rank gives the same name).
local isEnglishClient = GetLocale() == "enUS" or GetLocale() == "enGB"
function BigWigs:SpellName(english, spellId)
	if not isEnglishClient and spellId then
		local localized = GetSpellInfo(spellId)
		if localized then
			return localized
		end
	end
	return english
end

-- A table indexed like Babble-Spell (BS["Fear Ward"]), so plugins keep their lookups. spellIds maps
-- English names to an ID, used to find the name on non-English clients.
function BigWigs:SpellNameTable(spellIds)
	return setmetatable({}, { __index = function(t, english)
		local name = BigWigs:SpellName(english, spellIds and spellIds[english])
		rawset(t, english, name)
		return name
	end })
end

-- Your own successful casts, as BigWigs_PlayerCast(spellId, spellName, targetName), in place of
-- SpellStatusV2's hooks on every cast function. The target name comes from UNIT_SPELLCAST_SENT,
-- matched to the cast by its castGUID; it is nil for spells cast without a target.
do
	local sentTargets = {}
	local sentCount = 0
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("UNIT_SPELLCAST_SENT")
	frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
	frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	frame:SetScript("OnEvent", function()
		if arg1 ~= "player" then
			return
		end
		if event == "UNIT_SPELLCAST_SENT" then
			-- arg2 target name, arg3 castGUID
			if sentCount > 20 then
				sentTargets = {}
				sentCount = 0
			end
			if arg2 and arg2 ~= "" then
				-- the target can be a unit (party1, mouseover) when the cast named one, e.g. from
				-- a click-cast or macro; turn it into the player's name
				local target = arg2
				if UnitExists(target) then
					target = UnitName(target) or target
				end
				sentTargets[arg3] = target
				sentCount = sentCount + 1
			end
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
			-- arg2 castGUID, arg3 spellID, arg4 spellName
			local target = sentTargets[arg2]
			sentTargets[arg2] = nil
			BigWigs:TriggerEvent("BigWigs_PlayerCast", arg3, arg4, target)
		else
			sentTargets[arg2] = nil
		end
	end)
end

function BigWigs:CancelAuraTexture(texture)
	local i = 0
	while true do
		local buffIndex = GetPlayerBuff(i, "HELPFUL")
		i = i + 1
		if buffIndex == -1 then
			break
		end
		local buffTexture = GetPlayerBuffTexture(buffIndex)
		if string.find(buffTexture, texture) then
			CancelPlayerBuff(buffIndex)
			return true
		end
	end

	return false
end

function BigWigs:GetUnitIdByName(name, depth)
	depth = depth or 0 -- default to raid members
	local suffix = ""
	for i = 1, depth do
		suffix = suffix .. "target"
	end

	for i = 1, GetNumRaidMembers() do
		local id = "raid" .. i .. suffix
		if UnitName(id) == name then
			return id
		end
	end
end

function BigWigs:GetTargetByName(name, depth)
	depth = depth or 1 -- default to targets of raid members
	local unitId = BigWigs:GetUnitIdByName(name, depth)
	if unitId then 
		return UnitName(unitId .. "target")
	end
end

function BigWigs:GetGUIDByName(name, depth, ignoredGUIDs)
	depth = depth or 1 -- default to targets of raid members
	local suffix = ""
	for i = 1, depth do
		suffix = suffix .. "target"
	end

	for i = 1, GetNumRaidMembers() do
		local id = "raid" .. i .. suffix
		if UnitName(id) == name then
			local targetGUID = UnitGUID(id)
			if type(ignoredGUIDs) == "table" then
				for _, excludedGUID in pairs(ignoredGUIDs) do
					if targetGUID == excludedGUID then
						targetGUID = nil
						break
					end
				end
			end
			if targetGUID then
				return targetGUID
			end
		end
	end
end

-- Finds a visible unit with this name and returns its GUID, which ClassicAPI accepts as a unit
-- token (UnitHealth(guid), UnitName(guid .. "target")...). Checks the GUID found last time first,
-- then your target and mouseover, the raid marks, visible nameplates and the raid's targets, so a
-- boss is found even when nobody targets it. Returns nil when no visible unit has the name.
local unitGUIDByName = {}
local function GUIDIfNamed(unit, name)
	if UnitExists(unit) and UnitName(unit) == name then
		return UnitGUID(unit)
	end
end
function BigWigs:FindUnitByName(name)
	if not name then
		return
	end
	local guid = unitGUIDByName[name]
	if guid and UnitExists(guid) and UnitName(guid) == name then
		return guid
	end
	guid = GUIDIfNamed("target", name) or GUIDIfNamed("mouseover", name)
	local i = 1
	while not guid and i <= 8 do
		guid = GUIDIfNamed("mark" .. i, name)
		i = i + 1
	end
	i = 1
	while not guid and i <= 40 do
		guid = GUIDIfNamed("nameplate" .. i, name)
		i = i + 1
	end
	i = 1
	local num = GetNumRaidMembers()
	while not guid and i <= num do
		guid = GUIDIfNamed("raid" .. i .. "target", name)
		i = i + 1
	end
	unitGUIDByName[name] = guid
	return guid
end

function BigWigs:RaidTargetLookup(input, colorize)
	local raidTargets = {
		[0] = "none",
		[1] = "Star",
		[2] = "Circle",
		[3] = "Diamond",
		[4] = "Triangle",
		[5] = "Moon",
		[6] = "Square",
		[7] = "Cross",
		[8] = "Skull"
	}

	if type(input) == "number" then
		local output = raidTargets[input]
		if output then
			if colorize then
				return BigWigsColors:ColorizeString(L[output], output)
			else
				return L[output]
			end
		end
	elseif type(input) == "string" then
		input = string.lower(input)
		for i = 0, 8 do
			if input == string.lower(raidTargets[i]) then
				return i
			end
		end
	elseif type(input) == "nil" then
		if colorize then
			return BigWigsColors:ColorizeString(L["unmarked"], "unmarked")
		else
			return L["unmarked"]
		end
	end
end

function BigWigs:FormatLargeNumber(integer)
	local integerString = tostring(integer)
	local length = string.len(integerString)
		
	if length < 5 then return integerString end
	
	local suffix = "k"
	if length > 7 then
		suffix = "m"
		length = length - 3
	end

	if length == 5 then
		return string.sub(integerString, 1, 2) .. "." .. string.sub(integerString, 3, 4) .. suffix
	elseif length == 6 then
		return string.sub(integerString, 1, 3) .. "." .. string.sub(integerString, 4, 4) .. suffix
	elseif length == 7 then
		return string.sub(integerString, 1, 4) .. suffix
	end
end

-- ClassicAPI's aura data carries the spell ID, so these no longer depend on SuperWoW's extra
-- UnitBuff / UnitDebuff returns. The HARMFUL / HELPFUL filters go by each aura's real polarity,
-- so a debuff that Turtle moves into a buff slot (once all 16 debuff slots are full) still counts.
function BigWigs:BuffIsPresent(unitId, spellId)
	if UnitExists(unitId) and C_UnitAuras.GetUnitAuraBySpellID(unitId, spellId, "HELPFUL") then
		return true
	end
end

function BigWigs:DebuffIsPresent(unitId, spellId)
	if UnitExists(unitId) and C_UnitAuras.GetUnitAuraBySpellID(unitId, spellId, "HARMFUL") then
		return true
	end
end

function BigWigs:AuraIsPresent(unitId, spellId)
	return BigWigs:DebuffIsPresent(unitId, spellId) or BigWigs:BuffIsPresent(unitId, spellId)
end

local castDebuffs = {
	[1] = {11719, 1.6, 1}, -- Curse of Tongues Rank 2
	[2] = {1714, 1.5, 0},  -- Curse of Tongues Rank 1
	[3] = {11398, 1.6, 2}, -- Mind-numbing Poison III
	[4] = {8692, 1.5, 1},  -- Mind-numbing Poison II
	[5] = {5760, 1.4, 0},  -- Mind-numbing Poison I
}

function BigWigs:GetCastTimeCoefficient(unitId)
	local coefficient = 1
	
	if UnitExists(unitId) then
		local i = 1
		local n = table.getn(castDebuffs)
		while i <= n do
			if BigWigs:AuraIsPresent(unitId, castDebuffs[i][1]) then
				coefficient = coefficient * castDebuffs[i][2]
				i = i + castDebuffs[i][3]
			end
			i = i + 1
		end
	end
	
	return coefficient
end

function BigWigs:GetHealthPercent(unitId, round)
	if UnitExists(unitId) then
		local maxHp = UnitHealthMax(unitId)
		if maxHp and maxHp > 0 then
			if round then
				return math.floor(UnitHealth(unitId) / maxHp * 100)
			else
				return UnitHealth(unitId) / maxHp * 100
			end
		end
	end
end
