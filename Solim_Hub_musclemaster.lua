--// SOLIM HUB (LEGIT ROBLOX VERSION)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local KEY = "solimontop"

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SOLIM_HUB"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.9,0,0.6,0)
frame.Position = UDim2.new(0.05,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(60,0,120)
frame.Parent = gui
Instance.new("UICorner", frame)

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.12,0)
title.BackgroundTransparency = 1
title.Text = "💜 SOLIM HUB"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- KEY UI
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1,0,1,0)
keyFrame.BackgroundColor3 = Color3.fromRGB(40,0,90)
keyFrame.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.8,0,0.12,0)
box.Position = UDim2.new(0.1,0,0.4,0)
box.PlaceholderText = "Enter Key"
box.TextScaled = true
box.Parent = keyFrame
Instance.new("UICorner", box)

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8,0,0.12,0)
button.Position = UDim2.new(0.1,0,0.55,0)
button.Text = "UNLOCK"
button.TextScaled = true
button.Parent = keyFrame
Instance.new("UICorner", button)

-- HUB CONTENT
local hub = Instance.new("Frame")
hub.Size = UDim2.new(1,0,1,0)
hub.BackgroundTransparency = 1
hub.Visible = false
hub.Parent = frame

-- BUTTONS
local function createButton(text, posY, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.8,0,0.1,0)
	b.Position = UDim2.new(0.1,0,posY,0)
	b.Text = text
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(140,0,255)
	b.TextColor3 = Color3.new(1,1,1)
	b.Parent = hub
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(callback)
end

local AutoTrain = false
local AutoRebirth = false

createButton("AUTO TRAIN", 0.2, function()
	AutoTrain = not AutoTrain
end)

createButton("AUTO REBIRTH", 0.35, function()
	AutoRebirth = not AutoRebirth
end)

createButton("TRAIN +5", 0.5, function()
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		stats.Strength.Value += 5
	end
end)

createButton("COINS +10", 0.65, function()
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		stats.Coins.Value += 10
	end
end)

-- KEY CHECK
button.MouseButton1Click:Connect(function()
	if box.Text == KEY then
		keyFrame.Visible = false
		hub.Visible = true
	else
		box.Text = "WRONG KEY"
	end
end)

-- LOOP
task.spawn(function()
	while true do
		task.wait(1)

		local stats = player:FindFirstChild("leaderstats")
		if stats then
			if AutoTrain then
				stats.Strength.Value += 1
			end

			if AutoRebirth and stats.Strength.Value >= 100 then
				stats.Strength.Value = 0
				stats.Rebirths.Value += 1
			end
		end
	end
end)
