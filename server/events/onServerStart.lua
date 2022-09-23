Points = {}

MySQL.ready(function()
	MySQL.query("SELECT * FROM brinks_spawn", {}, function(rows)
		for _, v in pairs(rows) do
			local coords = {
				blips = json.decode(v.coords_blips),
				bag = json.decode(v.coords_bag),
			}
			print("Add new point with metadata : "..json.encode(coords))
			table.insert(Points, {
				Blips = vector(coords.blips.x, coords.blips.y, coords.blips.z),
				Bag = vector(coords.bag.x, coords.bag.y, coords.bag.z),
			})
		end
	end)
end)

RegisterNetEvent("brinks:player:getPoints", function()
	TriggerClientEvent("brinks:getPoints", source, Points)
end)