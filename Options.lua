assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsOptions")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function()
	return {
		["|cff00ff00Module running|r"] = true,
		["|cffeda55fClick|r to reset all running modules. |cffeda55fCtrl+Click|r to force reboot for everyone (Requires assistant or higher). |cffeda55fAlt+Click|r to disable them. |cffeda55fCtrl+Alt+Click|r to disable Big Wigs completely."] = true,
		["|cffeda55fClick|r to enable."] = true,
		["Big Wigs is currently disabled."] = true,
		["Active boss modules"] = true,
		["hidden"] = true,
		["shown"] = true,
		["minimap"] = true,
		["Minimap"] = true,
		["Toggle the minimap button."] = true,
		["All running modules have been reset."] = true,
		["All running modules have been rebooted for all raid members."] = true,
		["All running modules have been disabled."] = true,
		["%s reset."] = true,
		["%s disabled."] = true,
		["%s icon is now %s."] = true,
		["Show it again with /bw plugin minimap."] = true,
		["You need to be an assistant or raid leader to use this function."] = true,

		-- AddOn Options pages and the minimap button
		["Boss timers and warnings."] = true,
		["Enable BigWigs"] = true,
		["Minimap button"] = true,
		["Settings for bosses, plugins and extras are on the pages under BigWigs. They can be changed while BigWigs is enabled."] = true,
		["Tools"] = true,
		["Test"] = true,
		["Local test"] = true,
		["Sync test"] = true,
		["Voice test"] = true,
		["Plays one spoken warning from each group."] = true,
		["Edit Layout"] = true,
		["Options"] = true,
		["Running boss modules"] = true,
		["Reset running modules"] = true,
		["Reboot for the raid"] = true,
		["Resets the running modules for everyone. Needs raid leader or assistant."] = true,
		["Disable running modules"] = true,
		["Bosses: %s"] = true,
		["Plugins: %s"] = true,
		["Extras: %s"] = true,
		["General"] = true,
		["Click to open the options."] = true,
		["Right-click for tests and quick actions."] = true,
		["Drag to move this button."] = true,
	}
end)

