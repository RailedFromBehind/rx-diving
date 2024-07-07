local QBCore = exports['qb-core']:GetCoreObject()

local materials = {
    [1] = ('glass'),
    [2] = ('rubber'),
    [3] = ('steel'),
    [4] = ('aluminum'),
    [5] = ('metalscrap'),
}

local specialItem = 'goldbar'


RegisterNetEvent('rx-diving:server:giveDivingRewards', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local randomMaterial = (materials[math.random(#materials)])
    local chance = math.random(1, 100)
    local amountEachPickup = math.random(1, 3)

    if chance <= 100 and chance >= 30 then
        Player.Functions.AddItem(randomMaterial, amountEachPickup)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        TriggerClientEvent('QBCore:Notify', src, 'You Found x' .. amountEachPickup .. " " .. randomMaterial, 'success')
    elseif chance < 10 and chance >= 1 then
        Player.Functions.AddItem(specialItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        TriggerClientEvent('QBCore:Notify', src, 'You Found ' .. specialItem, 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Found Nothing', 'error')
    end
    
end)
