local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = script.Parent

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(12, 12, 15)
local SIDEBAR = Color3.fromRGB(16, 16, 20)
local PANEL = Color3.fromRGB(20, 20, 25)
local PANEL2 = Color3.fromRGB(25, 25, 31)
local BORDER = Color3.fromRGB(38, 38, 45)
local TEXT = Color3.fromRGB(235, 235, 240)
local SUBTEXT = Color3.fromRGB(135, 135, 145)
local ACCENT = Color3.fromRGB(125, 95, 255)

gui.ResetOnSpawn = false

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Ghost"
Main.Size = UDim2.new(0, 720, 0, 470)
Main.Position = UDim2.new(0.5, -360, 0.5, -235)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Parent = gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = BORDER
MainStroke.Thickness = 1
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 58)
Top.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = Top

local TopCover = Instance.new("Frame")
TopCover.Size = UDim2.new(1, 0, 0, 12)
TopCover.Position = UDim2.new(0, 0, 1, -12)
TopCover.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
TopCover.BorderSizePixel = 0
TopCover.Parent = Top

--==================================================
-- LOGO
--==================================================

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 100, 0, 30)
Logo.Position = UDim2.new(0, 22, 0, 7)
Logo.BackgroundTransparency = 1
Logo.Text = "GHOST"
Logo.TextColor3 = TEXT
Logo.TextSize = 21
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = Top

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 50, 0, 20)
Version.Position = UDim2.new(0, 84, 0, 27)
Version.BackgroundTransparency = 1
Version.Text = "v2.0"
Version.TextColor3 = SUBTEXT
Version.TextSize = 10
Version.Font = Enum.Font.GothamMedium
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Top

--==================================================
-- WINDOW BUTTONS
--==================================================

local function createWindowButton(text, position)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(0, 35, 0, 35)
	button.Position = position
	button.BackgroundTransparency = 1
	button.Text = text
	button.TextColor3 = SUBTEXT
	button.TextSize = 16
	button.Font = Enum.Font.GothamMedium
	button.AutoButtonColor = false
	button.Parent = Top

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				TextColor3 = TEXT
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				TextColor3 = SUBTEXT
			}
		):Play()

	end)

	return button
end

local Minimize = createWindowButton(
	"—",
	UDim2.new(1, -105, 0, 11)
)

local Maximize = createWindowButton(
	"□",
	UDim2.new(1, -70, 0, 11)
)

local Close = createWindowButton(
	"×",
	UDim2.new(1, -35, 0, 11)
)

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

Minimize.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

Maximize.MouseButton1Click:Connect(function()

	if Main.Size.X.Offset == 720 then

		Main.Size = UDim2.new(0, 850, 0, 550)
		Main.Position = UDim2.new(0.5, -425, 0.5, -275)

	else

		Main.Size = UDim2.new(0, 720, 0, 470)
		Main.Position = UDim2.new(0.5, -360, 0.5, -235)

	end

end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 165, 1, -58)
Sidebar.Position = UDim2.new(0, 0, 0, 58)
Sidebar.BackgroundColor3 = SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Size = UDim2.new(1, -30, 0, 30)
MenuTitle.Position = UDim2.new(0, 18, 0, 18)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "MENU"
MenuTitle.TextColor3 = SUBTEXT
MenuTitle.TextSize = 10
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -165, 1, -58)
Content.Position = UDim2.new(0, 165, 0, 58)
Content.BackgroundColor3 = BG
Content.BorderSizePixel = 0
Content.Parent = Main

local Pages = {}

--==================================================
-- PAGE CREATOR
--==================================================

local function createPage(name)

	local page = Instance.new("ScrollingFrame")

	page.Name = name
	page.Size = UDim2.new(1, -45, 1, -40)
	page.Position = UDim2.new(0, 25, 0, 20)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 2
	page.ScrollBarImageColor3 = BORDER
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false
	page.Parent = Content

	local layout = Instance.new("UIListLayout")

	layout.Padding = UDim.new(0, 12)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = page

	local padding = Instance.new("UIPadding")

	padding.PaddingBottom = UDim.new(0, 15)
	padding.Parent = page

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

		page.CanvasSize = UDim2.new(
			0,
			0,
			0,
			layout.AbsoluteContentSize.Y + 20
		)

	end)

	Pages[name] = page

	return page
end

--==================================================
-- HEADER
--==================================================

