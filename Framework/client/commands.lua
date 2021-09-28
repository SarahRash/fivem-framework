Citizen.CreateThread(function()

  TriggerEvent('chat:addSuggestion', '/logout', 'Goes back to character creation screen.', {
    { name="", help="Enter your message"},
  })

  TriggerEvent('chat:addSuggestion', '/me', 'Displays a action state to users around you. (Local)', {
    { name="Action", help="action" },
  })

  -- Disabled because using SEM_Interaction menu would make for a cleaner look.
  -- TriggerEvent('chat:addSuggestion', '/mer', 'Same as /me however text is red. (Local)', {
  --   { name="Action", help="action" },
  -- })

  TriggerEvent('chat:addSuggestion', '/gme', 'Send message in the third person (Global).', {
    { name="Action", help="action" },
  })

  TriggerEvent('chat:addSuggestion', '/ooc', 'Displays OOC message to everyone. (Global)', {
    { name="Message", help="Out of character message" },
  })

  TriggerEvent('chat:addSuggestion', '/id', 'Sends ID to nearby players only. (Local)', {
    { name="msg", help="Event" },
  })

  -- TriggerEvent('chat:addSuggestion', '/news', 'Send out News across the entire Server. (Global)', {
  --   { name="msg", help="Enter your message" },
  -- })

  TriggerEvent('chat:addSuggestion', '/vpn', 'Send a anonymous message in game. (Global)', {
    { name="Message", help="Anonymous Message."}
  })
  
  TriggerEvent('chat:addSuggestion', '/twt', 'Sends a twotter message in game. (Global)', {
    { name="Message", help="Twotter Post."}
  })

  TriggerEvent('chat:addSuggestion', '/darkweb', 'Sends a message to the darkweb. (Global)', {
    { name="Message", help="Darkweb Message."}
  })
end)

--------------------------------------------------------------------------------------------------------

RegisterCommand("me", function(source, args)
  local msg = table.concat(args, " ")
  local closestPlayers = DOSProx.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 20.0)
  for k,v in pairs(closestPlayers) do
    DOS.Server.SendMe(GetPlayerServerId(v), msg)
  end
end)

-- RegisterCommand("mer", function(source, args)
--   local msg = table.concat(args, " ")
--   local closestPlayers = DOSProx.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 20.0)
--   for k,v in pairs(closestPlayers) do
--     DOS.Server.SendMer(GetPlayerServerId(v), msg)
--   end
-- end)

RegisterCommand("gme", function(source, args)
  local msg = table.concat(args, " ")
  local closestPlayers = DOSProx.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 101001000000.0)
  for k,v in pairs(closestPlayers) do
    DOS.Server.SendGme(GetPlayerServerId(v), msg)
  end
end)

RegisterCommand("id", function(source, args)
  local closestPlayers = DOSProx.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 20.0)
  for k,v in pairs(closestPlayers) do
    DOS.Server.SendID(GetPlayerServerId(v))
  end
end)

RegisterCommand("twt", function(source, args)
  local msg = table.concat(args, " ")
  local closestPlayers = DOSProx.GetPlayersInArea(GetEntityCoords(PlayerPedId(), false), 101001000000.0)
  for k,v in pairs(closestPlayers) do
    DOS.Server.SendTwt(GetPlayerServerId(v), msg)
  end
end)

RegisterCommand('logout', function()
  LoadCharacters()
end, false)