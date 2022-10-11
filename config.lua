Config = {}

Config.Invincible = true -- Is the ped going to be invincible?
Config.Frozen = true -- Is the ped frozen in place?
Config.Stoic = true -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}

Config.CasinoPedList = {

	{
        model = `s_m_m_bouncer_01`, -- bouncer outside enterance
        coords = vector4(935.84503, 46.848754, 81.095687, 147.91333),
        gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
		{
        model = `s_m_m_bouncer_01`, -- bouncer outside enterance
        coords = vector4(1089.6857, 205.88398, -48.99972, 1.3816137),
        gender = 'male',
        scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
	
	{
        model = `u_f_m_casinocash_01`, -- casino cashier
        coords = vector4(1117.79, 220.03, -49.44, 89.8),
        gender = 'female',
        --scenario = 'WORLD_HUMAN_CLIPBOARD'
    },
	
}

Config.CasinoCashier = {

	[1] = {
		name = 'casinochips',
		price = 1,
		amount = 1000000,
		info = {},
		type = 'item',
		slot = 1,
	},
	
}

Config.CasinoMembership = {

	[1] = {
		name = 'casinomember',
		price = 1000,
		amount = 500,
		info = {},
		type = 'item',
		slot = 1,
	},
	
}