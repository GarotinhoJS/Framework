local cloudOpacity = 0.01
local muteSound = true
function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end
function InitialSetup()
    SetManualShutdownLoadingScreenNui(true)
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 0, 1)
    end
end
function DrawTextOnScreen(x, y, width, height, scale, text, r, g, b, a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end
InitialSetup()
Citizen.CreateThread(function()
    InitialSetup()
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end
    ShutdownLoadingScreen()
    ClearScreen()
    Citizen.Wait(0)
    DoScreenFadeOut(0)
    ShutdownLoadingScreenNui()
    ClearScreen()
    Citizen.Wait(0)
    ClearScreen()
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
        ClearScreen()
    end
    local timer = GetGameTimer()
    ToggleSound(false)
    while true do
        ClearScreen()
        Citizen.Wait(0)
        DrawTextOnScreen(0.80, 1.4, 1.0, 1.0, 0.6, "Appuyez sur ~g~ESPACE~w~ pour valider votre entrée.", 255, 255, 255, 255, false)
        if IsControlJustPressed(0, 76) then
        if GetGameTimer() - timer > 5000 then
            SwitchInPlayer(PlayerPedId())
            ClearScreen()
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end
            break
        end
    end
    end
    ClearDrawOrigin()
end)