L:RegisterTranslations("esES", function()
	return {
		["|cff00ff00Module running|r"] = "|cff00ff00Módulo activado|r",
		["|cffeda55fClick|r to reset all running modules. |cffeda55fCtrl+Click|r to force reboot for everyone (Requires assistant or higher). |cffeda55fAlt+Click|r to disable them. |cffeda55fCtrl+Alt+Click|r to disable Big Wigs completely."] = "|cffeda55fHaz Clic|r para reiniciar todos los módulos activos. |cffeda55fCtrl+Clic|r para reiniciar para todos (Requiere asistente o líder). |cffeda55fAlt+Clic|r para desactivarlos. |cffeda55fCtrl+Alt+Clic|r para desactivar Big Wigs.",
		["|cffeda55fClick|r to enable."] = "|cffeda55fHaz Clic|r para activar.",
		["Big Wigs is currently disabled."] = "Big Wigs está desactivo",
		["Active boss modules"] = "Módulos de Jefe Activos",
		--["hidden"] = "oculto",
		--["shown"] = "mostrado",
		--["minimap"] = "minimapa",
		["Minimap"] = "Minimapa",
		["Toggle the minimap button."] = "Alterna el botón del minimapa",
		["All running modules have been reset."] = "Todos los módulos activos fueron reiniciados",
		["All running modules have been rebooted for all raid members."] = "Todos los módulos activos fueros reiniciados para todos los miembros de la banda",
		["All running modules have been disabled."] = "Todos los módulos activos fueron desactivados",
		["%s reset."] = "%s Reiniciado",
		["%s disabled."] = "%s Desactivado",
		["%s icon is now %s."] = "el icono %s ahora es %s.",
		["Show it again with /bw plugin minimap."] = "Mostrar con /bw plugin minimap",
		["You need to be an assistant or raid leader to use this function."] = "Tienes que ser asistente o líder para usar la función",
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["|cff00ff00Module running|r"] = "|cff00ff00Modul aktiviert|r",
		["|cffeda55fClick|r to reset all running modules. |cffeda55fCtrl+Click|r to force reboot for everyone (Requires assistant or higher). |cffeda55fAlt+Click|r to disable them. |cffeda55fCtrl+Alt+Click|r to disable Big Wigs completely."] = "|cffeda55fKlicken|r, um alle laufenden Module zurückzusetzen. |cffeda55fStrg+Klick|r um Reset für jedermann zu erzwingen (Benötigt Assistent oder höher). |cffeda55fAlt+Klick|r um alle laufenden Module zu beenden. |cffeda55fStrg+Shift+Klick|r um BigWigs komplett zu beenden.",
		["|cffeda55fClick|r to enable."] = "|cffeda55fKlicken|r um zu aktivieren.",
		["Big Wigs is currently disabled."] = "Big Wigs ist momentan deaktiviert.",
		["Active boss modules"] = "Aktive Boss Module",
		["hidden"] = "versteckt",
		["shown"] = "angezeigt",
		-- ["minimap"] = true,
		["Minimap"] = "Minimap",
		["Toggle the minimap button."] = "Minimap Button anzeigen.",
		["All running modules have been reset."] = "Alle laufenden Module wurden zurückgesetzt.",
		["All running modules have been rebooted for all raid members."] = "Alle laufenden Module wurden für alle Schlachtzugsmitglieder neu gestartet.",
		["All running modules have been disabled."] = "Alle laufenden Module wurden beendet.",
		["%s reset."] = "%s zurückgesetzt.",
		["%s disabled."] = "%s beendet.",
		["%s icon is now %s."] = "%s Icon ist jetzt %s.",
		["You need to be an assistant or raid leader to use this function."] = "Du musst Schlachtzugsleiter oder Assistent sein, um diese Funktion zu benutzen.",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["|cff00ff00Module running|r"] = "|cff00ff00模块运行中|r",
		["|cffeda55fClick|r to reset all running modules. |cffeda55fCtrl+Click|r to force reboot for everyone (Requires assistant or higher). |cffeda55fAlt+Click|r to disable them. |cffeda55fCtrl+Alt+Click|r to disable Big Wigs completely."] = "|cffeda55f点击|r重置所有运行中的模块。|cffeda55fCtrl+点击|r为全团强制重启（需要助理或更高权限）。|cffeda55fAlt+点击|r禁用这些模块。|cffeda55fCtrl+Alt+点击|r完全禁用 Big Wigs。",
		["|cffeda55fClick|r to enable."] = "|cffeda55f点击|r启用。",
		["Big Wigs is currently disabled."] = "Big Wigs 当前已禁用。",
		["Active boss modules"] = "当前启用的 Boss 模块",
		["hidden"] = "隐藏",
		["shown"] = "显示",
		["minimap"] = "minimap",
		["Minimap"] = "小地图按钮",
		["Toggle the minimap button."] = "切换小地图按钮显示。",
		["All running modules have been reset."] = "所有运行中的模块已重置。",
		["All running modules have been rebooted for all raid members."] = "已为所有团队成员重启所有运行中的模块。",
		["All running modules have been disabled."] = "所有运行中的模块已禁用。",
		["%s reset."] = "%s 已重置。",
		["%s disabled."] = "%s 已禁用。",
		["%s icon is now %s."] = "%s 图标现在为 %s。",
		["Show it again with /bw plugin minimap."] = "使用 `/bw plugin minimap` 再次显示。",
		["You need to be an assistant or raid leader to use this function."] = "你需要是助理或团长才能使用此功能。",
	}
end)

----------------------------------
--      Module Declaration      --
----------------------------------

-- BigWigs options: AddOn Options pages built from BigWigs.cmdtable, and a minimap button with a
-- right-click menu. Replaces FuBarPlugin-2.0, Dewdrop-2.0 and Tablet-2.0. The /bw typed commands are
-- still AceConsole's and edit the same settings; /bw on its own opens the options.

local Kit = ClassicAPIOptionsKit
local BL = AceLibrary("AceLocale-2.2"):new("BigWigs")

BigWigsOptions = {}
AceLibrary("AceEvent-2.0"):embed(BigWigsOptions)

local ICON_ENABLED = "Interface\\AddOns\\BigWigs\\Icons\\core-enabled"
local ICON_DISABLED = "Interface\\AddOns\\BigWigs\\Icons\\core-disabled"

