_BrinksActivity.Interaction = {}

--Start/Stop activity interaction
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local dst = #(GetEntityCoords(PlayerPedId()) - Config.Interaction.StartActivity.Ped.position.coords)
		if (dst <= 1.5) then
			interval = 0
			ESX.ShowHelpNotification(not _BrinksActivity.IsInActivity and "Appuyez sur ~INPUT_CONTEXT~ pour commencer l'activité." or "Appuyez sur ~INPUT_CONTEXT~ pour arrêter l'activité.")
			if (IsControlJustPressed(0,51)) then
				if (_BrinksActivity.Vehicle ~= nil) then
					ESX.ShowNotification("~r~Veuillez ranger votre véhicule!")
				else
					_BrinksActivity.IsInActivity = not _BrinksActivity.IsInActivity
					TriggerEvent(("player:activity:%s"):format(_BrinksActivity.IsInActivity and "start" or "stop"))
				end
			end
		end

		Wait(interval)
	end
end)

--In activity interaction
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (_BrinksActivity.IsInActivity) then
			for type, v in pairs(Config.Interaction.InActivity) do
				local dst = #(GetEntityCoords(PlayerPedId()) - v.coords)
				if (dst <= 10.0) then
					interval = 0
					DrawMarker(v.Marker.type, v.coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, v.Marker.size, v.Marker.size, v.Marker.size, v.Marker.color[1], v.Marker.color[2], v.Marker.color[3], v.Marker.color[4], false, false)
					if (dst <= 1.5) then
						ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour intéragir.")
						if (IsControlJustPressed(0,51)) then
							TriggerEvent(("interaction:activity:%s"):format(type))
						end
					end
				end
			end
		end

		Wait(interval)
	end
end)