fx_version 'cerulean'
game { 'gta5' }

ui_page 'html/index.html'

files {
    'shared/modules/*.lua',

    -- character_page
    'html/index.html',
    'html/main.css',
    'html/app.js',
    'html/lib/bootstrap.min.css',
    'html/lib/bootstrap.min.js',
    'html/lib/jquery.min.js',
    'html/assets/logo.png',
    'html/assets/background.png',
    'html/assets/loader.svg'
}

shared_scripts {
    'shared/utils.lua',
    'shared/config.lua'
}

client_scripts {
    'client/main.lua',
    'client/functions.lua',
    'client/commands.lua',
    'client/server-management.lua',
	'client/character.lua',
	'client/dv.lua',
	'client/cl_newsprops.lua',
	'client/cl_hukeybind.lua',
	'client/cl_takehostage.lua',
	'client/cl_carry.lua',
    'client/cl_car.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/discord.lua',
    'server/main.lua',
    'server/commands.lua',
    'server/server-management.lua',
	'server/character.lua',
	'server/sv_news.lua',
	'server/sv_takehostage.lua',
	'server/sv_carry.lua',
    'server/sv_car.lua'
}