local function DB()
	return BigWigs.db.profile
end

local function IsMinimapButtonShown()
	return DB().minimapbutton ~= false
end

local function SetMinimapButtonShown(v)
	DB().minimapbutton = v and true or false
	BigWigsOptions:UpdateMinimapButton()
end

-- keeps /bw plugin minimap working; the AddOn Options root page has the same switch
local deuce = BigWigs:NewModule("Options Menu")
deuce.consoleCmd = L["minimap"]
deuce.consoleOptions = {
	type = "toggle",
	name = L["Minimap"],
	desc = L["Toggle the minimap button."],
	guiHidden = true, -- shown on the root page instead
	get = function()
		return IsMinimapButtonShown()
	end,
	set = function(v)
		SetMinimapButtonShown(v)
		if not v then
			BigWigs:Print(L["Show it again with /bw plugin minimap."])
		end
	end,
	map = { [false] = L["hidden"], [true] = L["shown"] },
	message = L["%s icon is now %s."],
}

------------------------------
--      Module actions      --
------------------------------

local function ForEachRunningModule(fn)
	for name, module in BigWigs:IterateModules() do
		if module:IsBossModule() and BigWigs:IsModuleActive(module) then
			fn(name, module)
		end
	end
end

local function IsRaidAssistant()
	return IsRaidLeader() or IsRaidOfficer()
end

function BigWigsOptions:ResetRunningModules()
	ForEachRunningModule(function(name)
		BigWigs:BigWigs_RebootModule(name)
	end)
	BigWigs:Print(L["All running modules have been reset."])
end

function BigWigsOptions:RebootRunningModulesForRaid()
	if not IsRaidAssistant() then
		BigWigs:Print(L["You need to be an assistant or raid leader to use this function."])
		return
	end
	ForEachRunningModule(function(name, module)
		BigWigs:TriggerEvent("BigWigs_SendSync", "RebootModule " .. tostring(module))
	end)
	BigWigs:Print(L["All running modules have been rebooted for all raid members."])
end

function BigWigsOptions:DisableRunningModules()
	ForEachRunningModule(function(name, module)
		BigWigs:ToggleModuleActive(module, false)
	end)
	BigWigs:Print(L["All running modules have been disabled."])
end

-- kind: "local", "sync" or "voice"
function BigWigsOptions:RunTest(kind)
	if not BigWigs:IsActive() then
		BigWigs:ToggleActive(true)
	end
	if BigWigs:HasModule("Test") and not BigWigs:IsModuleActive("Test") then
		BigWigs:ToggleModuleActive("Test", true)
	end
	if not BigWigsTest then
		return
	end
	if kind == "sync" then
		BigWigsTest:TriggerEvent("BigWigs_SyncTest")
	elseif kind == "voice" then
		BigWigsTest:VoiceTest()
	else
		BigWigsTest:TriggerEvent("BigWigs_Test")
	end
end

------------------------------
--      Option adapter      --
------------------------------
-- Walks AceConsole option tables and adds a Kit control for each entry:
-- toggle -> checkbox, range -> slider, text with a validate list -> dropdown, other text -> edit box,
-- color -> colour swatch, execute -> button, header -> heading or gap, group -> heading and its entries.

local pageForOptions = {} -- option table -> its page, so an anchor's Options button opens the right page

local function Eval(value, handler)
	if type(value) == "function" then
		return value()
	elseif type(value) == "string" then
		if handler and type(handler[value]) == "function" then
			return handler[value](handler)
		end
		return nil
	end
	return value
end

-- Calls an AceConsole get/set/func as AceConsole does: a string names a method on the handler, and in a
-- group with pass = true the entry's key goes first
local function Caller(fn, handler, passKey)
	if type(fn) == "string" then
		if not handler or type(handler[fn]) ~= "function" then
			return nil
		end
		if passKey ~= nil then
			return function(a1, a2, a3, a4)
				return handler[fn](handler, passKey, a1, a2, a3, a4)
			end
		end
		return function(a1, a2, a3, a4)
			return handler[fn](handler, a1, a2, a3, a4)
		end
	elseif type(fn) == "function" then
		if passKey ~= nil then
			return function(a1, a2, a3, a4)
				return fn(passKey, a1, a2, a3, a4)
			end
		end
		return fn
	end
