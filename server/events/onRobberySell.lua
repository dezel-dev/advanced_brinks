RegisterNetEvent("brinks:robbery:sell", function()
	local _src <const> = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local bagCount = xPlayer.getInventoryItem("money_bag_stolen").count
	if (bagCount ~= 0) then
		local total = bagCount * Config.Robbery.Price
		xPlayer.addAccountMoney("black_money", total)
		xPlayer.removeInventoryItem("money_bag_stolen", bagCount)
		TriggerClientEvent("esx:showNotification", _src, ("~g~Vous avez vendu %s sacs pour %s$"):format(bagCount, total))
	end
end)