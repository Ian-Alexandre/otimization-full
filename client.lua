local currentLevel = "off"

CreateThread(function()
    while true do
        Wait(1000)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if currentLevel ~= "off" then
            RemoveParticleFxInRange(coords, 200.0)
            RemoveParticleFxFromEntity(ped)
            SetDisableDecalRenderingThisFrame()
        end

        if currentLevel == "baixo" then
            SetLodscaleOverride(0.8)
            SetReduceVehicleModelBudget(true)
            SetReducePedModelBudget(true)
            SetFlashLightFadeDistance(10.0)
        elseif currentLevel == "medio" then
            SetLodscaleOverride(0.5)
            SetReduceVehicleModelBudget(true)
            SetReducePedModelBudget(true)
            SetFlashLightFadeDistance(5.0)
            DisableFarDrawVehicles(true)
            SetReflectionEffectRefract(false)
        elseif currentLevel == "max" then
            SetLodscaleOverride(0.3)
            SetReduceVehicleModelBudget(true)
            SetReducePedModelBudget(true)
            SetFlashLightFadeDistance(0.0)
            DisableFarDrawVehicles(true)
            SetReflectionEffectRefract(false)
            SetLightsCutoffDistanceTweak(0.0)

            SetTimecycleModifier("CAMERA_secuirity")
            SetTimecycleModifierStrength(0.1)
            SetWeatherTypePersist("EXTRASUNNY")
            SetWeatherTypeNowPersist("EXTRASUNNY")
            SetWeatherTypeNow("EXTRASUNNY")
            ClearOverrideWeather()
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        if currentLevel ~= "off" then
            SetNightvision(false)
            SetSeethrough(false)
            SetNoiseoveride(false)

            if currentLevel == "max" then
                DisableFarDrawVehicles(true)
            end
        end
    end
end)

RegisterCommand("dllboost", function(source, args)
    local arg = string.lower(args[1] or "")

    if arg == "baixo" or arg == "medio" or arg == "max" then
        currentLevel = arg
        notify("🟢 Otimização ativada: nível " .. arg)
    elseif arg == "off" then
        currentLevel = "off"
        ClearTimecycleModifier()
        SetLodscaleOverride(1.0)
        DisableFarDrawVehicles(false)
        SetLightsCutoffDistanceTweak(25.0)
        SetFlashLightFadeDistance(10.0)
        notify("🔴 Otimização desativada.")
    else
        notify("ℹ️ Use: /dllboost baixo | medio | max | off")
    end
end)

function notify(msg)
    print("^2[DLL BOOST]^7 " .. msg)
end
