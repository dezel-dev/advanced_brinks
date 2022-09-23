_BrinksActivity.Mission = {}
_BrinksActivity.Mission.Object = 0
_BrinksActivity.Mission.BagInBrinks = 0

local coords = {
	bag,
	blip,
}

RegisterNetEvent("brinks:money_bag", function()
	if (not _BrinksActivity.IsInActivity) then
		return
	end
	local closestBrinks = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
	if (GetEntityModel(closestBrinks) ~= GetEntityModel(_BrinksActivity.Vehicle)) then
		return (ESX.ShowNotification("~r~Vous devez être à côté d'un brinks!"))
	end
	local coordsBrinks = GetEntityCoords(closestBrinks)
	local dst = #(GetEntityCoords(PlayerPedId() - coordsBrinks))
	if (dst <= 5.0) then
		if (_BrinksActivity.Mission.BagInBrinks == Config.MaxBag) then
			return ESX.ShowNotification("~r~Vous avez atteint le maximum de sac dans le brinks!")
		end
		_BrinksActivity.Mission.BagInBrinks = _BrinksActivity.Mission.BagInBrinks + 1
		TriggerServerEvent("brinks_activity:remove_bag")
	end
end)

function _BrinksActivity.Mission:loadMission()
	if (#_BrinksActivity.Points == 0) then
		return
	end
	local random = math.random(1, #_BrinksActivity.Points)
	coords.bag = _BrinksActivity.Points[random].Bag
	coords.blip = _BrinksActivity.Points[random].Blips
	_BrinksActivity.Mission.Blip = AddBlipForCoord(coords.blip)
	SetBlipRoute(_BrinksActivity.Mission.Blip, 2)
	ESX.ShowNotification("~g~Une nouvelle mission vous a été attribué!")
	ESX.Game.SpawnLocalObject("prop_big_bag_01", coords.bag, function(obj)
		_BrinksActivity.Mission.Object = obj
		PlaceObjectOnGroundProperly(obj)
		FreezeEntityPosition(obj, true)
	end)
	Citizen.CreateThread(function()
		while (true) do
			local interval = 1000
			local dst = #(GetEntityCoords(PlayerPedId()) - coords.bag)
			if (dst <= 2.0) then
				interval = 0
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour prendre le sac")
				if (IsControlJustPressed(0,51)) then
					_BrinksActivity.Mission.Object = 0
					DeleteObject(_BrinksActivity.Mission.Object)
					RemoveBlip(_BrinksActivity.Mission.Blip)
					TriggerServerEvent("brinks_activtiy:give_bag")
					_BrinksActivity.Mission:loadMission()
					break
				end
			end

			Wait(interval)
		end
	end)
end

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		if (IsPedInVehicle(PlayerPedId(), _BrinksActivity.Vehicle, true)) then
			interval = 0
			_BrinksActivity.Mission:loadMission()
			break
		end

		Wait(interval)
	end
end)

Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local coords = GetEntityCoords(_BrinksActivity.Vehicle)
		local dst = #(GetEntityCoords(PlayerPedId()) - coords)
		if (dst <= 5.0) and (not IsPedInVehicle(PlayerPedId(), _BrinksActivity.Vehicle, true)) and (_BrinksActivity.IsInActivity) then
			interval = 0
			ESX.Game.Utils.DrawText3D(vector3(coords.x + 3.0, coords.y, coords.z), "Nombre de sacs : ".._BrinksActivity.Mission.BagInBrinks)
			if (IsControlJustPressed(0,167)) then
				_BrinksActivity.Mission.BagInBrinks = _BrinksActivity.Mission.BagInBrinks - 1
				TriggerServerEvent("brinks_activtiy:give_bag")
			end
		end

		Wait(interval)
	end
end)