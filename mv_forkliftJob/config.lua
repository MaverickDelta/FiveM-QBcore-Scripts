Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true

-- Messages
Config.jobRecived = "You have started a job. Please head to the forklift" -- Message for getting starting job
Config.doingJob = "You are currently doing a job, please finnish to start another" -- Message if trying to start second job
Config.finishedJob = "You have finished working" -- Message for finishing work
Config.notDoingJob = "You cannot finish what you never started" -- Message for trying to finish job when one isnt started
Config.palletSpawned = "Pallet spawned, collect it and take it to the drop off" -- Message for spawning pallet
Config.palletAlreadyOut = "These is already a pallet available" -- Message for trying to spawn second pallet
Config.noForklift = "You need a forklift to do this" -- Message for trying to return forklift without forklift
Config.forkliftReturned = "Forklift has been returned. That you for your help today" -- Message for returning forklift

Config.basePay = 1000

Config.jobLocation = {

    ["Port Warehouse"] = {
        ["label"] = "Warehouse",
        ["coords"] = vector4(152.8, -3109.96, 5.9, 181.42),
        ["pedCoords"] = vector4(153, -3109.96, 5.9, 90),
        ["vehCoords"] = vector4(154, -3109.96, 5.9, 180),
        ["forkliftCoords"] = vector4(144, -3108.60, 5.9, 270),
        ["ped"] = 's_m_y_dockwork_01',
        ["veh"] = 'Forklift',
        ["scenario"] = "WORLD_HUMAN_CLIPBOARD",
        ["showblip"] = true,
        ["targetIcon"] = "fa fa-truck",
        ["targetLabel"] = "Start Forklift Job",
        ["targetLabel2"] = "Finish Forklift Job",
        ["blipscale"] = 0.7,
        ["blippriority"] = 1,
        ["blipsprite"] = 479,
        ["blipcolor"] = 45,
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 0,
    },

}

Config.jobOptions = {

    ["Port Warehouse Return"] = {
        ["title"] = "return",
        ["coords"] = vector3(132.5, -3108.60, 5),
        ["textCoords"] = vector3(132.5, -3108.60, 6),
        ["label"] = "Press ~g~E~w~ to return Forklift",
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
    },

    ["Port Warehouse Get Pallet"] = {
        ["title"] = "getPallet",
        ["coords"] = vector3(132.5, -3102.53, 5),
        ["textCoords"] = vector3(132.5, -3102.53, 6),
        ["label"] = "Press ~g~E~w~ to get pallet",
        ["colourr"] = 0,
        ["colourg"] = 128,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
    },

}

Config.palletType = {

    ["Pallet 1"] = {
        ["id"] = 1,
        ["label"] = "prop_boxpile_07d",
        ["multiplier"] = 4,
    },

    ["Pallet 2"] = {
        ["id"] = 2,
        ["label"] = "prop_boxpile_02c",
        ["multiplier"] = 4,
    },

    ["Pallet 3"] = {
        ["id"] = 3,
        ["label"] = "prop_boxpile_06b",
        ["multiplier"] = 2,
    },

    ["Pallet 4"] = {
        ["id"] = 4,
        ["label"] = "prop_boxpile_07a",
        ["multiplier"] = 4,
    },

    ["Pallet 5"] = {
        ["id"] = 5,
        ["label"] = "prop_boxpile_06a",
        ["multiplier"] = 2,
    },

    ["Pallet 6"] = {
        ["id"] = 6,
        ["label"] = "prop_cementbags01",
        ["multiplier"] = 6,
    },

}

Config.palletReturnLocations = {

    ["Return 1"] = {
        ["id"] = 1,
        ["coords"] = vector4(165.02, -3092.4, 5.2, 4.34),
        ["label"] = "Press ~g~E~w~ to drop pallet",
        ["multiplier"] = 2,
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
    },

    ["return 2"] = {
        ["id"] = 2,
        ["coords"] = vector4(115.53, -3095.32, 5.25, 93.1),
        ["label"] = "Press ~g~E~w~ to drop pallet",
        ["multiplier"] = 2,
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
    },

}

Config.palletLocations = {

    ["Pallet 1"] = {
        ["id"] = 1,
        ["label"] = "Pallet1",
        ["coords"] = vector4(137.04, -3089.11, 5.9, 319.51),
        ["multiplier"] = 1,
        ["showblip"] = true,
        ["blipscale"] = 0.7,
        ["blippriority"] = 1,
        ["blipsprite"] = 478,
        ["blipcolor"] = 1,
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 0,
    },

    ["Pallet 2"] = {
        ["id"] = 2,
        ["label"] = "Pallet2",
        ["coords"] = vector4(142.59, -3093.05, 5.9, 285.43),
        ["multiplier"] = 8,
        ["showblip"] = true,
        ["blipscale"] = 0.7,
        ["blippriority"] = 1,
        ["blipsprite"] = 478,
        ["blipcolor"] = 1,
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 0,
    },

}
