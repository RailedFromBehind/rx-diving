local QBCore = exports['qb-core']:GetCoreObject()

local checkStuff = false

local divingSite = vector3(3178.4299316406,-356.15112304688,0.4938257932663)




local divingMaterialSpot = {
    [1] = vector3(3195.5869140625,-388.41351318359,-31.486166000366),
    [2] = vector3(3210.2219238281,-391.32678222656,-39.039096832275),
    [3] = vector3(3205.5192871094,-418.4719543457,-35.239002227783),
    [4] = vector3(3176.3212890625,-383.54284667969,-28.939447402954),
    [5] = vector3(3176.2272949219,-349.91976928711,-27.238439559937),
    [6] = vector3(3167.5090332031,-342.87051391602,-29.037427902222),
    [7] = vector3(3167.0346679688,-317.35235595703,-17.338794708252),
    [8] = vector3(3175.3071289062,-314.95358276367,-27.234449386597),
    [9] = vector3(3173.1677246094,-292.05233764648,-13.237914085388),
    [10] = vector3(3164.0666503906,-292.46243286133,-9.8391904830933),
    [11] = vector3(3161.3835449219,-319.38403320312,-7.5401167869568),
    [12] = vector3(3147.2414550781,-278.57275390625,-10.438452720642),
    [13] = vector3(3148.0544433594,-279.91598510742,-24.639511108398),
    [14] = vector3(3158.5910644531,-275.22225952148,-26.838846206665),
    [15] = vector3(3136.3620605469,-239.09652709961,-25.038454055786),
    [16] = vector3(3162.2995605469,-259.06661987305,-26.738998413086),
    [17] = vector3(3197.2004394531,-395.84091186523,-26.442941665649)
}



-- Blip --
local function createBlips()
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(divingSite)
        SetBlipSprite(blip, 274)
        SetBlipDisplay(blip, 6)
        SetBlipScale(blip, 0.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Wrecked Ship")
        SetBlipAsShortRange(blip, true)
        EndTextCommandSetBlipName(blip)
    end)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createBlips()
end)

-- End Blip --

local function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
end


CreateThread(function()
    local divingZone = BoxZone:Create(vector3(3133.3733, -354.1701, 4.7429), 4.0, 4.0, {
        name="diving_zone",
        offset = {0.0, 0.0, 0.0},
        scale = {100.0, 50.0, 5.0},
        debugPoly = false,
    })

    divingZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            checkStuff = true
            print("In Zone")
            StartDivingLoopInZone()
        end
    end)
end)



function StartDivingLoopInZone()
    Citizen.CreateThread(function()
        local matspot = (divingMaterialSpot[math.random(#divingMaterialSpot)])
        while checkStuff do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            if IsPedSwimmingUnderWater(playerPed) then
                DrawText3Ds(matspot.x, matspot.y, matspot.z, "[E] Pick-Up materials")
                if IsControlJustReleased(1, 38) and #(playerCoords - matspot) < 1.5 then
                    TriggerServerEvent("rx-diving:server:giveDivingRewards")
                    matspot = (divingMaterialSpot[math.random(#divingMaterialSpot)])
                end
            end
        end
    end)
end



