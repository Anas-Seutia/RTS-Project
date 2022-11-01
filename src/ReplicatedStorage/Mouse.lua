local UserInputService = game:GetService("UserInputService")

local MAX_DISTANCE : number = 500 

local Camera = workspace.CurrentCamera

local Mouse = {}

function Mouse.Origin()
	return Camera.CFrame
end

function Mouse.ViewSizeX()
	return Camera.ViewportSize.X
end

function Mouse.ViewSizeY()
	return Camera.ViewportSize.Y
end

function Mouse.X()
	return UserInputService:GetMouseLocation().X
end

function Mouse.Y()
	return UserInputService:GetMouseLocation().Y
end

function Mouse.UnitRay()
	return Camera:ViewportPointToRay(Mouse.X(), Mouse.Y())
end

function Mouse.GetRaycast(Params)
	local ray = Mouse.UnitRay()
	local result = workspace:Raycast(ray.Origin, ray.Direction * MAX_DISTANCE, Params)
	return result, ray
end

function Mouse.Hit(Params)
	local result, ray = Mouse.GetRaycast()
	if result then
		return result
	elseif ray then
		return ray.Origin, ray.Direction * MAX_DISTANCE
	end
end

function Mouse.Target(Params)
	local result, ray = Mouse.GetRaycast()
	return result and result.Instance
end

return Mouse