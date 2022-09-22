RegisterNetEvent("brinks:getPoints", function(points)
	_BrinksActivity.Points = points
	print(json.encode(_BrinksActivity.Points))
end)

local points = {
	blipsPos = nil,
	bagPos = nil
}

local open_menu = function()

	local main = RageUI.CreateMenu("Brinks", "Brinks | Points");
	local add = RageUI.CreateSubMenu(main, "Brinks", "Brinks | Points");
	local remove = RageUI.CreateSubMenu(main, "Brinks", "Brinks | Points");
	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()
			RageUI.Button("Ajouter des points", nil, {}, true, {}, add)
			RageUI.Button("Retirer des points", nil, {}, true, {}, remove)
		end)

		RageUI.IsVisible(add, function()
			RageUI.Button("Position du blips", nil, {RightLabel = not points.blipsPos and "~r~[Non définie]" or "~g~[Définie]"}, true, {
				onSelected = function()
					points.blipsPos = GetEntityCoords(PlayerPedId())
				end
			})
			RageUI.Button("Position du sac", nil, {RightLabel = not points.bagPos and "~r~[Non définie]" or "~g~[Définie]"}, true, {
				onSelected = function()
					points.bagPos = GetEntityCoords(PlayerPedId())
				end
			})
			RageUI.Line()
			RageUI.Button("Finaliser la création", nil, {}, true, {
				onSelected = function()
					TriggerServerEvent("brinks:addPoint", points)
					points.blipsPos = nil
					points.bagPos = nil
				end
			})
		end)

		if not RageUI.Visible(main) and not RageUI.Visible(add) and not RageUI.Visible(remove) then
			main = RMenu:DeleteType('main', true)
			add = RMenu:DeleteType('main', true)
			remove = RMenu:DeleteType('main', true)
		end
	end
end

RegisterNetEvent("brinks:config_points", function()
	open_menu()
end)

RegisterNetEvent("brinks:refresh_points", function(metadata)
	table.insert(_BrinksActivity.Points, {
		Blips = metadata.blipsPos,
		Bag = metadata.bagPos
	})
	print(json.encode(_BrinksActivity.Points))
end)