end

-- A getter that fails shows the control empty instead of breaking the page's refresh, which would skip
-- every control after it
local function SafeGet(get)
	if not get then
		return nil
	end
	return function()
		local ok, a, b, c, d = pcall(get)
		if ok then
			return a, b, c, d
		end
	end
end

-- The entry's own get/set/func, else its pass group's (Dewdrop's order; get = false means none)
local function Accessor(node, key, field, ctx)
	local fn
	local own = node[field]
	if own then
		fn = Caller(own, node.handler or ctx.handler, nil)
	elseif own == nil and ctx.pass and ctx.pass[field] then
		fn = Caller(ctx.pass[field], ctx.pass.handler or ctx.handler, key)
	end
	if field == "get" then
		return SafeGet(fn)
	end
	return fn
end

local function NodeName(key, node)
	return node.guiName or node.name or tostring(key)
end

local function SortedArgs(args)
	local list = {}
	for key, node in pairs(args) do
		if type(node) == "table" then
			table.insert(list, { key = key, node = node })
		end
	end
	table.sort(list, function(a, b)
		local oa, ob = a.node.order or 100, b.node.order or 100
		-- Dewdrop lists negative orders last (bosskill is -1)
		if oa < 0 then
			oa = 10000 + oa
		end
		if ob < 0 then
			ob = 10000 + ob
		end
		if oa ~= ob then
			return oa < ob
		end
		return tostring(NodeName(a.key, a.node)) < tostring(NodeName(b.key, b.node))
	end)
	return list
end

-- disabled and hidden checks from the entry and every group above it
local function AddChecks(checks, node, handler)
	local hasDisabled = node.disabled ~= nil and node.disabled ~= false
	local hasHidden = node.hidden ~= nil and node.hidden ~= false
	if not hasDisabled and not hasHidden then
		return checks
	end
	local copy = {}
	for i, c in ipairs(checks) do
		copy[i] = c
	end
	if hasDisabled then
		table.insert(copy, { node.disabled, handler })
	end
	if hasHidden then
		table.insert(copy, { node.hidden, handler })
	end
	return copy
end

local function EnabledFn(checks)
	if table.getn(checks) == 0 then
		return nil
	end
	return function()
		for _, c in ipairs(checks) do
			if Eval(c[1], c[2]) then
				return false
			end
		end
		return true
	end
end

-- AceConsole descriptions are sentences, so the tooltip wraps them under the option's name
local function Tip(frame, title, text)
	if not frame or not text or text == "" then
		return
	end
	frame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
		GameTooltip:SetText(title, 1, 1, 1)
		GameTooltip:AddLine(text, nil, nil, nil, 1)
		GameTooltip:Show()
	end)
	frame:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
end