local function createHeader(page, title, description)

	local holder = Instance.new("Frame")

	holder.Size = UDim2.new(1, 0, 0, 55)
	holder.BackgroundTransparency = 1
	holder.Parent = page

	local titleLabel = Instance.new("TextLabel")

	titleLabel.Size = UDim2.new(1, 0, 0, 28)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = TEXT
	titleLabel.TextSize = 20
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = holder

	local descriptionLabel = Instance.new("TextLabel")

	descriptionLabel.Size = UDim2.new(1, 0, 0, 20)
	descriptionLabel.Position = UDim2.new(0, 0, 0, 29)
	descriptionLabel.BackgroundTransparency = 1
	descriptionLabel.Text = description
	descriptionLabel.TextColor3 = SUBTEXT
	descriptionLabel.TextSize = 11
	descriptionLabel.Font = Enum.Font.Gotham
	descriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
	descriptionLabel.Parent = holder

end

--==================================================
-- SECTION
--==================================================

local function createSection(page, title)

	local section = Instance.new("Frame")

	section.Size = UDim2.new(1, 0, 0, 30)
	section.BackgroundTransparency = 1
	section.Parent = page

	local label = Instance.new("TextLabel")

	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = title:upper()
	label.TextColor3 = SUBTEXT
	label.TextSize = 10
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = section

	return section
end

--==================================================
-- TOGGLE
--==================================================

local function createToggle(page, name, default)

	local row = Instance.new("Frame")

	row.Size = UDim2.new(1, 0, 0, 50)
	row.BackgroundColor3 = PANEL
	row.BorderSizePixel = 0
	row.Parent = page

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = row

	local stroke = Instance.new("UIStroke")

	stroke.Color = BORDER
	stroke.Thickness = 1
	stroke.Transparency = 0.4
	stroke.Parent = row

	local label = Instance.new("TextLabel")

	label.Size = UDim2.new(1, -80, 1, 0)
	label.Position = UDim2.new(0, 15, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = TEXT
	label.TextSize = 13
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row

	local switch = Instance.new("TextButton")

	switch.Size = UDim2.new(0, 42, 0, 22)
	switch.Position = UDim2.new(1, -57, 0.5, -11)
	switch.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
	switch.Text = ""
	switch.AutoButtonColor = false
	switch.Parent = row

	local switchCorner = Instance.new("UICorner")

	switchCorner.CornerRadius = UDim.new(1, 0)
	switchCorner.Parent = switch

	local circle = Instance.new("Frame")

	circle.Size = UDim2.new(0, 16, 0, 16)
	circle.Position = UDim2.new(0, 3, 0.5, -8)
	circle.BackgroundColor3 = Color3.fromRGB(150, 150, 155)
	circle.BorderSizePixel = 0
	circle.Parent = switch

	local circleCorner = Instance.new("UICorner")

	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = circle

	local enabled = default == true

	local function update()

		if enabled then

			TweenService:Create(
				switch,
				TweenInfo.new(0.18),
				{
					BackgroundColor3 = ACCENT
				}
			):Play()

			TweenService:Create(
				circle,
				TweenInfo.new(0.18),
				{
					Position = UDim2.new(1, -19, 0.5, -8),
					BackgroundColor3 = Color3.new(1, 1, 1)
				}
			):Play()

		else

			TweenService:Create(
				switch,
				TweenInfo.new(0.18),
				{
					BackgroundColor3 = Color3.fromRGB(35, 35, 40)
				}
			):Play()

			TweenService:Create(
				circle,
				TweenInfo.new(0.18),
				{
					Position = UDim2.new(0, 3, 0.5, -8),
					BackgroundColor3 = Color3.fromRGB(150, 150, 155)
				}
			):Play()

		end

	end

	switch.MouseButton1Click:Connect(function()

		enabled = not enabled
		update()

	end)

	update()

	return row
end

--==================================================
-- SLIDER
--==================================================

local function createSlider(page, name, minimum, maximum, default)

	local row = Instance.new("Frame")

	row.Size = UDim2.new(1, 0, 0, 65)
	row.BackgroundColor3 = PANEL
	row.BorderSizePixel = 0
	row.Parent = page

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = row

	local label = Instance.new("TextLabel")

	label.Size = UDim2.new(0.5, 0, 0, 25)
	label.Position = UDim2.new(0, 15, 0, 8)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = TEXT
	label.TextSize = 13
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = row

	local valueLabel = Instance.new("TextLabel")

	valueLabel.Size = UDim2.new(0, 50, 0, 25)
	valueLabel.Position = UDim2.new(1, -65, 0, 8)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.TextColor3 = SUBTEXT
	valueLabel.TextSize = 12
	valueLabel.Font = Enum.Font.GothamMedium
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = row

	local bar = Instance.new("Frame")

	bar.Size = UDim2.new(1, -30, 0, 4)
	bar.Position = UDim2.new(0, 15, 1, -16)
	bar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	bar.BorderSizePixel = 0
	bar.Parent = row

	local barCorner = Instance.new("UICorner")

	barCorner.CornerRadius = UDim.new(1, 0)
	barCorner.Parent = bar

	local percentage = (default - minimum) / (maximum - minimum)

	local fill = Instance.new("Frame")

	fill.Size = UDim2.new(percentage, 0, 1, 0)
	fill.BackgroundColor3 = ACCENT
	fill.BorderSizePixel = 0
	fill.Parent = bar

	local fillCorner = Instance.new("UICorner")

	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = fill

	local knob = Instance.new("Frame")

	knob.Size = UDim2.new(0, 12, 0, 12)
	knob.Position = UDim2.new(percentage, -6, 0.5, -6)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	knob.Parent = bar

	local knobCorner = Instance.new("UICorner")

	knobCorner.CornerRadius = UDim.new(1, 0)
	knobCorner.Parent = knob

	-- Make slider draggable
	local draggingSlider = false

	bar.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSlider = true
		end

	end)

	UserInputService.InputEnded:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSlider = false
		end

	end)

	UserInputService.InputChanged:Connect(function(input)

		if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then

			local mouseX = input.Position.X
			local barStart = bar.AbsolutePosition.X
			local barWidth = bar.AbsoluteSize.X

			local percent = math.clamp(
				(mouseX - barStart) / barWidth,
				0,
				1
			)

			local value = math.floor(
				minimum + ((maximum - minimum) * percent)
			)

			valueLabel.Text = tostring(value)

			fill.Size = UDim2.new(
				percent,
				0,
				1,
				0
			)

			knob.Position = UDim2.new(
				percent,
				-6,
				0.5,
				-6
			)

		end

	end)

