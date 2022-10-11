-- target
Citizen.CreateThread(function()
	
	-- casion enterance (show membership)
	exports['qb-target']:AddBoxZone("casino-enterance", vector3(935.83, 46.93, 81.1), 1, 1, {
		name = "casino-enterance",
		heading = 330,
		debugPoly = false,
		minZ=80.1,
		maxZ=82.1
		}, {
			options = {
				{  
					type = "client",
					event = "rsg_casinobase:client:casinoenterance",
					icon = "fas fa-question-circle",
					label = "Enter : Show Membership",
				},
				{  
					type = "client",
					event = "rsg_casinobase:client:membership",
					icon = "fas fa-dollar-sign",
					label = "Buy Membership",
				},
			},
		distance = 2.0
	})
	
	-- casion exit (show membership)
	exports['qb-target']:AddBoxZone("casino-exit", vector3(1089.69, 205.89, -49.0), 1, 1, {
		name = "casino-exit",
		heading = 0,
		debugPoly = false,
		minZ=-50.0,
		maxZ=-48.0
		}, {
			options = {
				{  
					type = "client",
					event = "rsg_casinobase:client:casinoexit",
					icon = "fas fa-question-circle",
					label = "Leave : Show Membership",
				},
			},
		distance = 2.0
	})
		
	-- casino cashier
	exports['qb-target']:AddBoxZone("casino-cashier", vector3(1116.55, 220.0, -49.44), 1, 0.4, {
		name = "casino-cashier",
		heading = 0,
		debugPoly = false,
		minZ=-50.44,
		maxZ=-47.84
		}, {
			options = {
				{  
					type = "client",
					event = "rsg_casinobase:client:opencashier",
					icon = "fas fa-dollar-sign",
					label = "Buy Chips",
				},
				{  
					type = "server",
					event = "rsg_blackjack:server:sellchips",
					icon = "fas fa-dollar-sign",
					label = "Sell Chips",
				},
			},
		distance = 2.0
	})
	
end)

-- casino membership
RegisterNetEvent('rsg_casinobase:client:membership')
AddEventHandler('rsg_casinobase:client:membership', function()
	local ShopItems = {}
	ShopItems.label = "Casino Membership"
	ShopItems.items = Config.CasinoMembership
	ShopItems.slots = #Config.CasinoMembership
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "CasinoMembership_"..math.random(1, 99), ShopItems)
end)

-- casino cashier
RegisterNetEvent('rsg_casinobase:client:opencashier')
AddEventHandler('rsg_casinobase:client:opencashier', function()
	local ShopItems = {}
	ShopItems.label = "Casino Cashier"
	ShopItems.items = Config.CasinoCashier
	ShopItems.slots = #Config.CasinoCashier
	TriggerServerEvent("inventory:server:OpenInventory", "shop", "CasinoCashier_"..math.random(1, 99), ShopItems)
end)