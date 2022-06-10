Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget tru

Config.rentalPrice = 500 -- Cost of renting bike
Config.returnPrice = 250 -- Amount refunded for returning the bike
Config.rentalBike = "Cruiser" -- Bike you will recive

-- Messages
Config.bikeRecived = "You have rented a bike. Please return back for £250" -- Message for getting bike out
Config.notOnBike = "Get on your bike to return" -- Message if not on bike and trying to return
Config.bikeOut = "Please return your bike to rent another" -- Message if trying to rent second bike
Config.bikeReturned = "Thank you for returning your bike" -- Message for bike return

Config.rentalLocation = {

    ["Hospital Bike Rental"] = {
        ["label"] = "Hospital Bike Rental",
        ["coords"] = vector4(295.92, -591.38, 43.27, 72.24),
        ["spawnCoords"] = vector4(295.92, -590.38, 43.27, 72.24),
        ["ped"] = 'a_m_y_roadcyc_01',
        ["veh"] = 'TriBike3',       
        ["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
        ["showblip"] = true,
        ["targetIcon"] = "fa fa-bicycle",
        ["targetLabel"] = "Rent Bike | £500",
        ["returnLabel"] = "Return Bike | +£500",
        ["blipscale"] = 0.5,
        ["blippriority"] = 1,
        ["blipsprite"] = 536,
        ["blipcolor"] = 46,
    },

    ["Prison Bike Rental"] = {
        ["label"] = "Prison Bike Rental",
        ["coords"] = vector4(1852.37, 2614.72, 45.67, 273.99),
        ["spawnCoords"] = vector4(1852.37, 2615.72, 45.67, 273.99),
        ["ped"] = 'a_m_y_roadcyc_01',
        ["veh"] = 'TriBike3',
        ["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
        ["showblip"] = true,
        ["targetIcon"] = "fa fa-bicycle",
        ["targetLabel"] = "Rent Bike | £500",
        ["returnLabel"] = "Return Bike | +£500",        
        ["blipscale"] = 0.5,
        ["blippriority"] = 1,
        ["blipsprite"] = 536,
        ["blipcolor"] = 46,
    },
}