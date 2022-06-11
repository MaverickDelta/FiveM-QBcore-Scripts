local QBCore = exports['qb-core']:GetCoreObject()

local BikeVeh = {}
local bikeSpawned = false
local BikePed = {}
local pedSpawned = false
local bikeRented = false

-- Blips
function createBlips()
    for bike, _ in pairs(Config.rentalLocation) do
        if Config.rentalLocation[bike]["showblip"] then
            local BikeBlip = AddBlipForCoord(Config.rentalLocation[bike]["coords"]["x"], Config.rentalLocation[bike]["coords"]["y"], Config.rentalLocation[bike]["coords"]["z"])
            SetBlipSprite(BikeBlip, Config.rentalLocation[bike]["blipsprite"])
            SetBlipScale(BikeBlip, Config.rentalLocation[bike]["blipscale"])
            SetBlipDisplay(BikeBlip, 4)
            SetBlipColour(BikeBlip, Config.rentalLocation[bike]["blipcolor"])
            SetBlipPriority(BikeBlip, Config.rentalLocation[bike]["blippriority"])
            SetBlipAsShortRange(BikeBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.rentalLocation[bike]["label"])
            EndTextCommandSetBlipName(BikeBlip)
        end
    end
end

-- Ped Management
local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.rentalLocation) do
        local current = v["ped"]
        local vehicle = v["veh"]
        local coords = v["spawnCoords"]
        local xPlayer = PlayerPedId()

        current = type(current) == 'string' and GetHashKey(current) or current
        vehicle = type(vehicle) == 'string' and GetHashKey(vehicle) or vehicle
        RequestModel(current)

        while not HasModelLoaded(vehicle) do
            Wait(0)
            RequestModel(vehicle)
        end

        while not HasModelLoaded(current) do
            Wait(0)
        end

        BikeVeh[k] = CreateVehicle(vehicle, v["coords"].x, v["coords"].y, v["coords"].z-1, v["coords"].w, false, false)
        BikePed[k] = CreatePed(0, current, v["coords"].x, v["coords"].y - 0.5, v["coords"].z-1, v["coords"].w, false, false)

        -- Ped Freeze
        TaskStartScenarioInPlace(BikePed[k], v["scenario"], true)
        FreezeEntityPosition(BikePed[k], true)
        SetEntityInvincible(BikePed[k], true)
        SetBlockingOfNonTemporaryEvents(BikePed[k], true)
       
        -- Vehicle Freeze
        SetVehicleDoorsLocked(BikeVeh[k], 2)
        FreezeEntityPosition(BikeVeh[k], true)
        SetEntityInvincible(BikeVeh[k], true)
        SetBlockingOfNonTemporaryEvents(BikeVeh[k], true)        

        if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(BikePed[k], {
            options = {
                {
                    label = v["targetLabel"],
                    icon = v["targetIcon"],
                    item = v["item"],
                    action = function()

                        if bikeRented == false then
                            TriggerServerEvent('rentBike:pay', Config.rentalPrice, coords, GetPlayerServerId(PlayerId()))
                            QBCore.Functions.Notify(Config.bikeRecived, "success")
                        else
                            QBCore.Functions.Notify(Config.bikeOut, "error")
                        end

                    end,
                    job = v["job"],
                    gang = v["gang"],
                }
            },
            distance = 2.0
        })
        end

        if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(BikePed[k], {
            options = {
                {
                    label = v["returnLabel"],
                    icon = v["targetIcon"],
                    action = function()

                        TriggerEvent('returnPedVeh')

                    end,
                    job = v["job"],
                    gang = v["gang"],
                }
            },
            distance = 3.0
        })
        end

    end

    bikeSpawned = true
    pedSpawned = true
end

local function deletePeds()
    if pedSpawned then
        for _, v in pairs(BikePed) do
            DeletePed(v)
        end
    end
end

local function deleteVeh()
    if bikeSpawned then
        for _, v in pairs(BikeVeh) do
            DeleteVehicle(v)
        end
    end
end

-- Bike return function
RegisterNetEvent('returnPedVeh')
AddEventHandler('returnPedVeh', function()

    local xPlayer = PlayerPedId()
    local rentalReturn = GetVehiclePedIsIn(xPlayer)

    rentalReturn = type(rentalReturn) == 'string' and GetHashKey(rentalReturn) or rentalReturn

    checkVehicle = 'Cruiser'
    checkVehicle = type(checkVehicle) == 'string' and GetHashKey(checkVehicle) or checkVehicle

    if IsPedInModel(xPlayer, 'Cruiser',true) then
        DeleteVehicle(rentalReturn)
        TriggerServerEvent('rentBike:refund', GetPlayerServerId(PlayerId()))
        QBCore.Functions.Notify(Config.bikeReturned, "success")
        bikeRented = false
    else
        QBCore.Functions.Notify(Config.notOnBike, "error")
    end

end)

-- Bike rent function
RegisterNetEvent('spawnRentedBike')
AddEventHandler('spawnRentedBike', function(coords)

    local spawnLocation = coords
    local bike = Config.rentalBike
    bike = type(bike) == 'string' and GetHashKey(bike) or bike

    RequestModel(bike)
    while not HasModelLoaded(bike) do
        Citizen.Wait(1)
        RequestModel(bike)
    end

    CreateVehicle(bike, spawnLocation.x, spawnLocation.y, spawnLocation.z, spawnLocation.w, true, false)
    bikeRented = true
end)

-- Net Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
    createPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    deleteVeh()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        createBlips()
        createPeds()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
        deleteVeh()
    end
end)
