function _BrinksActivity:loadActivityBlips()
	for _, v in pairs(Config.Interaction.InActivity) do
		local blip = AddBlipForCoord(v.coords)
		SetBlipScale(blip, v.Blips.scale)
		SetBlipSprite(blip, v.Blips.id)
		SetBlipColour(blip, v.Blips.color)
		SetBlipAlpha(blip, 255)
		AddTextEntry(GetHashKey(v.Blips.name), v.Blips.name)
		BeginTextCommandSetBlipName(GetHashKey(v.Blips.name))
		SetBlipCategory(blip, 2)
		EndTextCommandSetBlipName(blip)
		table.insert(_BrinksActivity.Blips, blip)
	end
end

AddEventHandler("player:activity:start", function()
	_BrinksActivity.Blips = {}
	ESX.ShowNotification("~g~Vous avez commencé l'activité de Brinks!")
	_BrinksActivity:loadActivityBlips()
end)