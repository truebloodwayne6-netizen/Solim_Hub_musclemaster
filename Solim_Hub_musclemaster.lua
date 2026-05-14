--// SOLIM HUB - MOBILE UI + KEY SYSTEM

local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// KEY
local CORRECT_KEY = "solimontop"

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SOLIM_HUB"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

--// MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.9, 0, 0.6, 0)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
frame.Parent = gui
Instance.new("UICorner", frame)

--// TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.12, 0)
title.BackgroundTransparency = 1
title.Text = "💜 SOLIM HUB"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

--// KEY FRAME (LOCK SCREEN)
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(1,0,1,0)
keyFrame.BackgroundColor3 = Color3.fromRGB(40,0,90)
keyFrame.Parent = frame
Instance.new("UICorner", keyFrame)

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1,0,0.2,0)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "🔐 ENTER KEY"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.TextScaled = true
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0.12,0)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.PlaceholderText = "Enter Key..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.BackgroundColor3 = Color3.fromRGB(140,0,255)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.Parent = keyFrame
Instance.new("UICorner", keyBox)

local unlock = Instance.new("TextButton")
unlock.Size = UDim2.new(0.8,0,0.12,0)
unlock.Position = UDim2.new(0.1,0,0.55,0)
unlock.Text = "UNLOCK"
unlock.TextScaled = true
unlock.BackgroundColor3 = Color3.fromRGB(180,0,255)
unlock.TextColor3 = Color3.new(1,1,1)
unlock.Parent = keyFrame
Instance.new("UICorner", unlock)

--// HUB CONTENT (hidden until unlocked)
local hub = Instance.new("Frame")
hub.Size = UDim2.new(1,0,1,0)
hub.BackgroundTransparency = 1
hub.Visible = false
hub.Parent = frame

--// BUTTON AREA
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-20,0.85,-10)
scroll.Position = UDim2.new(0,10,0.12,5)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.CanvasSize = UDim2.new(0,0,2,0)
scroll.Parent = hub

local y = 0

local function Button(text, callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,-10,0,60)
	b.Position = UDim2.new(0,5,0,y)
	b.BackgroundColor3 = Color3.fromRGB(140,0,255)
	b.TextColor3 = Color3.new(1,1,1)
	b.TextScaled = true
	b.Text = text
	b.Parent = scroll
	Instance.new("UICorner", b)

	b.MouseButton1Click:Connect(callback)

	y += 70
end

--// SYSTEMS
local AutoTrain = false
local AutoRebirth = false

Button("💪 AUTO TRAIN", function()
	AutoTrain = not AutoTrain
end)

Button("🔁 AUTO REBIRTH", function()
	AutoRebirth = not AutoRebirth
end)

Button("🏋️ TRAIN +5", function()
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		stats.Strength.Value += 5
	end
end)

Button("💰 COINS +10", function()
	local stats = player:FindFirstChild("leaderstats")
	if stats then
		stats.Coins.Value += 10
	end
end)

Button("🏠 TELEPORT SPAWN", function()
	local char = player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = CFrame.new(0,10,0)
	end
end)

--// UNLOCK SYSTEM
unlock.MouseButton1Click:Connect(function()
	if keyBox.Text == CORRECT_KEY then
		keyFrame.Visible = false
		hub.Visible = true
	else
		keyBox.Text = "WRONG KEY"
	end
end)

--// LOOP
task.spawn(function()
	while true do
		task.wait(1)

		local stats = player:FindFirstChild("leaderstats")

		if AutoTrain and stats then
			stats.Strength.Value += 1
		end

		if AutoRebirth and stats and stats.Strength.Value >= 100 then
			stats.Strength.Value = 0
			stats.Rebirths.Value += 1
		end
	end
end)
