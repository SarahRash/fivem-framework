local Proxy = Module(GetCurrentResourceName(), 'shared/modules/Proxy')
local Tunnel = Module(GetCurrentResourceName(), 'shared/modules/Tunnel')

DOS = {}
DOSProx = {}
DOS.Characters = {}
DOS.Client = Tunnel.getInterface('dos')

DOS.GetCharacters = function ()
    local src = source
    local license
    for key, value in pairs(GetPlayerIdentifiers(src)) do
        if string.match(value, "license:") then
            license = value
			break
		end
    end

    local chars = {}
    local loaded = false
    MySQL.Async.fetchAll("SELECT * FROM chars WHERE license=@license", 
    {
        ["@license"] = license
    }, function(data)
        chars = data
        loaded = true
    end)

    while not loaded do 
        Wait(1)
    end

    local levels = {}
    local roles = GetRoles(src)
    local hasAdmin = false
    if roles then 
        for k,user_role in pairs(roles) do 
            for key, value in pairs(Config.AdminRoleIds) do
                if user_role == value then 
                    hasAdmin = true
                    break
                end
            end
            if hasAdmin then 
                for k2,dept_role in pairs(Config.Departments) do 
                    levels[k2] = true 
                end
                break
            else 
                for k2,dept_role in pairs(Config.Departments) do 
                    if user_role == dept_role then 
                        levels[k2] = true 
                    end
                end
            end
        end
    else 
        for k2,dept_role in pairs(Config.Departments) do 
            levels[k2] = false 
        end
    end

    return chars,levels
end

DOS.Disconnect = function()
    DropPlayer(source, 'Disconnected.')
end

DOS.DeleteCharacter = function(char_id)
    local src = source
    local license
    for key, value in pairs(GetPlayerIdentifiers(src)) do
        if string.match(value, "license:") then
            license = value
			break
		end
    end

    MySQL.Async.execute("DELETE FROM chars WHERE id=@id AND license=@license", 
    {
        ["@license"] = license,
        ["@id"] = char_id
    }, function()
        DOS.Client.RefreshChars(src)
    end)
end

DOS.CreateCharacter = function(char)
    local src = source
    local license
    for key, value in pairs(GetPlayerIdentifiers(src)) do
        if string.match(value, "license:") then
            license = value
			break
		end
    end

    MySQL.Async.execute("INSERT INTO chars (license, char_name, dob, gender, dept) VALUES (@license, @name, @dob, @gender, @dept)", 
    {
        ["@license"] = license,
        ["@name"] = char.name,
        ["@dob"] = char.dob,
        ["@gender"] = char.gender,
        ["@dept"] = char.dept 
    }, function()
        DOS.Client.RefreshChars(src)
    end)
end

DOS.EditCharacter = function(char)
    local src = source
    local license
    for key, value in pairs(GetPlayerIdentifiers(src)) do
        if string.match(value, "license:") then
            license = value
			break
		end
    end

    MySQL.Async.execute("UPDATE chars SET char_name=@name, dob=@dob, gender=@gender, dept=@dept WHERE license=@license AND id=@id", 
    {
        ["@id"] = char.id,
        ["@license"] = license,
        ["@name"] = char.name,
        ["@dob"] = char.dob,
        ["@gender"] = char.gender,
        ["@dept"] = char.dept 
    }, function()
        DOS.Client.RefreshChars(src)
    end)
end

DOS.SelectCharacter = function(char)
    DOS.Characters[source] = nil
    DOS.Characters[source] = char
    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="background-color: rgba(90, 90, 90, 0.9); text-align: center; border-radius: 0.5vh; padding: 0.7vh; font-size: 1.7vh;"><b>You are now playing as {0} ({1})</b></div>',
        args = { char.char_name, char.dept }
    })
end

DOSProx.GetCharacter = function (src)
    return DOS.Characters[src]
end

DOSProx.SendMsgToDept = function (dept, name, msg)
    for src, char in pairs(DOS.Characters) do
        if char.dept == dept then 
            TriggerClientEvent('chatMessage', src, name, {255,255,255}, msg)
        end
    end
end

Tunnel.bindInterface('dos', DOS)
Proxy.addInterface('dos', DOSProx)