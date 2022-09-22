function _BrinksActivity:unloadActivityBlips()
	for _, v in pairs(_BrinksActivity.Blips) do
		RemoveBlip(v)
	end
end

AddEventHandler("player:activity:stop", function()
	ESX.ShowNotification("~r~Vous avez arrêté l'activité de Brinks!")
	_BrinksActivity:unloadActivityBlips()
end)