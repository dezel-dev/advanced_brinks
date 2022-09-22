RegisterNetEvent("brinks:addPoint", function(metadata)
	TriggerClientEvent("brinks:refresh_points", -1, metadata)
	MySQL.insert("INSERT INTO `brinks_spawn`(`coords_blips`, `coords_bag`) VALUES (:coords_blips,:coords_bag)", {
		coords_blips = json.encode(metadata.blipsPos),
		coords_bag = json.encode(metadata.bagPos)
	})
	print("Add new point with metadata : "..json.encode(metadata))
end)