end

--==================================================
-- ACTION BUTTON
--==================================================

local function createActionButton(page, text)

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, 0, 0, 46)
	button.BackgroundColor3 = PANEL
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = TEXT
	button.TextSize = 12
	button.Font = Enum.Font.GothamMedium
	button.AutoButtonColor = false
	button.Parent = page

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")

	stroke.Color = BORDER
	stroke.Thickness = 1
	stroke.Transparency = 0.4
	stroke.Parent = button

	button.MouseEnter:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = PANEL2
			}
		):Play()

	end)

	button.MouseLeave:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.15),
			{
				BackgroundColor3 = PANEL
			}
		):Play()

	end)

	return button
end

--==================================================
-- COMBAT
--==================================================

local Combat = createPage("Combat")

createHeader(
	Combat,
	"Combat",
	"Practice controls and combat settings"
)

createSection(
	Combat,
	"Practice"
)

createToggle(
	Combat,
	"Auto Parry",
	false
)

createToggle(
	Combat,
	"Prediction",
	false
)

createSlider(
	Combat,
	"Parry Range",
	1,
	100,
	50
)

createSection(
	Combat,
	"Indicators"
)

createToggle(
	Combat,
	"Visual Indicator",
	true
)

--==================================================
-- VISUALS
--==================================================

local Visuals = createPage("Visuals")

createHeader(
	Visuals,
	"Visuals",
	"Customize visual indicators"
)

createSection(
	Visuals,
	"Indicators"
)

createToggle(
	Visuals,
	"Ball Indicator",
	true
)

createToggle(
	Visuals,
	"Target Highlight",
	false
)

createToggle(
	Visuals,
	"Trajectory",
	false
)

--==================================================
-- PLAYER
--==================================================

local Player = createPage("Player")

createHeader(
	Player,
	"Player",
	"Player-related practice settings"
)

createSection(
	Player,
	"Movement"
)

createToggle(
	Player,
	"Speed Preview",
	false
)

createToggle(
	Player,
	"Jump Preview",
	false
)

createSlider(
	Player,
	"Preview Speed",
	1,
	100,
	50
)

--==================================================
-- MISC
--==================================================

local Misc = createPage("Misc")

createHeader(
	Misc,
	"Misc",
	"Extra interface and utility options"
)

createSection(
	Misc,
	"Interface"
)

createToggle(
	Misc,
	"Notifications",
	true
)

createToggle(
	Misc,
	"Sound Effects",
	true
)

createToggle(
	Misc,
	"UI Animations",
	true
)

createToggle(
	Misc,
	"Performance Mode",
	false
)

createSection(
	Misc,
	"Utilities"
)

local ResetPosition = createActionButton(
	Misc,
	"Reset UI Position"
)

