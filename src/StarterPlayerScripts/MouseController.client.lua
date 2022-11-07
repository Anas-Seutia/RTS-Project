---@diagnostic disable: trailing-space
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")
local selectGui:ScreenGui = playerGui:WaitForChild("SelectGui")

local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local gameUI:Folder = ReplicatedStorage.gameUI
local selectUI:Frame = gameUI.selectFrame

local camera = workspace.CurrentCamera
local mouse = require(game.ReplicatedStorage.Mouse)
local controlling = false

local Selected:table = {}
local Selecting:boolean
local point1:Vector2
local point2:Vector2

local params = {IgnoreWater=true, FilterDescendantsInstances={}}



UserInputService.InputBegan:Connect(function(input, _)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then --Mouse1 down
		Selecting = true

		local selectBox = selectUI:Clone()
		selectBox.Parent = selectGui

		point1 = Vector2.new(mouse.X(), mouse.Y())
		selectBox.Position = UDim2.fromOffset(point1.X, point1.Y) - UDim2.fromOffset(0, 36)
		while Selecting do
			point2 = Vector2.new(mouse.X(), mouse.Y())
			selectBox.Size = UDim2.fromOffset(point2.X, point2.Y) - selectBox.Position - UDim2.fromOffset(0, 36)
			task.wait()
		end
		selectBox:Destroy()

	end

	if input.UserInputType == Enum.KeyCode.LeftControl then --LController down
		controlling = true
	end

end)

UserInputService.InputEnded:Connect(function(input, _)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then --Mouse1 up
		Selecting = false

		if not controlling then --if player didn't down controller
			table.clear(Selected) --empty selection
		end

		point1, point2 = Vector2.new(math.min(point1.X, point2.X), math.min(point1.Y, point2.Y)), Vector2.new(math.max(point1.X, point2.X), math.max(point1.Y, point2.Y))

		for _, v:Part in pairs(CollectionService:GetTagged(player.name .. "'s Unit Rootpart")) do --loop every singular unit
			local point3 = camera:WorldToViewportPoint(v.Position) --get rootpart world position to screen position

			if point3.Z > 0 and (point1.Y < point3.Y and point3.Y < point2.Y) and (point1.X < point3.X and point3.X < point2.X) and not table.find(Selected, v.Parent.Parent) then --check rootpart is inside the points
				table.insert(Selected, v.Parent.Parent)
			end
		end
		
		local hitTarget = mouse.Target(params)

		if CollectionService:HasTag(hitTarget.Parent, player.name .. "'s Unit") and not table.find(Selected, hitTarget.Parent.Parent) then
			table.insert(Selected, hitTarget.Parent.Parent)
		end

		for _, v in Selected do
			print(v)
		end

	end

	if input.UserInputType == Enum.KeyCode.LeftControl then --LController up
		controlling = false
	end

end)