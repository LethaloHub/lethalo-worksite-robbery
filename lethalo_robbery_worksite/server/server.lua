QBCore = nil
local QBCore = exports['qb-core']:GetCoreObject()
local object = nil

RegisterNetEvent('robbery_worksite:server:addItem')
AddEventHandler('robbery_worksite:server:addItem', function(item)
    if Config.Inventory == 'qs-inventory' then
        if exports['qs-inventory']:AddItem(source, item, 1) then
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", 1)
        else
            TriggerClientEvent('QBCore:Notify', source, "Vous êtes encombrer", "error") -- Too Heavy
        end
    elseif Config.Inventory == 'qb-inventory' then
        if exports['qb-inventory']:AddItem(source, item, 1) then
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", 1)
        else
            TriggerClientEvent('QBCore:Notify', source, "Vous êtes encombrer", "error") -- Too Heavy
        end
    end
end)

QBCore.Functions.CreateCallback('robbery_worksite:server:getPoliceCount', function(_, cb)
    local policePlayers = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, v in pairs(players) do
        if v and v.PlayerData.job.name == "police" then
            policePlayers = policePlayers + 1
        end
    end
    cb(policePlayers)
end)