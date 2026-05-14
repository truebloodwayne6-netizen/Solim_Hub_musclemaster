local gui = Instance.new("ScreenGui")
gui.Name = "SoilmHub"
gui.ResetOnSpawn = false
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,350,0,200)
frame.Position = UDim2.new(0.5,-175,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(120,0,255)

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "SOILM MUSCLE MASTER"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)

local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0,200,0,50)
button.Position = UDim2.new(0.5,-100,0.5,20)
button.Text = "SCRIPT LOADED"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(80,0,180)
button.TextColor3 = Color3.new(1,1,1)

local buttonCorner = Instance.new("UICorner")
buttonCorner.Parent = button
local gui = Instance.new("ScreenGui")
gui.Name = "SoilmHub"
gui.ResetOnSpawn = false

pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,350,0,200)
frame.Position = UDim2.new(0.5,-175,0.5,-100)
frame.BackgroundColor3 = Color3.fromRGB(120,0,255)

local corner = Instance.new("UICorner")
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "SOILM HUB LOADED"
title.TextScaled = true
title.TextColor3 = Color3.new(1,1,1)