ResetPosition.MouseButton1Click:Connect(function()

	Main.Position = UDim2.new(
		0.5,
		-360,
		0.5,
		-235
	)

end)

local ResetInterface = createActionButton(
	Misc,
	"Reset Interface"
)

ResetInterface.MouseButton1Click:Connect(function()

	Main.Visible = true

end)

--==================================================
-- SETTINGS
--==================================================

local Settings = createPage("Settings")

createHeader(
	Settings,
	"Settings",
	"Customize your GHOST interface"
)

createSection(
	Settings,
	"Appearance"
)

createSlider(
	Settings,
	"UI Scale",
	80,
	120,
	100
)

createToggle(
	Settings,
	"Show Keybinds",
	true
)

createToggle(
	Settings,
	"UI Animations",
	true
)

createSection(
	Settings,
	"Controls"
)

local KeybindRow = Instance.new("Frame")

KeybindRow.Size = UDim2.new(1, 0, 0, 50)
KeybindRow.BackgroundColor3 = PANEL
KeybindRow.BorderSizePixel = 0
KeybindRow.Parent = Settings

local KeybindCorner = Instance.new("UICorner")

KeybindCorner.CornerRadius = UDim.new(0, 7)
KeybindCorner.Parent = KeybindRow

local KeybindLabel = Instance.new("TextLabel")

KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
KeybindLabel.Position = UDim2.new(0, 15, 0, 0)
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.Text = "Open / Close UI"
KeybindLabel.TextColor3 = TEXT
KeybindLabel.TextSize = 13
KeybindLabel.Font = Enum.Font.GothamMedium
KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
KeybindLabel.Parent = KeybindRow

local Keybind = Instance.new("TextButton")

Keybind.Size = UDim2.new(0, 90, 0, 28)
Keybind.Position = UDim2.new(1, -105, 0.5, -14)
Keybind.BackgroundColor3 = PANEL2
Keybind.BorderSizePixel = 0
Keybind.Text = "RightShift"
Keybind.TextColor3 = TEXT
Keybind.TextSize = 11
Keybind.Font = Enum.Font.GothamMedium
Keybind.AutoButtonColor = false
Keybind.Parent = KeybindRow

local KeyCorner = Instance.new("UICorner")

KeyCorner.CornerRadius = UDim.new(0, 6)
KeyCorner.Parent = Keybind

createSection(
	Settings,
	"Reset"
)

local ResetSettings = createActionButton(
	Settings,
	"Reset Settings"
)

ResetSettings.MouseButton1Click:Connect(function()

	Main.Position = UDim2.new(
		0.5,
		-360,
		0.5,
		-235
	)

	Main.Size = UDim2.new(
		0,
		720,
		0,
		470
	)

end)

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local tabs = {
	"Combat",
	"Visuals",
	"Player",
	"Misc",
	"Settings"
}

local tabButtons = {}

local function selectTab(name)

	for tabName, button in pairs(tabButtons) do

		if tabName == name then

			TweenService:Create(
				button,
				TweenInfo.new(0.15),
				{
					BackgroundColor3 = PANEL2,
					TextColor3 = TEXT
				}
			):Play()

		else

			TweenService:Create(
				button,
				TweenInfo.new(0.15),
				{
					BackgroundColor3 = SIDEBAR,
					TextColor3 = SUBTEXT
				}
			):Play()

		end

	end

	for pageName, page in pairs(Pages) do

		page.Visible = pageName == name

	end

end

for i, name in ipairs(tabs) do

	local button = Instance.new("TextButton")

	button.Size = UDim2.new(1, -24, 0, 42)
	button.Position = UDim2.new(
		0,
		12,
		0,
		55 + ((i - 1) * 46)
	)

	button.BackgroundColor3 = SIDEBAR
	button.BorderSizePixel = 0
	button.Text = "   " .. name
	button.TextColor3 = SUBTEXT
	button.TextSize = 12
	button.Font = Enum.Font.GothamMedium
	button.TextXAlignment = Enum.TextXAlignment.Left
	button.AutoButtonColor = false
	button.Parent = Sidebar

	local corner = Instance.new("UICorner")

	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = button

	tabButtons[name] = button

	button.MouseButton1Click:Connect(function()

		selectTab(name)

	end)

end

--==================================================
-- DEFAULT PAGE
--==================================================

selectTab("Combat")

--==================================================
-- DRAG WINDOW
--==================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position

	end

end)

Top.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end

end)

--==================================================
-- RIGHT SHIFT TO OPEN/CLOSE
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then

		Main.Visible = not Main.Visible

	end

end)

print("GHOST UI v2 loaded")
