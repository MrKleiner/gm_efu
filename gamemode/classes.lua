--[[
SECURITYGUARD = {
	"models/player/police.mdl",
}

FSFS = {
	"models/player/combine_soldier_customcombinepmv2.mdl",
	"models/player/combine_soldier_customcombinepmv2_new.mdl",
	"models/player/combine_soldier_prisonguard_customcombinepmv2.mdl",
	"models/jimice.mdl",
}

UNIT = {
	"models/player/police.mdl",
}

FSFCMD = {
	"models/player/combine_super_soldier_customcombinepmv2.mdl",
}

ALLCLASSES = {
	guards = {
		name = "Security Guard of WoldWater",
		color = Color(255, 130, 0),
		roles = {
			{name = ROLES.ROLE_GUARD,
			 team = TEAM_GUARD,
			 weapons = {"br_holster"},
			 showweapons = {},
			 ammo = {},
			 health = 100,
			 armor = 0,
			 walkspeed = 1,
			 runspeed  = 1,
			 jumppower = 1,
			 models = SECURITYGUARD,
			 showmodel = nil,
			 level = 0,
			 customcheck = nil,
			 flashlight = false,
			 max = 64
			},
		}
	},
	unit = {
		name = "Unit the MetroCock",
		color = Color(141, 58, 196),
		roles = {
			{name = ROLES.ROLE_UNIT,
			 team = TEAM_UNIT,
			 weapons = {"weapon_unit"},
			 ammo = {},
			 health = 10000,
			 armor = 0,
			 walkspeed = 1,
			 runspeed  = 1,
			 jumppower = 1,
			 vest = nil,
			 models = UNIT,
			 showmodel = nil,
			 pmcolor = Color(50,50,50),
			 flashlight = false,
			 max = 1
			},
		}
	},
	fsf = {
		name = "FastSpecialForce The Ukrainian Combine Reinforcement Units",
		color = Color(29, 81, 56),
		sc_color = Color(0, 100, 255),
		roles = {
			{name = ROLES.ROLE_FSF_SOLDIER,
			 team = TEAM_GUARD,
			 weapons = {"epg_akm"},
			 ammo = {{"AR2", 180}},
			 health = 100,
			 armor = 0,
			 walkspeed = 1,
			 runspeed  = 1,
			 jumppower = 1,
			 models = FSFS,
			 --showmodel = "models/fart/ragdolls/css/counter_sas_player.mdl",
			 pmcolor = nil,
			 flashlight = true,
			 max = 3
			},
			{name = ROLES.ROLE_FSF_MEDIC,
			 team = TEAM_GUARD,
			 weapons = {"epg_akm"},
			 --showweapons = {"Keycard Level 4", "Radio", "Gas Mask", "NVG", "Med Kit", "Stunstick", "FAMAS"},
			 ammo = {{"AR2", 180}},
			 health = 100,
			 armor = 0,
			 walkspeed = 1,
			 runspeed  = 1,
			 jumppower = 1,
			 models = FSFS,
			 --showmodel = "models/payday2/units/medic_player.mdl",
			 pmcolor = nil,
			 flashlight = true,
			 max = 1
			},
			{name = ROLES.ROLE_FSF_CMD,
			 team = TEAM_GUARD,
			 weapons = {"epg_akm"},
			 ammo = {{"AR2", 180}, {"Pistol", 105}},
			 health = 100,
			 armor = 0,
			 walkspeed = 1,
			 runspeed  = 1,
			 jumppower = 1,
			 models = FSFCMD,
			 showmodel = FSFCMD
			 pmcolor = nil,
			 flashlight = true,
			 max = 1
			},
		}
	}
}


ROLE_LIST_GUARD = 1				// 4 - 8
ROLE_LIST_UNIT = 2				// 1 - 2
ROLE_LIST_FSF = 3		// 2 - 4

Breach_Default_Role_List = {
	// 1 - 16	{4, 2, 2, 3, 3, 2}
	ROLE_LIST_GUARD,
	ROLE_LIST_UNIT,
	ROLE_LIST_FSF,
	// 2 - 32	{8, 5, 4, 5, 6, 4}
	ROLE_LIST_GUARD,
	ROLE_LIST_FSF,
	ROLE_LIST_UNIT,
}


]]