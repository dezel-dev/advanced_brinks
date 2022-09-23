Config = {
	Interaction = {
		StartActivity = {
			Ped = {
				model = "s_m_y_sheriff_01",
				position = { coords = vector3(1002.00, -1855.36, 30.03), heading = 180.0 },
				scenario = "WORLD_HUMAN_GUARD_PATROL"
			},
			Blips = {
				id = 318,
				scale = 0.7,
				name = "Activité | Brinks",
				color = 46
			}
		},
		InActivity = {
			Garage = {
				coords = vector3(1030.07, -1862.86, 29.88),
				Marker = {
					type = 6,
					color = { 255, 255, 255, 180 },
					size = 1.0
				},
				Blips = {
					id = 50,
					scale = 0.6,
					name = "Brinks | Garage",
					color = 0
				},
				Vehicles = {
					SpawnPoint = { coords = vector3(1027.11, -1860.15, 30.0), heading = 90.0},
					{
						label = "Camion blindé",
						model = "stockade",
					}
				}
			},
		}
	},
	Reward = {
		Position = vector3(253.89, 228.92, 101.68),
		Money = 50
	},
	MaxBag = 10,
	PermConfig = {
		user = false,
		admin = true,
		superadmin = true,
		owner = true,
		_dev = true
	},
	Robbery = {
		Time = 15,
		Reward = { Min = 4, Max = 8 },
		AlertPolice = 5,
		Price = 3000,
		Cooldown = 600000,
		Ped = {
			model = "a_m_m_soucent_01",
			position = { coords = vector3(1013.65, -1838.27, 30.78), heading = 180.0 },
			scenario = "WORLD_HUMAN_GUARD_PATROL"
		},
		Weapon = {
			["453432689"] = true
		}
	}
}