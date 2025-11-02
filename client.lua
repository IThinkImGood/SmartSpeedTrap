local startTimes = {}

CreateThread(function()
    for _, pole in pairs(Config.Poles) do
        local obj = CreateObject(GetHashKey(Config.CameraModel), pole.coords.x, pole.coords.y, pole.coords.z - 1.0, false, false, false)
        SetEntityHeading(obj, pole.heading)
        FreezeEntityPosition(obj, true)
    end
end)

RegisterNetEvent("qb_trajectcontrole:flash", function(coords)
    if not Config.EnableFlash then return end

    AnimpostfxPlay("ExplosionJosh3", Config.FlashDuration, false)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", Config.FlashShake)

    local light = CreateObject(`prop_flare_01b`, coords.x, coords.y, coords.z + 2.0, false, false, false)
    SetEntityAlpha(light, 0, false)
    SetEntityAsMissionEntity(light, true, true)

    DrawLightWithRange(coords.x, coords.y, coords.z + 2.0,
        Config.FlashLightColor.r, Config.FlashLightColor.g, Config.FlashLightColor.b,
        Config.FlashRadius, Config.FlashIntensity)

    Wait(Config.FlashDuration)
    DeleteEntity(light)
    StopScreenEffect("SwitchShortNeutralIn")
end)

CreateThread(function()
    while true do
        Wait(500)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local pos = GetEntityCoords(ped)
            for _, zone in pairs(Config.Zones) do
                if #(pos - zone.start) < 15.0 then
                    startTimes[zone.name .. "_A"] = GetGameTimer()
                end
                if #(pos - zone.finish) < 15.0 then
                    startTimes[zone.name .. "_B"] = GetGameTimer()
                end

                if #(pos - zone.finish) < 15.0 and startTimes[zone.name .. "_A"] then
                    local elapsed = (GetGameTimer() - startTimes[zone.name .. "_A"]) / 1000.0
                    TriggerServerEvent("qb_trajectcontrole:checkSpeed", zone.name, elapsed, "AtoB")
                    startTimes[zone.name .. "_A"] = nil
                end

                if #(pos - zone.start) < 15.0 and startTimes[zone.name .. "_B"] then
                    local elapsed = (GetGameTimer() - startTimes[zone.name .. "_B"]) / 1000.0
                    TriggerServerEvent("qb_trajectcontrole:checkSpeed", zone.name, elapsed, "BtoA")
                    startTimes[zone.name .. "_B"] = nil
                end
            end
        end
    end
end)
