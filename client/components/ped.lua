function _BrinksActivity:requestModel(modelHash)
	RequestModel(modelHash)
	while (not HasModelLoaded(modelHash)) do
		Wait(20)
	end
end

function _BrinksActivity:createPed(model, position)
	local modelHash <const> = GetHashKey(model)
	_BrinksActivity:requestModel(modelHash)
	local brinksPed = CreatePed(4, modelHash, position.coords, position.heading, false, false)
	TaskStartScenarioInPlace(brinksPed, Config.Interaction.StartActivity.Ped.scenario)
	FreezeEntityPosition(brinksPed, true)
	SetEntityInvincible(brinksPed, true)
	TaskSetBlockingOfNonTemporaryEvents(brinksPed, true)
	return (brinksPed)
end

Citizen.CreateThread(function()
	while (not NetworkIsPlayerActive(PlayerId())) do
		Wait(20)
	end
	local ped = _BrinksActivity:createPed(Config.Interaction.StartActivity.Ped.model, Config.Interaction.StartActivity.Ped.position)
	local robbery = _BrinksActivity:createPed(Config.Robbery.Ped.model, Config.Robbery.Ped.position)
end)