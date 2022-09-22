RegisterNetEvent("brinks:robbery:reward", function(reward)
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.addInventoryItem("money_bag_stolen", reward)
end)