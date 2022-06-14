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

Config.LocationMarker = 0
Config.locationColourR = 255
Config.locationColourG = 0
Config.locationColourB = 0
Config.locationColourA = 75
Config.locationBlipColour = 1
Config.locationBlipSprite = 478
Config.locationBlipPriority = 1
Config.locationBlipScale = 0.7
Config.locationBlip = true

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
    },

    ["Pallet 2"] = {
        ["id"] = 2,
        ["label"] = "prop_boxpile_02c",
    },

    ["Pallet 3"] = {
        ["id"] = 3,
        ["label"] = "prop_boxpile_06b",
    },

    ["Pallet 4"] = {
        ["id"] = 4,
        ["label"] = "prop_boxpile_07a",
    },

    ["Pallet 5"] = {
        ["id"] = 5,
        ["label"] = "prop_boxpile_06a",
    },

}

Config.palletReturnLocations = {

    ["Return 1"] = {
        ["id"] = 1,
        ["vehCoords"] = vector4(134.50, -3089.00, 5.9, 90.00),
        ["coords"] = vector4(140.00, -3089.00, 5.2, 90.00),
        ["label"] = "Press ~g~E~w~ to drop pallet",
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
        ["vehicle"] = "Mule2",
    },

    ["return 2"] = {
        ["id"] = 2,
        ["vehCoords"] = vector4(112.00, -3140.50, 6.0, 180.00),
        ["coords"] = vector4(112.00, -3135.00, 5.2, 180.00),
        ["label"] = "Press ~g~E~w~ to drop pallet",
        ["colourr"] = 255,
        ["colourg"] = 0,
        ["colourb"] = 0,
        ["coloura"] = 75,
        ["marker"] = 27,
        ["vehicle"] = "Mule2",
    },

}

