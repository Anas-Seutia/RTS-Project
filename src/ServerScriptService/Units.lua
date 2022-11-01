local models = game.ServerStorage.unitModels

local unit = {
	["Engineers"] = {
		["Name"] = "",
		["Cost"] = 0,
		["Health"] = 75,
		["Squad"] = models.Engineers
	},
	["Medics"] = {
		["Name"] = "",
		["Cost"] = 0,
		["Health"] = 75,
		["Squad"] = models.Medics
	},
	["Soldiers"] = {
		["Name"] = "",
		["Cost"] = 0,
		["Health"] = 75,
		["Squad"] = models.Soldiers
	}
}

function unit.Spawn(name, player)
	if unit[name] then
		local unit = unit[name].Squad:Clone()
		unit.Name = name
		unit.Parent = workspace["Game Units"][player.name .. "'s Units"]
	end
end

return unit