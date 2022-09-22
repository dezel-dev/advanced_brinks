ESX.RegisterUsableItem("money_bag", function(playerSrc)
	TriggerClientEvent("brinks:money_bag", playerSrc)
end)

RegisterNetEvent("brinks_activtiy:give_bag", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	--if (xPlayer.canCarryItem("money_bag", 1)) then
		xPlayer.addInventoryItem("money_bag", 1)
	--else
		--TriggerClientEvent("esx:showNotification", _src, "~r~Vous n'avez pas assez de place sur vous pour prendre le sac d'argent !")
	--end
end)

RegisterNetEvent("brinks_activity:remove_bag", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	xPlayer.removeInventoryItem("money_bag", 1)
end)

RegisterNetEvent("brinks_activity:bag_reward", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local bagCount = xPlayer.getInventoryItem("money_bag").count
	if (bagCount ~= 0) then
		local total = bagCount * Config.Reward.Money
		xPlayer.addMoney(total)
		xPlayer.removeInventoryItem("money_bag", bagCount)
	end
end)