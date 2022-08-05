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

local jobBlipId = {}
local jobBlip = false

local returnVehicleId = {}
local returnVehiclePed = {}
local returnVehicleIn = false

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

function addMissionBlip(x, y, z)
	local blipId = 0
	blipId = AddBlipForCoord(x, y, z)
	SetBlipRoute(blipId, true)
	return blipId
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
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "shiftyclick", 1)
                            QBCore.Functions.Notify(Config.jobRecived, "success")
                            startFTJob(v["forkliftCoords"], vehicle)
                        else
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.5)
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
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "shiftyclick", 1)
                            QBCore.Functions.Notify(Config.finishedJob, "success")
                        else
                            TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.5)
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

    Wait(250)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.25)

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
        Wait(1)
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
                    if IsControlJustReleased(0, 38) then
                        returnForklift(xPlayer)
                    end
                elseif v["title"] == "getPallet" then
                    if IsControlJustReleased(0, 38) then
                        getPallet()
                    end
                end
            end

        end
        Wait(1)
    end
end

function getPallet()
    local random = math.random(1,5)
    local random2 = math.random(1,83)
    
    for _, v in pairs(Config.palletType) do
        local palletId = v["id"]
        local palletModel = v["label"]

        palletModel = type(palletModel) == 'string' and GetHashKey(palletModel) or palletModel
        
        for _, f in pairs(Config.palletLocations) do
        local locationId = f["id"]
        local spawnMultiplier = f["multiplier"]

            if palletSpawned == false then
                if palletId == random then
                    if locationId == random2 then
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "shiftyclick", 1)
                        palletObj = CreateObject(palletModel, f["coords"].x, f["coords"].y, f["coords"].z, true, true, false)
                        SetEntityHeading(palletObj, f["coords"].w)

                        local palletCoords = GetEntityCoords(palletObj)

                        QBCore.Functions.Notify(Config.palletSpawned, "success")
                        palletSpawned = true

                        palletLoaded(palletCoords, random2)
                        palletJob(palletObj, spawnMultiplier)
                    end
                end
            else
                QBCore.Functions.Notify(Config.palletAlreadyOut, "error")
                return
            end
        end
    end
end

function palletLoaded(palletCoords, location)
    while true do
        for k, v in pairs(Config.palletLocations) do
            local locationId = v["id"]
            local xPlayer = PlayerPedId()
            local pos = GetEntityCoords(xPlayer)
            local dist = GetDistanceBetweenCoords(pos, palletCoords.x, palletCoords.y, palletCoords.z, true)

            if locationId == location then
                if dist > 5 then
                    DrawMarker(Config.LocationMarker, v["coords"].x, v["coords"].y, v["coords"].z + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.75, 0.75, 0.75, Config.locationColourR, Config.locationColourG, Config.locationColourB, Config.locationColourA, true, false, 2, nil, nil, false)
                    
                    createJobBlip(v["coords"].x, v["coords"].y, v["coords"].z)
                else
                    jobBlip = false
                    RemoveBlip(jobBlipId)
                    ClearAllBlipRoutes()
                    return
                end
            end
        end
        Wait(1)
    end
end

function palletJob(palletObject, spawnMultiplier)
    local random = math.random(1,2)

    while palletSpawned == true do
        for k, v in pairs(Config.palletReturnLocations) do
            local returnId = v["id"]
            local xPlayer = PlayerPedId()
            local pos = GetEntityCoords(xPlayer)
            local palletPos = GetEntityCoords(palletObject)
            local dist = GetDistanceBetweenCoords(pos, v["coords"].x, v["coords"].y, v["coords"].z, true)
            local palletDist = GetDistanceBetweenCoords(palletPos, v["coords"].x, v["coords"].y, v["coords"].z,true)
            local returnVehicle = v["vehicle"]
            local totalPay = (Config.basePay * spawnMultiplier)

            returnVehicle = type(returnVehicle) == 'string' and GetHashKey(returnVehicle) or returnVehicle

            if returnId == random then

                createJobBlip(v["coords"].x, v["coords"].y, v["coords"].z)

                createReturnVehicle(returnVehicle, v["vehCoords"].x, v["vehCoords"].y, v["vehCoords"].z, v["vehCoords"].w)

                if dist < 25 then
                    DrawMarker(v["marker"], v["coords"].x, v["coords"].y, v["coords"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 180.0, 2.5, 2.5, 2.0, v["colourr"], v["colourg"], v["colourb"], v["coloura"], true, false, 2, nil, nil, false)
                end

                if palletDist < 0.5 then
                    Draw3DText(palletPos, v["label"])

                    jobBlip = false
                    RemoveBlip(jobBlipId)
                    ClearAllBlipRoutes()

                    if IsControlJustReleased(0, 38) then
                        TaskVehicleDriveToCoordLongrange(returnVehiclePed, returnVehicleId, 493.47, -3390.27, 6.07, 100, 447, 20);
                        completePallet(xPlayer, palletObject, totalPay)
                    end
                end
                
            end
        end
        Wait(1)
    end
end

function createJobBlip(x, y, z)

    if not jobBlip then
        jobBlipId = addMissionBlip(x, y, z)
        jobBlip = true
    end

end

function returnForklift(source)
    local xPlayer = source
    local currentVeh = GetVehiclePedIsIn(xPlayer, false)

    if IsPedInModel(xPlayer, 'Forklift',true) then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "shiftyclick", 1)
        DeleteVehicle(currentVeh)
        currentFLJob = false
        palletSpawned = false
        jobBlip = false
        QBCore.Functions.Notify(Config.forkliftReturned, "success")
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.5)
        QBCore.Functions.Notify(Config.noForklift, "error")
    end
end

function createReturnVehicle(returnVehicle, x, y, z, w)
    if returnVehicleIn == false then
        while not HasModelLoaded(returnVehicle) do
            Wait(0)
            RequestModel(returnVehicle)
        end

        returnVehicleId = CreateVehicle(returnVehicle, x, y, z, w, true, false)
        returnVehiclePed = CreatePedInsideVehicle(returnVehicleId, 0, "s_m_m_trucker_01", -1, true, false)

        returnVehicleIn = true
    else
        return
    end
end

function completePallet(source, palletObject, totalPay)
    palletCollected = false
    DeleteObject(palletObject)
    palletSpawned = false
    returnVehicleIn = false
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
