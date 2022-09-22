Citizen.CreateThread(function()
	while (true) do
		local interval = 1000
		local dst = #(GetEntityCoords(PlayerPedId()) - Config.Reward.Position)
		if (dst <= 10.0) then
			interval = 0
			DrawMarker(6, Config.Reward.Position, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 180, false, false)
		end
		if (dst <= 1.5) then
			ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour vendre les sacs")
			if (IsControlJustPressed(0,51)) then
				TriggerServerEvent("brinks_activity:bag_reward")
			end
		end

		Wait(interval)
	end
end)