if (Settings and Settings.ByEvent.bool) then 
    local event = Settings.ByEvent.events
    RegisterNetEvent(event[1], Hud.Start)
    RegisterNetEvent(event[2], Hud.Stop)
else
    Hud.Start()
end