Citizen.CreateThread(function()
    while true do
        
        --properties
        local name = GetPlayerName(PlayerId())
        local id = GetPlayerServerId(PlayerId())
        local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player))))
        local vehicle = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
        local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
        local NumberOfPlayers = 0

        for i = 0, 255 do
            if NetworkIsPlayerActive(i) then
                NumberOfPlayers = NumberOfPlayers + 1
            end
        end

        --game status app
        SetDiscordAppId(871988959213924412)

        --logo icon
        SetDiscordRichPresenceAsset('icon')
        SetDiscordRichPresenceAssetText('San Andreas Life | V2')

        --buttons
        SetDiscordRichPresenceAction(0, '[SAL] Discord', 'https://discord.gg/6udv7G8vDb')
        -- SetDiscordRichPresenceAction(1, 'Google Me', 'https://www.google.com/')

        --small icon
        SetDiscordRichPresenceAssetSmall('verified')
        SetDiscordRichPresenceAssetSmallText('Verified by: Solutions Inc.')

        --loop for rich presense change

         SetRichPresence('Players: ' .. NumberOfPlayers)
         Wait(5*1000)
         SetRichPresence('ID: ' .. id)
         Wait(5*1000)
         SetRichPresence('IGN: ' .. name)
         Wait(5*1000)
         SetRichPresence('SAL Framework')
         Wait(7*1000)


        --updates every selected seconds 
        Citizen.Wait(10000)
    end
end)