Config.palletLocations = {

    -- Berth 25
    ["Pallet 1"] = {
        ["id"] = 1,
        ["coords"] = vector4(-288.51120, -2459.24800, 6.30266, 320.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 2"] = {
        ["id"] = 2,
        ["coords"] = vector4(-297.65290, -2451.62400, 6.30266, 320.00),
        ["multiplier"] = 5,
    },

    ["Pallet 3"] = {
        ["id"] = 3,
        ["coords"] = vector4(-306.97400, -2443.72600, 6.30266, 320.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 4"] = {
        ["id"] = 4,
        ["coords"] = vector4(-315.86010, -2436.30500, 6.30266, 320.00),
        ["multiplier"] = 5,
    },

    ["Pallet 5"] = {
        ["id"] = 5,
        ["coords"] = vector4(-269.89760, -2474.78100, 6.30266, 320.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 6"] = {
        ["id"] = 6,
        ["coords"] = vector4(-288.82590, -2497.24900, 6.30266, 140.00),
        ["multiplier"] = 5,
    },

    ["Pallet 7"] = {
        ["id"] = 7,
        ["coords"] = vector4(-298.07520, -2489.37500, 6.30266, 140.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 8"] = {
        ["id"] = 8,
        ["coords"] = vector4(-307.21750, -2481.78500, 6.30266, 140.00),
        ["multiplier"] = 5,
    },

    ["Pallet 9"] = {
        ["id"] = 9,
        ["coords"] = vector4(-316.51390, -2474.00400, 6.30266, 140.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 10"] = {
        ["id"] = 10,
        ["coords"] = vector4(-334.88230, -2458.55300, 6.30266, 140.00),
        ["multiplier"] = 5,
    },

    ["Pallet 11"] = {
        ["id"] = 11,
        ["coords"] = vector4(-331.14260, -2434.48500, 5.00000, 50.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 12"] = {
        ["id"] = 12,
        ["coords"] = vector4(-335.28360, -2439.03300, 5.00000, 50.0),
        ["multiplier"] = 5,
    },

    -- Berth 153 (Post OP)
    ["Pallet 13"] = {
        ["id"] = 13,
        ["coords"] = vector4(-440.76200, -2795.76200, 6.30000, 45.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 14"] = {
        ["id"] = 14,
        ["coords"] = vector4(-449.57180, -2804.66800, 6.30000, 45.00),
        ["multiplier"] = 5,
    },

    ["Pallet 15"] = {
        ["id"] = 15,
        ["coords"] = vector4(-476.47150, -2831.52400, 6.30000, 45.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 16"] = {
        ["id"] = 16,
        ["coords"] = vector4(-494.56660, -2849.59600, 6.30000, 45.00),
        ["multiplier"] = 5,
    },

    ["Pallet 17"] = {
        ["id"] = 17,
        ["coords"] = vector4(-503.67370, -2858.63900, 6.30000, 45.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 18"] = {
        ["id"] = 18,
        ["coords"] = vector4(-462.39190, -2775.41200, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    ["Pallet 19"] = {
        ["id"] = 19,
        ["coords"] = vector4(-482.87890, -2795.95300, 5.00000, 225.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 20"] = {
        ["id"] = 20,
        ["coords"] = vector4(-469.63960, -2782.73400, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    -- Train Shed
    ["Pallet 21"] = {
        ["id"] = 21,
        ["coords"] = vector4(-337.96840, -2619.52500, 5.00000, 225.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 22"] = {
        ["id"] = 22,
        ["coords"] = vector4(-350.32300, -2631.00000, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    ["Pallet 23"] = {
        ["id"] = 23,
        ["coords"] = vector4(-354.15500, -2635.01800, 5.00000, 225.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 24"] = {
        ["id"] = 24,
        ["coords"] = vector4(-373.85640, -2654.68300, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    ["Pallet 25"] = {
        ["id"] = 25,
        ["coords"] = vector4(  -393.77090, -2674.59500, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    ["Pallet 26"] = {
        ["id"] = 26,
        ["coords"] = vector4(-399.09210, -2674.35900, 5.00000, 45.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 27"] = {
        ["id"] = 27,
        ["coords"] = vector4(-367.15790, -2714.59800, 5.00000, 75.20),
        ["multiplier"] = 5,
    },

    -- Octopus Ship
    ["Pallet 28"] = {
        ["id"] = 28,
        ["coords"] = vector4(-408.58540, -2635.99700, 5.00000, 225.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 29"] = {
        ["id"] = 29,
        ["coords"] = vector4(-396.86680, -2623.72700, 5.00000, 225.00),
        ["multiplier"] = 5,
    },

    ["Pallet 30"] = {
        ["id"] = 30,
        ["coords"] = vector4(-373.20210, -2600.43800, 5.00000, 225.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 31"] = {
        ["id"] = 31,
        ["coords"] = vector4(-362.77370, -2525.69300, 5.00000, 320.00),
        ["multiplier"] = 5,
    },

    ["Pallet 32"] = {
        ["id"] = 32,
        ["coords"] = vector4(-405.58660, -2489.09300, 5.00000, 320.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 33"] = {
        ["id"] = 33,
        ["coords"] = vector4(-441.08660, -2460.54600, 5.00000, 320.00),
        ["multiplier"] = 5,
    },

    -- Unknown
    ["Pallet 34"] = {
        ["id"] = 34,
        ["coords"] = vector4(-235.43950, -2565.61700, 5.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 35"] = {
        ["id"] = 35,
        ["coords"] = vector4(-240.27700, -2570.64200, 5.00000, 0.00),
        ["multiplier"] = 5,
    },

    ["Pallet 36"] = {
        ["id"] = 36,
        ["coords"] = vector4(-217.46040, -2608.23500, 5.00000, 90.00),
        ["multiplier"] = 2.5,
    },

    -- Building 1
    ["Pallet 37"] = {
        ["id"] = 37,
        ["coords"] = vector4(-234.56760, -2659.05000, 5.00000, 0.00),
        ["multiplier"] = 5,
    },

    ["Pallet 38"] = {
        ["id"] = 38,
        ["coords"] = vector4(-219.85510, -2655.11200, 5.00000, 90.00),
        ["multiplier"] = 5,
    },

    ["Pallet 39"] = {
        ["id"] = 39,
        ["coords"] = vector4(-214.48660, -2649.13600, 5.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 40"] = {
        ["id"] = 40,
        ["coords"] = vector4(-226.54600, -2668.97000, 5.00000, 180.00),
        ["multiplier"] = 5,
    },

    -- Building 3
    ["Pallet 41"] = {
        ["id"] = 41,
        ["coords"] = vector4(-285.99300, -2717.83800, 5.00000, 45.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 42"] = {
        ["id"] = 42,
        ["coords"] = vector4(-316.97200, -2723.73000, 5.00000, 315.00),
        ["multiplier"] = 5,
    },

    ["Pallet 43"] = {
        ["id"] = 43,
        ["coords"] = vector4(-306.27470, -2734.49800, 5.00000, 315.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 44"] = {
        ["id"] = 44,
        ["coords"] = vector4(-300.41140, -2732.46700, 5.00000, 45.00),
        ["multiplier"] = 5,
    },

    ["Pallet 45"] = {
        ["id"] = 45,
        ["coords"] = vector4(-310.57680, -2699.39700, 5.00000, 315.00),
        ["multiplier"] = 2.5,
    },
    
    -- Building 4
    ["Pallet 46"] = {
        ["id"] = 46,
        ["coords"] = vector4(-262.34100, -2693.94500, 5.00000, 45.00),
        ["multiplier"] = 5,
    },

    ["Pallet 47"] = {
        ["id"] = 47,
        ["coords"] = vector4(-272.64200, -2704.41600, 5.00000, 45.00),
        ["multiplier"] = 2.5,
    },

    -- next to builing 1
    ["Pallet 48"] = {
        ["id"] = 48,
        ["coords"] = vector4(-167.93000, -2658.92100, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 49"] = {
        ["id"] = 49,
        ["coords"] = vector4(-168.82170, -2686.81700, 5.00000, 270.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 50"] = {
        ["id"] = 50,
        ["coords"] = vector4(-169.24210, -2707.41700, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 51"] = {
        ["id"] = 51,
        ["coords"] = vector4(-155.87800, -2717.43000, 5.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    -- D-Rail
    ["Pallet 52"] = {
        ["id"] = 52,
        ["coords"] = vector4(-112.59520, -2637.43900, 5.00000, 180.00),
        ["multiplier"] = 5,
    },

    ["Pallet 53"] = {
        ["id"] = 53,
        ["coords"] = vector4(-128.25250, -2706.13100, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 54"] = {
        ["id"] = 54,
        ["coords"] = vector4(-128.17990, -2698.59200, 5.00000, 270.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 55"] = {
        ["id"] = 55,
        ["coords"] = vector4(-128.06780, -2676.56300, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 56"] = {
        ["id"] = 56,
        ["coords"] = vector4(-128.21660, -2669.74300, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 57"] = {
        ["id"] = 57,
        ["coords"] = vector4(-128.16860, -2662.41700, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 58"] = {
        ["id"] = 58,
        ["coords"] = vector4(-108.59960, -2691.59300, 5.00000, 90.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 59"] = {
        ["id"] = 59,
        ["coords"] = vector4(-98.80044, -2637.25600, 5.00000, 180.00),
        ["multiplier"] = 5,
    },

    ["Pallet 60"] = {
        ["id"] = 60,
        ["coords"] = vector4(-91.88831, -2742.07900, 5.00000, 90.00),
        ["multiplier"] = 5,
    },

    -- Walker
    ["Pallet 61"] = {
        ["id"] = 61,
        ["coords"] = vector4(-31.97238, -2653.66400, 5.00000, 0.00),
        ["multiplier"] = 5,
    },

    ["Pallet 62"] = {
        ["id"] = 62,
        ["coords"] = vector4(-57.16412, -2659.63200, 5.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 63"] = {
        ["id"] = 63,
        ["coords"] = vector4(-28.47571, -2665.28300, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 64"] = {
        ["id"] = 64,
        ["coords"] = vector4(-28.69450, -2679.03400, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    -- Pacific Bri
    ["Pallet 65"] = {
        ["id"] = 65,
        ["coords"] = vector4(89.01086, -2675.16000, 5.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 66"] = {
        ["id"] = 66,
        ["coords"] = vector4(84.91182, -2675.10100, 5.00000, 0.00),
        ["multiplier"] = 5,
    },

    ["Pallet 67"] = {
        ["id"] = 67,
        ["coords"] = vector4(80.63327, -2675.06700, 5.00000, 0.00),
        ["multiplier"] = 5,
    },

    -- Class-A Lines (Workplace)
    ["Pallet 68"] = {
        ["id"] = 68,
        ["coords"] = vector4(51.79316, -2719.11300, 5.00000, 270.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 69"] = {
        ["id"] = 69,
        ["coords"] = vector4(51.92499, -2715.49800, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 70"] = {
        ["id"] = 70,
        ["coords"] = vector4(51.97153, -2711.76700, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    -- Port Security
    ["Pallet 71"] = {
        ["id"] = 71,
        ["coords"] = vector4(-316.44940, -2781.03300, 4.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 72"] = {
        ["id"] = 72,
        ["coords"] = vector4(-341.95650, -2787.76900, 4.00000, 0.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 73"] = {
        ["id"] = 73,
        ["coords"] = vector4(-353.65680, -2800.52600, 5.00000, 45.00),
        ["multiplier"] = 5,
    },

    ["Pallet 74"] = {
        ["id"] = 74,
        ["coords"] = vector4(-357.04200, -2800.43400, 5.00000, 315.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 75"] = {
        ["id"] = 75,
        ["coords"] = vector4(-365.87320, -2788.73400, 5.00000, 270.00),
        ["multiplier"] = 5,
    },

    ["Pallet 76"] = {
        ["id"] = 76,
        ["coords"] = vector4(-366.03740, -2784.58300, 5.00000, 270.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 77"] = {
        ["id"] = 77,
        ["coords"] = vector4(-369.00560, -2777.11500, 5.00000, 315.00),
        ["multiplier"] = 5,
    },

    ["Pallet 78"] = {
        ["id"] = 78,
        ["coords"] = vector4(-371.29460, -2774.78700, 5.00000, 315.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 79"] = {
        ["id"] = 79,
        ["coords"] = vector4(-373.52640, -2772.48500, 5.00000, 315.00),
        ["multiplier"] = 2.5,
    },

    -- Trailer
    ["Pallet 80"] = {
        ["id"] = 80,
        ["coords"] = vector4(-216.05270, -2519.60300, 5.00000, 180.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 81"] = {
        ["id"] = 81,
        ["coords"] = vector4(-222.73900, -2497.82000, 5.00000, 90.00),
        ["multiplier"] = 5,
    },

    ["Pallet 82"] = {
        ["id"] = 82,
        ["coords"] = vector4(-229.54770, -2475.67100, 5.00000, 90.00),
        ["multiplier"] = 2.5,
    },

    ["Pallet 83"] = {
        ["id"] = 83,
        ["coords"] = vector4(-224.49350, -2519.71700, 5.00000, 180.00),
        ["multiplier"] = 2.5,
    },

}
