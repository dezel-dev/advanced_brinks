local GroupPlayer = "owner"

local permission = {
	Mods = {
		["mod"] = true,
		["admin"] = true,
		["owner"] = true
	},
	Admin = {
		["mod"] = false,
		["admin"] = true,
		["owner"] = true
	},
	Owner = {
		["mod"] = false,
		["admin"] = false,
		["owner"] = true
	},
}

function openmenu()
	local main = RageUI.CreateMenu("Garage", "Brinks | Garage");
	RageUI.Visible(main, not RageUI.Visible(main))

	while main do

		Citizen.Wait(0)

		RageUI.IsVisible(main, function()
			RageUI.Button("Modérateur", "Bouton pouvant être utilisé que par les modérateurs", {}, permission.ModsButton[GroupPlayer], {})
			RageUI.Button("Admin", "Bouton pouvant être utilisé que par les admins", {}, permission.AdminButton[GroupPlayer], {})
			RageUI.Button("Fondateur", "Bouton pouvant être utilisé que par les fondateurs", {}, permission.OwnerButton[GroupPlayer], {})
		end)

		if not RageUI.Visible(main) then
			main = RMenu:DeleteType('main', true)
		end
	end
end

RegisterCommand("test_menu", function()
	openmenu()
end)