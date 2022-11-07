local CollectionService = game:GetService("CollectionService")

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
		local unit:Model = unit[name].Squad:Clone()
		CollectionService:AddTag(unit, player.name .. "'s Units")
		for _, value in pairs(unit:GetChildren()) do
			CollectionService:AddTag(value, player.name .. "'s Unit")
			CollectionService:AddTag(value.HumanoidRootPart, player.name .. "'s Unit Rootpart")
		end
		unit.Name = name
		unit.Parent = workspace["Game Units"][player.name .. "'s Units"]
	end
end

return unit