RegisterNetEvent("brinks:alertPolice", function(plyCoords)
	local xPlayers = ESX.GetExtendedPlayers("job", "police")

	for _, xPlayer in pairs(xPlayers) do
		TriggerClientEvent("brinks:robberyAlert", xPlayer.source, plyCoords)
	end
end)