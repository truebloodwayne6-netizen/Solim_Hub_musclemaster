local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SoilmHub"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = game.CoreGui
end)

-- OPEN BUTTON
local openButton = Instance.new("TextButton")
openButton.Parent = gui
openButton.Size = UDim2.new(0,120,0,40)
openButton.Position = UDim2.new(0,20,0.5,-20)
openButton.Text = "OPEN HUB"
openButton.BackgroundColor3 = Color3.fromRGB(120,0,255)
openButton.TextColor3 = Color3.new(1,1,1)

local openCorner = Instance.new("UICorner")
openCorner.Parent = openButton

-- MAIN HUB
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,500,0,320)
frame.Position = UDim2.new(0.5,-250,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(85,0,170)
frame.Visible = false

local corner = Instance.new("UICorner")
corner.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "SOILM MUSCLE MASTER"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

-- CLOSE BUTTON
local close = Instance.new("TextButton")
close.Parent = frame
close.Size = UDim2.new(0,40,0,40)
close.Position = UDim2.new(1,-45,0,5)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(140,0,255)
close.TextColor3 = Color3.new(1,1,1)

local closeCorner = Instance.new("UICorner")
closeCorner.Parent = close

-- CONTENT
local content = Instance.new("Frame")
content.Parent = frame
content.Size = UDim2.new(1,-20,1,-60)
content.Position = UDim2.new(0,10,0,50)
content.BackgroundColor3 = Color3.fromRGB(70,0,140)

local contentCorner = Instance.new("UICorner")
contentCorner.Parent = content

-- DRAGGING
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

title.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- OPEN/CLOSE
openButton.MouseButton1Click:Connect(function()
	frame.Visible = true
end)

close.MouseButton1Click:Connect(function()
	frame.Visible = false
end)

-- TOGGLE CREATOR
local ypos = 10

local function CreateToggle(name, callback)
	local state = false

	local btn = Instance.new("TextButton")
	btn.Parent = content
	btn.Size = UDim2.new(0,220,0,45)
	btn.Position = UDim2.new(0,10,0,ypos)
	btn.BackgroundColor3 = Color3.fromRGB(120,0,255)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Text = name .. ": OFF"
	btn.TextScaled = true

	local c = Instance.new("UICorner")
	c.Parent = btn

	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = name .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)

	ypos += 55
end

-- AUTO FARM
local AutoFarm = false

CreateToggle("AUTO FARM", function(v)
	AutoFarm = v
end)

task.spawn(function()
	while true do
		task.wait(1)

		if AutoFarm then
			print("Auto Farming...")
		end
	end
end)

-- AUTO REBIRTH
local AutoRebirth = false

CreateToggle("AUTO REBIRTH", function(v)
	AutoRebirth = v
end)

task.spawn(function()
	while true do
		task.wait(3)

		if AutoRebirth then
			print("Auto Rebirth...")
		end
	end
end)

-- PETS
CreateToggle("PETS BOOST", function(v)
	print("Pets Boost:", v)
end)
