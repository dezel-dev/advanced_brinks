_BrinksActivity.Interaction.Garage = {}

function _BrinksActivity.Interaction.Garage:spawn_vehicle(model, position)
	ESX.Game.SpawnVehicle(model, position.coords, position.heading, function(vehicle)
		if (vehicle ~= nil) then
			_BrinksActivity.Vehicle = vehicle
		end
	end)
end

--Menu garage
function _BrinksActivity.Interaction.Garage:menu()

	local coords = GetEntityCoords(PlayerPedId())
	local main = RageUI.CreateMenu("Garage", "Brinks | Garage");
	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		local dst = #(coords - GetEntityCoords(PlayerPedId()))
		if (dst > 5.0) then
			RageUI.CloseAll()
		end

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()
			for _, v in pairs(Config.Interaction.InActivity.Garage.Vehicles) do
				if (v.label ~= nil) then
					RageUI.Button(v.label, nil, {}, true, {
						onSelected = function()
							if (not ESX.Game.IsSpawnPointClear(Config.Interaction.InActivity.Garage.Vehicles.SpawnPoint.coords, 2.5)) or (_BrinksActivity.Vehicle) then
								ESX.ShowNotification("~r~Veuillez réessayer!")
							else
								_BrinksActivity.Interaction.Garage:spawn_vehicle(v.model, { coords = Config.Interaction.InActivity.Garage.Vehicles.SpawnPoint.coords, heading = Config.Interaction.InActivity.Garage.Vehicles.SpawnPoint.heading  })
							end
						end
					})
				end
			end
		end)

		if not RageUI.Visible(main) then
			main = RMenu:DeleteType('main', true)
		end
	end
end

--Rent vehicle interaction
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local dst = #(GetEntityCoords(PlayerPedId()) - Config.Interaction.InActivity.Garage.Vehicles.SpawnPoint.coords)
		if (dst <= 10.0) and (IsPedInVehicle(PlayerPedId(), _BrinksActivity.Vehicle, true)) then
			interval = 0
			ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.")
			if (IsControlJustPressed(0,51)) then
				ESX.Game.DeleteVehicle(_BrinksActivity.Vehicle)
				RemoveBlip(_BrinksActivity.Mission.Blip)
				while (DoesEntityExist(_BrinksActivity.Mission.Object)) do
					ESX.Game.DeleteObject(_BrinksActivity.Mission.Object)
				end
				_BrinksActivity.Mission.BagInBrinks = 0
				ESX.ShowNotification("~g~Vous avez rangé votre véhicule!")
				_BrinksActivity.Vehicle = nil
			end
		end

		Wait(interval)
	end
end)


AddEventHandler("interaction:activity:Garage", function()
	_BrinksActivity.Interaction.Garage:menu()
end)