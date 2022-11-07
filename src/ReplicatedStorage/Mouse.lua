local UserInputService = game:GetService("UserInputService")

local MAX_DISTANCE:number = 500 

local Camera = workspace.CurrentCamera

local Mouse = {}

function Mouse.Origin():CFrame --mouse origin/camera origin
	return Camera.CFrame
end

function Mouse.ViewSize():Vector2 --screen x,y size
	return Camera.ViewportSize
end

function Mouse.ViewSizeX():number --screen x size
	return Mouse.ViewSize().X
end

function Mouse.ViewSizeY():number --screen y size
	return Mouse.ViewSize().Y
end

function Mouse.screenLocation():Vector2 --mouse on screen location
	return UserInputService:GetMouseLocation()
end

function Mouse.X():number --mouse x screen location
	return Mouse.screenLocation().X
end

function Mouse.Y():number --mouse y screen location
	return Mouse.screenLocation().Y
end

function Mouse.UnitRay()
	return Camera:ViewportPointToRay(Mouse.X(), Mouse.Y()) --get unit ray
end

function Mouse.GetRaycast(Params)
	local ray = Mouse.UnitRay()
	local result = workspace:Raycast(ray.Origin, ray.Direction * MAX_DISTANCE, Params)
	return result, ray
end

function Mouse.Hit(Params) --gets hit
	local result, ray = Mouse.GetRaycast()
	if result then
		return result
	elseif ray then
		return ray.Origin, ray.Direction * MAX_DISTANCE
	end
end

function Mouse.Target(Params) --gets hit object
	local result, ray = Mouse.GetRaycast()
	return result and result.Instance
end

return Mouse