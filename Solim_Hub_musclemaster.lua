--// MUSCLE MASTER SIMULATOR CORE (FULL VERSION)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DataStoreService = game:GetService("DataStoreService")

local DS = DataStoreService:GetDataStore("MuscleMaster_FULL_V2")

--////////////////////////////
--// PLAYER SETUP
--////////////////////////////

Players.PlayerAdded:Connect(function(plr)

	local stats = Instance.new("Folder")
	stats.Name = "leaderstats"
	stats.Parent = plr

	local Strength = Instance.new("IntValue")
	Strength.Name = "Strength"
	Strength.Parent = stats

	local Coins = Instance.new("IntValue")
	Coins.Name = "Coins"
	Coins.Parent = stats

	local Rebirths = Instance.new("IntValue")
	Rebirths.Name = "Rebirths"
	Rebirths.Parent = stats

	local Multiplier = Instance.new("NumberValue")
	Multiplier.Name = "Multiplier"
	Multiplier.Value = 1
	Multiplier.Parent = plr

	local Pets = Instance.new("StringValue")
	Pets.Name = "EquippedPet"
	Pets.Value = "None"
	Pets.Parent = plr

	local data = DS:GetAsync(plr.UserId)
	if data then
		Strength.Value = data.Strength or 0
		Coins.Value = data.Coins or 0
		Rebirths.Value = data.Rebirths or 0
	end
end)

Players.PlayerRemoving:Connect(function(plr)
	local stats = plr:FindFirstChild("leaderstats")
	if stats then
		DS:SetAsync(plr.UserId,{
			Strength = stats.Strength.Value,
			Coins = stats.Coins.Value,
			Rebirths = stats.Rebirths.Value
		})
	end
end)

--////////////////////////////
--// PET SYSTEM
--////////////////////////////

local Pets = {
	Dog = 1.5,
	Wolf = 2,
	Dragon = 5,
	Angel = 10
}

local function ApplyPet(plr)
	local pet = plr.EquippedPet.Value
	local mult = Pets[pet] or 1
	plr.Multiplier.Value = mult
end

--////////////////////////////
--// TRAINING SYSTEM
--////////////////////////////

local function Train(plr, amount)
	local stats = plr.leaderstats
	local mult = plr.Multiplier.Value

	stats.Strength.Value += amount * mult
	stats.Coins.Value += math.floor(amount / 2)
end

--////////////////////////////
--// AUTO TRAIN SYSTEM
--////////////////////////////

RunService.Heartbeat:Connect(function()
	for _,plr in pairs(Players:GetPlayers()) do
		if plr:GetAttribute("AutoTrain") then
			Train(plr, 1)
		end
	end
end)

--////////////////////////////
--// REBIRTH SYSTEM
--////////////////////////////

local function Rebirth(plr)
	local stats = plr.leaderstats

	if stats.Strength.Value >= 1000 then
		stats.Strength.Value = 0
		stats.Coins.Value += 500
		stats.Rebirths.Value += 1
		plr.Multiplier.Value += 0.5
	end
end

--////////////////////////////
--// SHOP SYSTEM
--////////////////////////////

local function BuyBoost(plr)
	local stats = plr.leaderstats

	if stats.Coins.Value >= 100 then
		stats.Coins.Value -= 100
		plr.Multiplier.Value += 0.2
	end
end

--////////////////////////////
--// TELEPORT SYSTEM
--////////////////////////////

local Teleports = {
	Gym = CFrame.new(0,10,0),
	City = CFrame.new(200,10,0),
	Island = CFrame.new(-200,10,0)
}

local function Teleport(plr, place)
	if plr.Character and Teleports[place] then
		plr.Character.HumanoidRootPart.CFrame = Teleports[place]
	end
end

--////////////////////////////
--// PUBLIC API (FOR YOUR GUI)
--////////////////////////////

_G.MuscleMaster = {
	Train = Train,
	Rebirth = Rebirth,
	BuyBoost = BuyBoost,
	Teleport = Teleport,
	ApplyPet = ApplyPet
}
