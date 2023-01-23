Hud = {}
Hud.Round = function(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
Hud.Start = function(hudUpdate, cb)
    CreateThread(function()
        local status = {  }
        local statusLabels = { 'hunger', 'thirst' }
        hudUpdate = hudUpdate or true
        while (hudUpdate) do 
            for k, v in pairs(statusLabels) do
                TriggerEvent('esx_status:getStatus', v, function(s)
                    status[v] = Hud.Round(s.val / 10000)
                end)
            end
            status['health'] = Hud.Round(GetEntityHealth(PlayerPedId()) - 100)
            status['shield'] = Hud.Round(GetPedArmour(PlayerPedId()))
            SendNUIMessage({
                type = 'updateHud',
                map = IsPauseMenuActive() == 1,
                radar = IsRadarEnabled() == 1,
                status = status
            })
            DisplayRadar(IsPedInAnyVehicle(PlayerPedId()))
            Wait(1000)
        end
    end)
    if (cb) then
        cb()
    end
end
Hud.Stop = function()
    return Hud.Start(false, function()
        SendNUIMessage({
            type = 'updateHud',
            map = false,
            radar = false,
            status = {  }
        })
    end)
end