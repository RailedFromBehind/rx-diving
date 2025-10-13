local QBCore = exports['qb-core']:GetCoreObject()

local materials = {
    [1] = ('glass'),
    [2] = ('rubber'),
    [3] = ('steel'),
    [4] = ('aluminium'),
    [5] = ('metalscrap'),
}


RegisterNetEvent('rx-diving:server:CheckCanRevieveReward', function(x, y, z)

    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local matspot = vector3(x, y, z)
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    local dist = #(matspot - playerCoords)

    if dist > 5.0 then
        print(("^1[rx-diving]^0 " .. GetPlayerName(src) .. "[%s] tried to trigger reward too far away (%.2f m)"):format(src, dist))
        return
    end


    local specialItem = 'goldbar'
    local randomMaterial = (materials[math.random(#materials)])
    local chance = math.random(1, 100)

    if chance <= 100 and chance >= 30 then
        Player.Functions.AddItem(randomMaterial, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomMaterial], "add")
    elseif chance <= 1 then
        Player.Functions.AddItem(specialItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[specialItem], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Found Nothing', 'error')
    end
    
end)