-- A button that greys out with enabledIf (the kit's Button has no enabled state)
local function Button(page, label, desc, onClick, enabledIf)
	local button = page:Button({ label = label, onClick = onClick })
	local text = getglobal(button:GetName() .. "Text")
	if text then
		button:SetWidth(math.max(160, text:GetStringWidth() + 30))
	end
	Tip(button, label, desc)
	button.Update = function(self)
		if not enabledIf or enabledIf() then
			self:Enable()
		else
			self:Disable()
		end
	end
	table.insert(page.controls, button)
	return button
end

local function DropdownOptions(validate)
	local options = {}
	if validate[1] ~= nil then
		for _, v in ipairs(validate) do
			table.insert(options, { value = v, text = tostring(v) })
		end
	else
		for k, v in pairs(validate) do
			table.insert(options, { value = k, text = tostring(v) })
		end
		table.sort(options, function(a, b)
			return a.text < b.text
		end)
	end
	return options
end

local AddNode

local function AddArgs(page, args, ctx)
	for _, e in ipairs(SortedArgs(args)) do
		AddNode(page, e.key, e.node, ctx)
	end
end

AddNode = function(page, key, node, ctx)
	local handler = node.handler or ctx.handler
	-- hidden when the page is built: left out, as the old menu did. These are mostly options for other
	-- addons that aren't installed (oRA, CT_RaidAssist), whose getters fail without them.
	if node.guiHidden or Eval(node.hidden, handler) then
		return
	end
	local kind = string.lower(node.type or "group")
	local checks = AddChecks(ctx.checks, node, handler)
	local name = NodeName(key, node)
	local desc = node.desc
	local o = { label = name, enabledIf = EnabledFn(checks), indent = 0 }

	if kind == "group" then
		if type(node.args) ~= "table" or not next(node.args) then
			return
		end
		page:Header(name)
		AddArgs(page, node.args, { handler = handler, pass = node.pass and node or nil, checks = checks })

	elseif kind == "header" then
		if node.name and string.gsub(node.name, "%s", "") ~= "" then
			page:Header(node.name)
		else
			page:Spacer(6)
		end

	elseif kind == "execute" then
		local func = Accessor(node, key, "func", ctx)
		if func then
			Button(page, name, desc, function()
				func()
				page:Refresh()
			end, o.enabledIf)
		end

	elseif kind == "toggle" then
		local get, set = Accessor(node, key, "get", ctx), Accessor(node, key, "set", ctx)
		if get and set then
			o.setting = {
				get = function()
					return get() and true or false
				end,
				set = function(v)
					set(v)
				end,
			}
			Tip(page:Checkbox(o), name, desc)
		end

	elseif kind == "range" then
		local get, set = Accessor(node, key, "get", ctx), Accessor(node, key, "set", ctx)
		if get and set then
			o.min, o.max = node.min or 0, node.max or 1
			o.step = node.step or ((o.max - o.min) > 10 and 1 or 0.01)
			o.setting = { get = function()
				return get()
			end, set = function(v)
				set(v)
			end }
			Tip(page:Slider(o), name, desc)
		end

	elseif kind == "color" then
		local get, set = Accessor(node, key, "get", ctx), Accessor(node, key, "set", ctx)
		if get and set then
			o.hasAlpha = node.hasAlpha and true or false
			o.setting = {
				get = function()
					local r, g, b, a = get()
					return { r or 1, g or 1, b or 1, a }
				end,
				set = function(c)
					set(c[1], c[2], c[3], c[4])
				end,
			}
			Tip(page:Color(o), name, desc)
		end

	elseif kind == "text" then
		local get, set = Accessor(node, key, "get", ctx), Accessor(node, key, "set", ctx)
		if not set then
			return
		end
		if type(node.validate) == "table" then
			o.options = DropdownOptions(node.validate)
			o.setting = { get = function()
				return get and get()
			end, set = function(v)
				set(v)
			end }
			local dropdown = page:Dropdown(o)
			Tip(dropdown, name, desc)
			Tip(getglobal(dropdown:GetName() .. "Button"), name, desc)
		else
			-- typed input; an entry without get (custom bars, version query) clears after Enter
			local validator = node.validate and Caller(node.validate, handler)
			if node.usage then
				o.label = name .. "  |cff808080" .. node.usage .. "|r"
			end
			o.width = 260
			o.parse = function(text)
				if validator and not validator(text) then
					return nil
				end
				return text
			end
			o.setting = { get = function()
				return get and get()
			end, set = function(v)
				set(v)
			end }
			Tip(page:EditBox(o), name, desc)
		end
	end
end

----------------------------
--      Options pages      --
----------------------------

-- The page fills itself the first time it's shown, so login doesn't build hundreds of controls
local function LazyPage(name, title, subtitle, fill)
	local page
	page = Kit:NewPage({
		name = name,
		parent = "BigWigs",
		title = title,
		subtitle = subtitle,
		onShow = function()
			if page.filled then
				return
			end
			page.filled = true
			local ok, err = pcall(fill, page)
			if not ok then
				geterrorhandler()(err)
			end
		end,
	})
	return page
end

local function BuildRootPage()
	local cmd = BigWigs.cmdtable
	local root = Kit:NewPage({
		name = "BigWigs",
		subtitle = L["Boss timers and warnings."] .. "  " .. (BigWigs.version or ""),
	})
	local isActive = function()
		return BigWigs:IsActive()
	end

	root:Checkbox({
		label = L["Enable BigWigs"],
		indent = 0,
		setting = { get = isActive, set = function(v)
			BigWigs:ToggleActive(v)
		end },
	})
	root:Checkbox({
		label = L["Minimap button"],
		indent = 0,
		setting = { get = IsMinimapButtonShown, set = SetMinimapButtonShown },
	})
	root:Text(L["Settings for bosses, plugins and extras are on the pages under BigWigs. They can be changed while BigWigs is enabled."])

	-- Edit Layout, the healer profile and the test buttons from the /bw table
	root:Header(L["Tools"])
	local loose = {}
	for _, e in ipairs(SortedArgs(cmd.args)) do
		if string.lower(e.node.type or "group") ~= "group" then
			table.insert(loose, e)
		end
	end
	for _, e in ipairs(loose) do
		AddNode(root, e.key, e.node, { handler = cmd.handler, checks = {} })
	end
	Button(root, L["Voice test"], L["Plays one spoken warning from each group."], function()
		BigWigsOptions:RunTest("voice")
	end)

	root:Header(L["Running boss modules"])
	Button(root, L["Reset running modules"], nil, function()
		BigWigsOptions:ResetRunningModules()
	end, isActive)
	Button(root, L["Reboot for the raid"], L["Resets the running modules for everyone. Needs raid leader or assistant."], function()
		BigWigsOptions:RebootRunningModulesForRaid()
	end, function()
		return BigWigs:IsActive() and IsRaidAssistant()
	end)
	Button(root, L["Disable running modules"], nil, function()
		BigWigsOptions:DisableRunningModules()
	end, isActive)
	return root
end

local function BuildPages()
	local cmd = BigWigs.cmdtable
	BigWigsOptions.root = BuildRootPage()

	local used = { ["BigWigs"] = true }
	local sections = {
		{ group = cmd.args[BL["boss"]], format = L["Bosses: %s"] },
		{ group = cmd.args[BL["plugin"]], format = L["Plugins: %s"] },
		{ group = cmd.args[BL["extra"]], format = L["Extras: %s"] },
	}
	for _, section in ipairs(sections) do
		local group = section.group
		if group and type(group.args) == "table" then
			local handler = group.handler or cmd.handler
			local checks = AddChecks({}, group, handler)
			local loose = {}
			for _, e in ipairs(SortedArgs(group.args)) do
				local node = e.node
				local isGroup = string.lower(node.type or "group") == "group"
				if node.guiHidden or node.hidden == true then
					-- not shown in menus
				elseif isGroup and type(node.args) == "table" and next(node.args) then
					local title = NodeName(e.key, node)
					local name = string.format(section.format, title)
					if used[name] then
						name = name .. " (" .. tostring(e.key) .. ")"
					end
					used[name] = true
					local pageCtx = {
						handler = node.handler or handler,
						pass = node.pass and node or nil,
						checks = AddChecks(checks, node, node.handler or handler),
					}
					local args = node.args
					pageForOptions[node] = LazyPage(name, title, node.desc, function(page)
						AddArgs(page, args, pageCtx)
					end)
				elseif not isGroup then
					table.insert(loose, e)
				end
			end
			-- entries that sit directly in the section rather than in a group of their own
			if table.getn(loose) > 0 then
				local ctx = { handler = handler, checks = checks }
				LazyPage(string.format(section.format, L["General"]), group.name, group.desc, function(page)
					for _, e in ipairs(loose) do
						AddNode(page, e.key, e.node, ctx)
					end
				end)
			end
		end
	end
end

-- Opens AddOn Options at a page (the root page when nil)
function BigWigsOptions:Open(page)
	if self.root then
		Kit:Open(page or self.root)
	end
end

-- The Options button on each anchor (Bars, Messages, Warning Sign, Mage Tools) opens its plugin's page
function BigWigsOptions:OpenMenu(button)
	local owner = button and button.owner
	self:Open(owner and pageForOptions[owner.consoleOptions])
end

-----------------------------
--      Minimap button      --
-----------------------------

local function IsMinimapSquare()
	return IsAddOnLoaded("CornerMinimap") or IsAddOnLoaded("SquareMinimap") or IsAddOnLoaded("Squeenix")
end

-- FuBarPlugin's placement, so the button sits where the FuBar icon was
local function UpdatePosition(button)
	local angle = math.rad(DB().minimapPosition or 180)
	local x, y
	if IsMinimapSquare() then
		x = math.max(-82, math.min(110 * math.cos(angle), 84))
		y = math.max(-86, math.min(110 * math.sin(angle), 82))
	else
		x = math.cos(angle) * 80
		y = math.sin(angle) * 80
	end
	button:ClearAllPoints()
	button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

local function OnDragUpdate()
	local mx, my = Minimap:GetCenter()
	local px, py = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()
	px, py = px / scale, py / scale
	local position = math.deg(math.atan2(py - my, px - mx))
	if position <= 0 then
		position = position + 360
	end
	DB().minimapPosition = position
	UpdatePosition(this)
end

local function ShowButtonTooltip(button)
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")
	GameTooltip:AddLine("BigWigs")
	if BigWigs:IsActive() then
		local first = true
		ForEachRunningModule(function(name)
			if first then
				GameTooltip:AddLine(L["Active boss modules"], 1, 0.82, 0)
				first = false
			end
			GameTooltip:AddLine("  " .. name, 1, 1, 1)
		end)
	else
		GameTooltip:AddLine(L["Big Wigs is currently disabled."], 1, 0.3, 0.3)
	end
	GameTooltip:AddLine(L["Click to open the options."], 0.2, 1, 0.2)
	GameTooltip:AddLine(L["Right-click for tests and quick actions."], 0.2, 1, 0.2)
	GameTooltip:AddLine(L["Drag to move this button."], 0.2, 1, 0.2)
	GameTooltip:Show()
end

-- Right-click menu, using the game's own dropdown in place of Dewdrop
local menu = nil

local function AddItem(level, text, func, extra)
	local info = {}
	info.text = text
	info.func = func
	info.notCheckable = 1
	if extra then
		for k, v in pairs(extra) do
			info[k] = v
		end
	end
	UIDropDownMenu_AddButton(info, level)
end

local function InitMenu()
	local level = UIDROPDOWNMENU_MENU_LEVEL or 1
	local active = BigWigs:IsActive()
	local inactive = not active and 1 or nil

	if level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "test" then
			AddItem(2, L["Local test"], function()
				BigWigsOptions:RunTest("local")
			end)
			AddItem(2, L["Sync test"], function()
				BigWigsOptions:RunTest("sync")
			end, { disabled = not IsRaidAssistant() and 1 or nil })
			AddItem(2, L["Voice test"], function()
				BigWigsOptions:RunTest("voice")
			end)
		end
		return
	end

	AddItem(1, "BigWigs", nil, { isTitle = 1 })
	AddItem(1, L["Enable BigWigs"], function()
		BigWigs:ToggleActive(not BigWigs:IsActive())
	end, { notCheckable = nil, checked = active and 1 or nil })
	AddItem(1, L["Test"], nil, { hasArrow = 1, value = "test" })
	AddItem(1, L["Edit Layout"], function()
		BigWigs:EditLayout()
	end, { disabled = inactive })
	AddItem(1, L["Reset running modules"], function()
		BigWigsOptions:ResetRunningModules()
	end, { disabled = inactive })
	AddItem(1, L["Reboot for the raid"], function()
		BigWigsOptions:RebootRunningModulesForRaid()
	end, { disabled = (not active or not IsRaidAssistant()) and 1 or nil })
	AddItem(1, L["Disable running modules"], function()
		BigWigsOptions:DisableRunningModules()
	end, { disabled = inactive })
	AddItem(1, L["Options"], function()
		BigWigsOptions:Open()
	end)
	AddItem(1, CLOSE, function()
		CloseDropDownMenus()
	end)
end

local function CreateButton()
	local button = CreateFrame("Button", "BigWigsMinimapButton", Minimap)
	button:SetWidth(31)
	button:SetHeight(31)
	button:SetFrameStrata("MEDIUM")
	button:SetFrameLevel(8)
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	local icon = button:CreateTexture(nil, "BACKGROUND")
	icon:SetTexture(BigWigs:IsActive() and ICON_ENABLED or ICON_DISABLED)
	icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	icon:SetWidth(20)
	icon:SetHeight(20)
	icon:SetPoint("TOPLEFT", button, "TOPLEFT", 7, -5)
	if icon.SetMask then
		icon:SetMask("Textures\\MinimapMask")
	end
	button.icon = icon

	local overlay = button:CreateTexture(nil, "OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	overlay:SetWidth(53)
	overlay:SetHeight(53)
	overlay:SetPoint("TOPLEFT", button, "TOPLEFT")

	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")

	button:SetScript("OnMouseDown", function()
		this.dragged = false
		this.icon:SetTexCoord(0.14, 0.86, 0.14, 0.86)
	end)
	button:SetScript("OnMouseUp", function()
		this.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	end)
	button:SetScript("OnClick", function()
		if this.dragged then
			return
		end
		GameTooltip:Hide()
		if arg1 == "RightButton" then
			if not menu then
				menu = CreateFrame("Frame", "BigWigsMinimapMenu", UIParent, "UIDropDownMenuTemplate")
				menu.initialize = InitMenu
				menu.displayMode = "MENU"
			end
			ToggleDropDownMenu(1, nil, menu, "cursor", 0, 0)
		else
			CloseDropDownMenus()
			BigWigsOptions:Open()
		end
	end)
	button:SetScript("OnDragStart", function()
		this.dragged = true
		this:LockHighlight()
		this.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		GameTooltip:Hide()
		this:SetScript("OnUpdate", OnDragUpdate)
	end)
	button:SetScript("OnDragStop", function()
		this:SetScript("OnUpdate", nil)
		this:UnlockHighlight()
	end)
	button:SetScript("OnEnter", function()
		ShowButtonTooltip(this)
	end)
	button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	return button
end

function BigWigsOptions:UpdateMinimapButton()
	local button = self.minimapButton
	if not IsMinimapButtonShown() then
		if button then
			button:Hide()
		end
		return
	end
	if not button then
		button = CreateButton()
		self.minimapButton = button
	end
	UpdatePosition(button)
	button:Show()
end

-- The icon follows BigWigs being enabled or disabled, and the root page's switch with it
function BigWigsOptions:CoreState()
	if self.minimapButton then
		self.minimapButton.icon:SetTexture(BigWigs:IsActive() and ICON_ENABLED or ICON_DISABLED)
	end
	if self.root and self.root:IsVisible() then
		self.root:Refresh()
	end
end

-- Once: the FuBar icon's position and hidden state (BigWigsFubarDB) become the button's
local function MigrateFuBarSettings()
	local db = DB()
	if db.fubarMigrated then
		return
	end
	db.fubarMigrated = true
	local profiles = type(BigWigsFubarDB) == "table" and BigWigsFubarDB.profiles
	local old = type(profiles) == "table" and profiles.Default
	if type(old) ~= "table" then
		return
	end
	if old.minimapPosition and not db.minimapPosition then
		db.minimapPosition = old.minimapPosition
	end
	if old.hidden then
		db.minimapbutton = false
	end
end

-- /bw on its own opens the options; anything typed after it is still AceConsole's
local function HookSlashCommand()
	for key, handler in pairs(SlashCmdList) do
		if getglobal("SLASH_" .. key .. "1") == "/bw" then
			local original = handler
			SlashCmdList[key] = function(msg)
				if not msg or string.gsub(msg, "%s", "") == "" then
					BigWigsOptions:Open()
				else
					original(msg)
				end
			end
			return
		end
	end
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
	this:UnregisterEvent("PLAYER_LOGIN")
	if BIGWIGS_CLASSICAPI_MISSING or not Kit then
		return
	end
	BigWigsOptions:RegisterEvent("BigWigs_CoreEnabled", "CoreState")
	BigWigsOptions:RegisterEvent("BigWigs_CoreDisabled", "CoreState")

	local ok, err = pcall(MigrateFuBarSettings)
	if not ok then
		geterrorhandler()(err)
	end
	ok, err = pcall(BigWigsOptions.UpdateMinimapButton, BigWigsOptions)
	if not ok then
		geterrorhandler()(err)
	end
	HookSlashCommand()
	-- last, so an error in the pages can't stop anything else
	ok, err = pcall(BuildPages)
	if not ok then
		geterrorhandler()(err)
	end
end)
