_BrinksActivity.Robbery = {}
_BrinksActivity.Robbery.Timer = Config.Robbery.Time
_BrinksActivity.Robbery.Cooldown = false

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (not _BrinksActivity.IsInRobbery) then
			local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(PlayerPedId()), 10.0)
			for _, v in pairs(vehicles) do
				if (GetEntityModel(v) == GetHashKey("stockade")) and (not _BrinksActivity.IsInActivity) then
					interval = 0
					local aiming, targetVeh = GetEntityPlayerIsFreeAimingAt(PlayerId())
					if (aiming) and (Config.Robbery.Weapon[tostring(GetSelectedPedWeapon(PlayerPedId()))]) then
						if (_BrinksActivity.Robbery.Cooldown) then
							ESX.ShowNotification("~r~Vous avez déjà braqué un Brinks! Veuillez patienter...")
						else
							if DoesEntityExist(targetVeh) and (IsEntityAVehicle(targetVeh)) then
								TriggerEvent("brinks:startRobbery") -- Here's a event to use in your scripts when a brinks robbery starts!
								ESX.ShowNotification(("~r~Vous braquez le Brinks, les policiers en seront informés dans %s secondes"):format(Config.Robbery.AlertPolice))
								ESX.ShowNotification(("~r~Vous recevrez vos sacs dans %s secondes"):format(Config.Robbery.Time))
								_BrinksActivity.IsInRobbery = true
								Citizen.SetTimeout(Config.Robbery.AlertPolice*1000, function()
									TriggerServerEvent("brinks:alertPolice", GetEntityCoords(PlayerPedId()))
									ESX.ShowNotification("~r~Les policiers ont été informé de votre braquage de brinks!")
								end)
							end
						end
					end
				end
			end
		end

		Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (_BrinksActivity.IsInRobbery) then
			if (_BrinksActivity.Robbery.Timer == 0) then
				_BrinksActivity.IsInRobbery = false
				_BrinksActivity.Robbery.Timer = Config.Robbery.Time
				local reward = math.random(Config.Robbery.Reward.Min, Config.Robbery.Reward.Max)
				TriggerServerEvent("brinks:robbery:reward", reward)
				ESX.ShowNotification(("~g~Vous avez braqué un Brinks. Vous obtenez %s sacs d'argents volés"):format(reward))
				_BrinksActivity.Robbery.Cooldown = true
				Citizen.SetTimeout(Config.Robbery.Cooldown, function()
					_BrinksActivity.Robbery.Cooldown = false
				end)
			end
			if (_BrinksActivity.Robbery.Timer ~= 0) then
				_BrinksActivity.Robbery.Timer = _BrinksActivity.Robbery.Timer - 1
			end
		end

		Wait(interval)
	end
end)

RegisterNetEvent("brinks:robberyAlert", function(position)
	ESX.ShowAdvancedNotification("Alerte police", "Braquage de Brinks", "Un brinks est en train d'être braqué! Un point sur votre carte a été mit à l'endroit du crime!","CHAR_CALL911", 2)
	local blip = AddBlipForCoord(position)
	SetBlipScale(blip, 0.6)
	SetBlipSprite(blip, 161)
	SetBlipColour(blip, 1)
	SetBlipAlpha(blip, 255)
	AddTextEntry("BLIPS_ROBERRY:BRINKS", "Braquage de Brinks")
	BeginTextCommandSetBlipName("BLIPS_ROBERRY:BRINKS")
	SetBlipCategory(blip, 2)
	EndTextCommandSetBlipName(blip)
	Citizen.SetTimeout(120000, function()
		RemoveBlip(blip)
	end)
end)

--Ped
Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local dst = #(GetEntityCoords(PlayerPedId()) - Config.Robbery.Ped.position.coords)
		if (dst <= 1.5) then
			interval = 0
			ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre vos sacs volés.")
			if (IsControlJustPressed(0,51)) then
				TriggerServerEvent("brinks:robbery:sell")
			end
		end

		Wait(interval)
	end
end)