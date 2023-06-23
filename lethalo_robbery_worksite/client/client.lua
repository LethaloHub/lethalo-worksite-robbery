-- Author Lethalo
-- V.0.1

QBCore = nil
local zones = {}
local objects = {}
local QBCore = exports['qb-core']:GetCoreObject()
local hasSpawn = false
local alerted = false
local policeCount = 0
local pData = nil

local function DeleteAndRemove(entity)
    for k,v in pairs(objects) do
        if v == entity then
            DeleteEntity(v)
            DeleteObject(v)
            objects[k] = nil
        end
     end
end

local function DeleteAndAdd(entity)
    for k,v in pairs(objects) do
        if v == entity then

            local model = GetEntityModel(entity)
            for i,j in pairs(Config.Items) do
                if model == GetHashKey(j) then
                    TriggerServerEvent('robbery_worksite:server:addItem',i)
                end
            end

            DeleteEntity(v)
            DeleteObject(v)
            objects[k] = nil
        end
    end
end

local function shuffleLoots(list,maxloot)
    local shuffled = {}
    for i, v in ipairs(list) do
        local pos = math.random(1, #shuffled+1)
        table.insert(shuffled, pos, v)
    end
    return {table.unpack(shuffled, 1, maxloot)}
end

local function isInsideWorksite(poly,k)
    Citizen.CreateThread(function()
        local comp = 0

        while true do
            local playerPed = PlayerPedId()
            local coord = GetEntityCoords(playerPed)
                local insideZone = poly:isPointInside(coord)

                -- Security incase job is not loaded
                if pData ~= nil and pData.job then

                    if insideZone and pData.job.name ~= 'police' and pData.job.name ~= 'ambulance' and policeCount >= Config.PoliceCount then
                        if comp == 0 and not hasSpawn then
                            TriggerEvent('QBCore:Notify',Config.Translation.FirstEntrance, "error",4000)
                            TriggerEvent('QBCore:Notify',Config.Translation.SecondEntrance, "success",4000)
                        end
                        if comp == Config.TimeWhenAlertForCameras and not hasSpawn then
                            TriggerEvent('QBCore:Notify',Config.Translation.AlertCams, "police",5000)
                        end

                        if comp >= Config.TimeWhenSpawnForObjects and not hasSpawn then
                            for _,i in pairs(shuffleLoots(Config.Spawns[k],#Config.Spawns[k]-Config.MinusTotalItem)) do
                                local temp = CreateObject(Config.Items[i.item],i.position.x,i.position.y,i.position.z,false,true,false)
                                objects[i] = temp

                                exports['qb-target']:AddTargetEntity(temp, {
                                    options = {
                                        {
                                            type = "client",
                                            action = function(entity)
                                                exports['progressbar']:Progress({
                                                    name = "RecolterChantier",
                                                    duration = 8000,
                                                    label = Config.Translation.Recolt,
                                                    useWhileDead = false,
                                                    canCancel = false,
                                                    controlDisables = {
                                                        disableMovement = true,
                                                        disableCarMovement = true,
                                                        disableMouse = false,
                                                        disableCombat = true,
                                                    },
                                                }, function(status)
                                                    if not status then
                                                        DeleteAndAdd(entity)
                                                        ClearPedTasksImmediately(GetPlayerPed(PlayerPedId()))
                                                        FreezeEntityPosition(GetPlayerPed(PlayerPedId()), false)
                                                    end
                                                end)
                                            end,
                                            icon = "fas fa-box-circle-check",
                                            label = Config.Translation.Recolt,
                                        },
                                    },
                                    distance = 2.5
                                })

                                Citizen.CreateThread(function()
                                    local index = i
                                    while objects[index] ~= nil do

                                        local th_playerPed = PlayerPedId()
                                        local th_coord = GetEntityCoords(playerPed)
                                        if #(th_coord - vector3(i.position.x,i.position.y,i.position.z)) <= 6.0 then
                                            DrawMarker(Config.MarkerType, i.position.x,i.position.y,i.position.z+1.2, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 0, 0, 100, false, true, 2, false, false, false, false)
                                            Wait(1)
                                        else
                                            Wait(1000)
                                        end
                                    end
                                end)
                                FreezeEntityPosition(temp, true)
                                SetEntityAsMissionEntity(temp)
                            end

                            -- When every objects have spawned, set this bol to true
                            -- > Disable, notify

                            hasSpawn = true
                        end

                        if comp == Config.SendDispatchToCops and not alerted then
                            if Config.UsePsDispatch then
                                exports["ps-dispatch"]:CustomAlert({
                                    coords = vector3(coord.x, coord.y, coord.z),
                                    message = "Intrusion zone restreinte",
                                    dispatchCode = "10-27",
                                    description = "Des caméras ont répérer un intru",
                                    radius = 10,
                                    sprite = 465,
                                    color = 5,
                                    scale = 1.0,
                                    length = 3,
                                })
                            else
                                --CustomAlert Here
                            end
                            alerted = true
                        end

                        comp = comp + 1
                    else
                        if comp > 0 and hasSpawn then
                            comp = 0
                            TriggerEvent('QBCore:Notify',"Vous quittez la zone, les employés commencent à ranger...", "error",5000)
                            Citizen.SetTimeout(60*1000*Config.StayTime, function()
                                for _,v in pairs(objects) do
                                    DeleteAndRemove(v)
                                end
                                TriggerEvent('QBCore:Notify',"Les employées ont ranger", "success",5000)
                            end)
                            Citizen.SetTimeout(60*1000*Config.RespawnTime, function()
                                hasSpawn = false
                                alerted = false
                            end)
                        end
                    end

                end

                Citizen.Wait(1000)
        end
    end)
end

local function LoadModel(modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(0)
    end
end

Citizen.CreateThread(function()

    for _,v in pairs(Config.Items) do
        LoadModel(v)
    end

    for k,v in pairs(Config.Zones) do
        zones[k] = PolyZone:Create(v.dots,v.options)
        isInsideWorksite(zones[k],k)
    end

    while true do
        QBCore.Functions.TriggerCallback('robbery_worksite:server:getPoliceCount', function(count)
            policeCount = count
        end)
        pData = QBCore.Functions.GetPlayerData()
        Citizen.Wait(30000)
    end

end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            for _,v in pairs(objects) do
               DeleteEntity(v)
               DeleteObject(v)
            end
        end)
    end
end)