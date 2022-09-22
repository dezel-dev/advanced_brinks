RegisterCommand("brinks_config", function(source)
	if (source == 0) then
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	if (Config.PermConfig[xPlayer.getGroup()]) then
		TriggerClientEvent("brinks:config_points", source)
	end
end)