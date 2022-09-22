MySQL.ready(function()
	MySQL.query("SELECT * FROM brinks_spawn", {}, function(rows)
		local Points = {}
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
		TriggerClientEvent("brinks:getPoints", -1, Points)
	end)
end)