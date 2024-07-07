local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('rx-diving:server:giveItem', function(randomMaterial, randomAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = randomMaterial
    local amount = randomAmount

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
end)
