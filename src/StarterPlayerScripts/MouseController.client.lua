local Players = game:GetService("Players")
local player = Players.LocalPlayer

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local mouse = require(game.ReplicatedStorage.Mouse)
local controlling = false

local plrUnits = workspace["Game Units"]:WaitForChild(player.name .. "'s Units"):GetChildren()

local Selected = {}

local params = {IgnoreWater=true, FilterDescendantsInstances={}}

UserInputService.InputBegan:Connect(function(input, processed)
	if input.UserInputType == Enum.KeyCode.LeftControl then
		controlling = true
	end
end)

UserInputService.InputEnded:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		for i, v in Selected do
			print(v)
		end
		if not controlling then
			table.clear(Selected)
		end
		local hitTarget = mouse.Target(params)
		local unit = hitTarget:FindFirstAncestorWhichIsA("Folder")
		table.insert(Selected, unit)
	end
	if input.UserInputType == Enum.KeyCode.LeftControl then
		controlling = false
	end
end)