local players = game:GetService("Players")

players.PlayerAdded:Connect(function(player)
	local playerunitFolder = Instance.new("Folder")
	playerunitFolder.Parent = workspace["Game Units"]
	playerunitFolder.Name = player.Name .. "'s Units"
	
	require(game.ServerScriptService.Units).Spawn("Medics", player) --spawn medic
	task.wait(1)
	require(game.ServerScriptService.Units).Spawn("Engineers", player) --spawn engineers
	task.wait(1)
	require(game.ServerScriptService.Units).Spawn("Soldiers", player) --spawn soldiers
end)

