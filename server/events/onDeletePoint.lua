RegisterNetEvent("brinks:points:delete", function(position, points)
	TriggerClientEvent("brinks:getPoints", -1, points)
	TriggerClientEvent("esx:showNotification", source, "~r~Le point a été supprimé!")
	MySQL.query("DELETE FROM `brinks_spawn` WHERE `coords_blips` = :coords", {
		coords = json.encode(position)
	})
end)