local QBCore = exports['qb-core']:GetCoreObject()

local forkliftVeh = {}
local forkliftSpawned = false
local forkliftPed = {}
local pedSpawned = false

local currentFLJob = false
local palletObj = {}
local palletSpawned = false
local jobForkLift = {}
local palletInPlace = false

-- Create Blips
function createBlips()
    for bike, _ in pairs(Config.jobLocation) do
        if Config.jobLocation[bike]["showblip"] then
            local BikeBlip = AddBlipForCoord(Config.jobLocation[bike]["coords"]["x"], Config.jobLocation[bike]["coords"]["y"], Config.jobLocation[bike]["coords"]["z"])
            SetBlipSprite(BikeBlip, Config.jobLocation[bike]["blipsprite"])
            SetBlipScale(BikeBlip, Config.jobLocation[bike]["blipscale"])
            SetBlipDisplay(BikeBlip, 4)
            SetBlipColour(BikeBlip, Config.jobLocation[bike]["blipcolor"])
            SetBlipPriority(BikeBlip, Config.jobLocation[bike]["blippriority"])
            SetBlipAsShortRange(BikeBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.jobLocation[bike]["label"])
            EndTextCommandSetBlipName(BikeBlip)
        end
    end
end

-- Draw 3D Text
function Draw3DText(coords, str)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords = GetGameplayCamCoord()
	local scale = 200 / (GetGameplayCamFov() * #(camCoords - coords))
    if onScreen then
        SetTextScale(1.0, 1 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
		SetTextProportional(1)
		SetTextOutline()
		SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end

-- Ped Management
local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.jobLocation) do
        local current = v["ped"]
        local vehicle = v["veh"]
        local coords = v["spawnCoords"]
        local xPlayer = PlayerPedId()

        current = type(current) == 'string' and GetHashKey(current) or current
        vehicle = type(vehicle) == 'string' and GetHashKey(vehicle) or vehicle

        while not HasModelLoaded(vehicle) do
            Wait(0)
            RequestModel(vehicle)
        end

        while not HasModelLoaded(current) do
            Wait(0)
            RequestModel(current)
        end

        forkliftVeh[k] = CreateVehicle(vehicle, v["vehCoords"].x, v["vehCoords"].y, v["vehCoords"].z-1, v["vehCoords"].w, false, false)
        forkliftPed[k] = CreatePed(0, current, v["pedCoords"].x, v["pedCoords"].y - 0.5, v["pedCoords"].z-1, v["pedCoords"].w, false, false)

        -- Ped Freeze
        TaskStartScenarioInPlace(forkliftPed[k], v["scenario"], true)
        FreezeEntityPosition(forkliftPed[k], true)
        SetEntityInvincible(forkliftPed[k], true)
        SetBlockingOfNonTemporaryEvents(forkliftPed[k], true)
       
        -- Vehicle Freeze
        SetVehicleDoorsLocked(forkliftVeh[k], 2)
        FreezeEntityPosition(forkliftVeh[k], true)
        SetEntityInvincible(forkliftVeh[k], true)
        SetBlockingOfNonTemporaryEvents(forkliftVeh[k], true)        

        if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(forkliftPed[k], {
            options = {
                {
                    label = v["targetLabel"],
                    icon = v["targetIcon"],
                    item = v["item"],
                    action = function()

                        if currentFLJob == false then
                            QBCore.Functions.Notify(Config.jobRecived, "success")
                            startFTJob(v["forkliftCoords"], vehicle)
                        else
                            QBCore.Functions.Notify(Config.doingJob, "error")
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
        exports['qb-target']:AddTargetEntity(forkliftPed[k], {
            options = {
                {
                    label = v["targetLabel2"],
                    icon = v["targetIcon"],
                    item = v["item"],
                    action = function()

                        if currentFLJob == true then
                            currentFLJob = false
                            palletSpawned = false
                            QBCore.Functions.Notify(Config.finishedJob, "success")
                        else
                            QBCore.Functions.Notify(Config.notDoingJob, "error")
                        end

                    end,
                    job = v["job"],
                    gang = v["gang"],
                }
            },
            distance = 2.0
        })
        end

    end

    forkliftSpawned = true
    pedSpawned = true
end

function startFTJob(forkliftSP, jobVeh)
    local coords = forkliftSP
    local jobVeh = jobVeh

    jobVeh = type(jobVeh) == 'string' and GetHashKey(jobVeh) or jobVeh

    while not HasModelLoaded(jobVeh) do
        Wait(0)
        RequestModel(jobVeh)
    end

    jobForkLift = CreateVehicle(jobVeh, coords.x, coords.y, coords.z, coords.w, true, false)

    local vehicleplate = QBCore.Functions.GetPlate(jobForkLift)
    TriggerEvent('qb-vehiclekeys:client:AddKeys', vehicleplate)
    SetVehicleDoorsLocked(jobForkLift, 2)

    currentFLJob = true
    forkliftLoaded()
    jobInProgress()
end

function forkliftLoaded()
    while true do
        for k, v in pairs(Config.jobLocation) do
            local xPlayer = PlayerPedId()
            local pos = GetEntityCoords(xPlayer)
            local dist = GetDistanceBetweenCoords(pos, v["forkliftCoords"].x, v["forkliftCoords"].y, v["forkliftCoords"].z, true)

            if dist > 5 then
                DrawMarker(v["marker"], v["forkliftCoords"].x, v["forkliftCoords"].y, v["forkliftCoords"].z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.75, 0.75, 0.75, v["colourr"], v["colourg"], v["colourb"], v["coloura"], true, false, 2, nil, nil, false)
            else
                return
            end
        end
        Wait(10)
    end
end

function jobInProgress()
    while currentFLJob == true do
        for k, v in pairs(Config.jobOptions) do
            local xPlayer = PlayerPedId()
            local pos = GetEntityCoords(xPlayer)
            local dist = GetDistanceBetweenCoords(pos, v["coords"].x, v["coords"].y, v["coords"].z, true)
            local coordsPacked = vector3(v["textCoords"].x, v["textCoords"].y, v["textCoords"].z)

            if dist < 25 then
                DrawMarker(v["marker"], v["coords"].x, v["coords"].y, v["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 2.5, 2.5, 2.0, v["colourr"], v["colourg"], v["colourb"], v["coloura"], true, false, 2, nil, nil, false)
            end
        
            if dist < 5 then
                Draw3DText(coordsPacked, v["label"])
            end

            if dist < 3 then
                if v["title"] == "return" then   
                    if IsControlJustReleased(0, 38 --[[ INPUT_PICKUP ]]) then
                        returnForklift(xPlayer)
                    end
                elseif v["title"] == "getPallet" then
                    if IsControlJustReleased(0, 38 --[[ INPUT_PICKUP ]]) then
                        getPallet()
                    end
                end
            end

        end
        Wait(5)
    end
end

function getPallet()
    local random = math.random(1,6)
    local random2 = math.random(1,2)
    
    for _, v in pairs(Config.palletType) do
        local palletId = v["id"]
        local palletModel = v["label"]
        local palletMultiplier = v["multiplier"]

        palletModel = type(palletModel) == 'string' and GetHashKey(palletModel) or palletModel
        
        for _, f in pairs(Config.palletLocations) do
        local locationId = f["id"]
        local spawnMultiplier = f["multiplier"]

            if palletSpawned == false then
                if palletId == random then
                    if locationId == random2 then
                        palletObj = CreateObject(palletModel, f["coords"].x, f["coords"].y, f["coords"].z-1, f["coords"].w, true, false)

                        QBCore.Functions.Notify(Config.palletSpawned, "success")
                        palletSpawned = true
                        palletJob(palletObj, palletMultiplier, spawnMultiplier)
                    end
                end
            else
                QBCore.Functions.Notify(Config.palletAlreadyOut, "error")
                return
            end
        end
    end
end


function palletJob(palletObject, palletMultiplier, spawnMultiplier)
    local random = math.random(1,2)
    while palletSpawned == true do
        for k, v in pairs(Config.palletReturnLocations) do
            local returnId = v["id"]
            local xPlayer = PlayerPedId()
            local pos = GetEntityCoords(xPlayer)
            local palletPos = GetEntityCoords(palletObject)
            local dist = GetDistanceBetweenCoords(pos, v["coords"].x, v["coords"].y, v["coords"].z, true)
            local palletDist = GetDistanceBetweenCoords(palletPos, v["coords"].x, v["coords"].y, v["coords"].z,true)
            local returnMultiplier = v["multiplier"]
            local totalPay = (Config.basePay * palletMultiplier * returnMultiplier * spawnMultiplier)


            if returnId == random then
                if dist < 25 then
                    DrawMarker(v["marker"], v["coords"].x, v["coords"].y, v["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 2.5, 2.5, 2.0, v["colourr"], v["colourg"], v["colourb"], v["coloura"], true, false, 2, nil, nil, false)
                end

                if palletDist < 0.5 then
                    Draw3DText(palletPos, v["label"])

                    if IsControlJustReleased(0, 38) then
                        completePallet(xPlayer, palletObject, totalPay)
                    end
                end
                
            end
        end
        Wait(5)
    end
end

function returnForklift(source)
    local xPlayer = source
    local currentVeh = GetVehiclePedIsIn(xPlayer, false)

    if IsPedInModel(xPlayer, 'Forklift',true) then
        DeleteVehicle(currentVeh)
        currentFLJob = false
        palletSpawned = false
    end
end

function completePallet(source, palletObject, totalPay)
    DeleteObject(palletObject)
    palletSpawned = false
    TriggerServerEvent('forkliftJob:pay', GetPlayerServerId(PlayerId()), totalPay)

    return
end

-- Delete functions
local function deletePeds()
    if pedSpawned then
        for _, v in pairs(forkliftPed) do
            DeletePed(v)
        end
    end
end

local function deleteVeh()
    if forkliftSpawned then
        for _, v in pairs(forkliftVeh) do
            DeleteVehicle(v)
        end
    end
end

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
        currentFLJob = false
        palletSpawned = false
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        deletePeds()
        deleteVeh()
    end
end)
