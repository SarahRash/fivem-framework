-- Me comamnd example: /me Places cuffs on suspect
DOS.SendMe = function (target, msg)
    local src = source
    local char = DOSProx.GetCharacter(src)
    TriggerClientEvent('chatMessage', target, "^3> [Proximity] ^7" .. char.char_name .. " (" .. char.dept .. ") (#" .. source .. ")", {255,255,255}, msg)
end

-- Below is a me command that outputs the text red instead of the normal white.
-- Me command in red example: /mer Places cuffs on suspect
-- DOS.SendMer = function (target, msg)
--     local src = source
--     local char = DOSProx.GetCharacter(src)
--     TriggerClientEvent('chatMessage', target, "^3> ^7" .. char.char_name .. " (" .. char.dept .. ") (#" .. source .. ")", {255,255,255}, '^1' .. msg)
-- end

-- Global me command (everyone can see this) example: /gme Checks CCTV Camera's
DOS.SendGme = function (target, msg)
    local src = source
    local char = DOSProx.GetCharacter(src)
    TriggerClientEvent('chatMessage', target, "^3> [Global] ^7" .. char.char_name .. " (" .. char.dept .. ") (#" .. source .. ")", {255,255,255}, msg)
end

DOS.SendTwt = function (target, msg)
    local src = source
    local char = DOSProx.GetCharacter(src)
    TriggerClientEvent('chatMessage', target, "^*^5 [Twotter] ^7 " .. char.char_name .. " (" .. char.dept .. ") (#" .. source .. ") ^r", {4, 134, 255}, msg)
end

-- ID Comand will in a radios of a few meters show a text message with your current characters name
DOS.SendID = function (target)
    local src = source
    local char = DOSProx.GetCharacter(src)
    TriggerClientEvent('chatMessage', target, "^*^5[ID]^7 " .. char.char_name .. " (" .. char.dept .. ") (#".. src ..")")
end

---------------------------------------------------------------------------------------------------------------------------------

-- OOC / Default chat | If you have default chat disabled use /ooc othersie normal chat has the same purpose
RegisterCommand("ooc", function(source, args)
    local src = source
    local message = table.concat(args, " ")    
    TriggerClientEvent('chatMessage', -1, "^*[OOC] " .. GetPlayerName(source) .. "(#" .. source .. ") ^r", {255, 165, 0}, table.concat(args, " "))
end)

-- News (Disabled) You can use SEM_Interaction menu instead.
-- RegisterCommand('news', function(source, args, user)
--     TriggerClientEvent('chatMessage', -1, "^*[News]^r", {0,0,255}, table.concat(args, " "))
--     end, 
-- false)

RegisterCommand('darkweb', function(source, args, user)
	TriggerClientEvent('chatMessage', -1, "^*[^*DarkWeb] @^*Anonymous^r", {128,128,128}, table.concat(args, " "))
	end, 
false)

--VPN command will send a message globally as a hidden user.
RegisterCommand('vpn', function(source, args, user)
	TriggerClientEvent('chatMessage', -1, "^*[^*VPN] @^*Anonymous^r", {128,128,128}, table.concat(args, " "))
	end, 
false)