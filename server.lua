local QBCore = exports['qb-core']:GetCoreObject()
local Lang = {}

-- Load locale file dynamically
CreateThread(function()
    if Config.Locale == "nl" then
        Lang = Locales['nl']
    else
        Lang = Locales['en']
    end
end)

RegisterNetEvent("qb_trajectcontrole:checkSpeed", function(zoneName, elapsed, direction)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local zone
    for _, z in pairs(Config.Zones) do
        if z.name == zoneName then zone = z break end
    end
    if not zone then return end

    local distance = #(zone.finish - zone.start)
    local avgSpeed = (distance / elapsed) * 3.6
    local overLimit = avgSpeed - zone.limit
    local fineAmount = zone.fine

    if avgSpeed > (zone.limit + zone.tolerance) then
        if zone.dynamicFine then
            fineAmount = math.floor(zone.fine + (overLimit * zone.finePerKm))
        end
        if fineAmount < zone.minFine then fineAmount = zone.minFine end
        if fineAmount > zone.maxFine then fineAmount = zone.maxFine end

        Player.Functions.RemoveMoney("bank", fineAmount, "Trajectcontrole boete")

        if Config.EnableFlash then
            local flashCoords = zone.finish
            if direction == "BtoA" then
                flashCoords = zone.start
            end
            TriggerClientEvent("qb_trajectcontrole:flash", src, flashCoords)
        end

        TriggerClientEvent("QBCore:Notify", src, (Lang.speed_fine):format(avgSpeed, zone.limit, fineAmount), "error")
    else
        TriggerClientEvent("QBCore:Notify", src, (Lang.speed_ok):format(avgSpeed, zone.limit), "success")
    end
end)
