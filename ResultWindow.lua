--[[
BigWigs result window: a small movable list window, used by the version check and the resistance
check in place of Tablet-2.0 and Dewdrop-2.0.

It keeps Tablet's way of adding lines, so the checks build their lists as before:

	local window = BigWigs:NewResultWindow("Title", { {text = "Button", tooltip = "...", func = fn}, ... })
	window:Clear()
	local cat = window:AddCategory("columns", 2, "text", "Player", "text2", "Version")
	cat:AddLine("text", name, "text2", version)
	window:SetHint("Green versions are newer than yours.")
	window:Render()
	window:Show()

The action buttons replace Tablet's right-click menu; the close button and Escape close it.
Lua 5.0 (WoW 1.12): scripts use `this`, and varargs arrive as the `arg` table.
]]

local WIDTH = 320
local HEIGHT = 380
local LINE_HEIGHT = 14
local count = 0

local Window = {}

-- "key", value, "key", value ... -> {key = value}
local function Pairs(list)
	local t = {}
	for i = 1, table.getn(list), 2 do
		t[list[i]] = list[i + 1]
	end
	return t
end

local function Text(value)
	if value == nil then
		return ""
	end
	return tostring(value)
end

local function AddLine(cat, ...)
	local o = Pairs(arg)
	table.insert(cat.rows, { Text(o.text), Text(o.text2) })
end

function Window:AddCategory(...)
	local o = Pairs(arg)
	local cat = { title = Text(o.text), title2 = Text(o.text2), rows = {}, AddLine = AddLine }
	table.insert(self.categories, cat)
	return cat
end

function Window:SetHint(text)
	self.hint = text
end

function Window:Clear()
	self.categories = {}
	self.hint = nil
end

local function GetLine(self, i)
	local line = self.lines[i]
	if not line then
		local left = self.child:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		left:SetJustifyH("LEFT")
		local right = self.child:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
		right:SetJustifyH("RIGHT")
		line = { left = left, right = right }
		self.lines[i] = line
	end
	return line
end

local function SetLine(self, i, y, indent, left, right, r, g, b)
	local line = GetLine(self, i)
	line.left:ClearAllPoints()
	line.left:SetPoint("TOPLEFT", self.child, "TOPLEFT", indent, y)
	line.left:SetText(left)
	line.left:SetTextColor(r, g, b)
	line.right:ClearAllPoints()
	line.right:SetPoint("TOPRIGHT", self.child, "TOPRIGHT", 0, y)
	line.right:SetText(right)
	line.right:SetTextColor(r, g, b)
	line.left:Show()
	line.right:Show()
end

-- Draws the categories added since Clear
function Window:Render()
	local n, y = 0, 0
	for _, cat in ipairs(self.categories) do
		n = n + 1
		SetLine(self, n, y, 0, cat.title, cat.title2, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		y = y - LINE_HEIGHT
		for _, row in ipairs(cat.rows) do
			n = n + 1
			SetLine(self, n, y, 8, row[1], row[2], 1, 1, 1)
			y = y - LINE_HEIGHT
		end
		y = y - 6
	end
	for i = n + 1, table.getn(self.lines) do
		self.lines[i].left:Hide()
		self.lines[i].right:Hide()
	end
	self.child:SetHeight(math.max(-y, 1))
	self.hintText:SetText(self.hint or "")
end

function Window:Show()
	self.frame:Show()
end

function Window:Hide()
	self.frame:Hide()
end

function Window:IsShown()
	return self.frame:IsShown()
end

local function Tooltip(frame, title, text)
	if not text then
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

-- title: the window heading. actions: {text, tooltip, func} buttons shown under the heading.
function BigWigs:NewResultWindow(title, actions)
	count = count + 1
	local name = "BigWigsResultWindow" .. count

	local frame = CreateFrame("Frame", name, UIParent)
	frame:SetWidth(WIDTH)
	frame:SetHeight(HEIGHT)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetFrameStrata("DIALOG")
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 },
	})
	frame:SetBackdropColor(0, 0, 0, 0.9)
	frame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function()
		this:StartMoving()
	end)
	frame:SetScript("OnDragStop", function()
		this:StopMovingOrSizing()
	end)
	frame:Hide()
	table.insert(UISpecialFrames, name) -- Escape closes it

	local heading = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	heading:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, -12)
	heading:SetText(title)

	local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -2)

	-- action buttons, wrapped into rows under the heading
	local x, y = 12, -34
	for i, action in ipairs(actions or {}) do
		local button = CreateFrame("Button", name .. "Action" .. i, frame, "UIPanelButtonTemplate")
		button:SetText(action.text)
		local width = getglobal(button:GetName() .. "Text"):GetStringWidth() + 24
		button:SetWidth(width)
		button:SetHeight(20)
		if x + width > WIDTH - 12 then
			x = 12
			y = y - 22
		end
		button:SetPoint("TOPLEFT", frame, "TOPLEFT", x, y)
		x = x + width + 4
		button:SetScript("OnClick", action.func)
		Tooltip(button, action.text, action.tooltip)
	end
	local listTop = y - 28

	local scroll = CreateFrame("ScrollFrame", name .. "Scroll", frame, "UIPanelScrollFrameTemplate")
	scroll:SetPoint("TOPLEFT", frame, "TOPLEFT", 14, listTop)
	scroll:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -32, 44)
	local child = CreateFrame("Frame", nil, scroll)
	child:SetWidth(WIDTH - 50)
	child:SetHeight(1)
	scroll:SetScrollChild(child)

	local hint = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	hint:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 14, 10)
	hint:SetWidth(WIDTH - 28)
	hint:SetHeight(30)
	hint:SetJustifyH("LEFT")
	hint:SetJustifyV("BOTTOM")
	hint:SetTextColor(0.2, 1, 0.2)

	local window = { frame = frame, child = child, hintText = hint, lines = {}, categories = {} }
	for k, v in pairs(Window) do
		window[k] = v
	end
	return window
end
