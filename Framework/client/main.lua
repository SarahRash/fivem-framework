local Tunnel = Module(GetCurrentResourceName(), 'shared/modules/Tunnel')
local Proxy = Module(GetCurrentResourceName(), 'shared/modules/Proxy')

DOS = {}
DOS.Player = {}
DOS.Player.Data = {}
DOS.Server = Tunnel.getInterface('dos')
DOSProx = {}

local Spawned = false
AddEventHandler('playerSpawned', function()
    if not Spawned then 
        LoadCharacters()
        Spawned = true
    end
end)

function LoadCharacters()
    TriggerEvent('chat:clear')
    InitialSetup()
    SetEntityVisible(PlayerPedId(), false)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open"
    })
    local chars, levels = DOS.Server.GetCharacters()
    SendNUIMessage({
        action = "setChars",
        chars = chars,
        levels = levels,
        maxchars = Config.MaxCharacters
    })
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
end

RegisterNUICallback('disconnect', function()
    DOS.Server.Disconnect()
end)

RegisterNUICallback('deleteCharacter', function(data)
    DOS.Server.DeleteCharacter(data.char.id)
end)

RegisterNUICallback('createCharacter', function(data)
    DOS.Server.CreateCharacter(data)
end)

RegisterNUICallback('editCharacter', function(data)
    DOS.Server.EditCharacter(data)
end)

RegisterNUICallback('refresh', function(data)
    DOS.RefreshChars()
end)

RegisterNUICallback('getSpawns', function(data)
    SendNUIMessage({
        action = "setSpawns",
        spawns = Config.Spawns[data.char.dept]
    })
end)

RegisterNUICallback('spawn', function(data)
    SetEntityVisible(PlayerPedId(), true)
    DOS.Player.Data = data.char
    DOS.Server.SelectCharacter(data.char)
    TriggerEvent('dos:updateDept', data.char.dept)
    local ped = PlayerPedId()
    SetNuiFocus(false, false)
    InitialSetup()
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end
    ClearScreen()
    Citizen.Wait(0)
    DoScreenFadeOut(0)
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
    FreezeEntityPosition(ped, true)
    SetEntityCoords(ped, data.spawn.x, data.spawn.y, data.spawn.z)
    local timer = 5
    while timer > 0 do
        timer = timer - 1
        Citizen.Wait(1000)
    end
    FreezeEntityPosition(ped, false)
    while true do
        ClearScreen()
        Citizen.Wait(0)
        if GetGameTimer() - timer > 2000 then 
            SwitchInPlayer(PlayerPedId())
            ClearScreen()
            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end
            break
        end
    end
    
    ClearDrawOrigin()
end)

DOS.RefreshChars = function ()
    local chars, levels = DOS.Server.GetCharacters()
    SendNUIMessage({
        action = "setChars",
        chars = chars,
        levels = levels,
        maxchars = Config.MaxCharacters
    })
end

DOSProx.GetDept = function ()
    return DOS.Player.Data.dept
end

Tunnel.bindInterface('dos', DOS)
Proxy.addInterface('dos', DOSProx)

-- Spawn Thingy

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
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 0, 1)
    end
end

function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

if (Config.DebugMode) then 
    Citizen.CreateThread(function ()
        SetNuiFocus(false, false)
    end)
end