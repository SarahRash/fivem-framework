Config = {}

Config.DebugMode = false

Config.MaxCharacters = 10 -- Defines how many characters a player can make.
Config.DiscordToken = "HIDDEN" -- Can be found at. https://discord.com/developers/applications/
Config.GuildId = "849921353825124392" -- Use Developer mode to find ID

Config.AdminRoleIds = {
    "849968022550478898", -- [!] Owner
    "849968021506359308", -- [!] Management
    "849968024588255234", -- [!] Director of Staff
    "849968027973845032" -- [!] Staff
} -- gives all departments / You can add as many as you want.

Config.Departments = {
    ["IAA"] = "865852293916393512",-- International Affairs Agency
    ["FIB"] = "865852295366967316",-- Federal Investigations Bureau
    ["NOOSE"] = "865852293215027250", -- National Office Of Security Enforcement
    ["USM"] = "865852292610654208", -- United States Military
    ["USMS"] = "885055985423630368", -- US Marshal
    ["SAHP"] = "849968715067555870", -- San Andreas Highway Patrol
    ["LSPD"] = "849968715595644938", -- Los Santos Police Department
    ["LSSD"] = "849968715911135254", -- Los Santos Coutny Sheriff's
    ["SAFD"] = "849968716904923166", -- San Andreas Fire Department 
    ["CIV"] = "849969114104594432" -- Civilian
}

-- Spawn points. Using vMenu you can turn on "Coordinates" to find spawn points.

Config.Spawns = {
    ["IAA"] = {
        {x=119.17, y=-668.19, z=48.18, label="International Affairs Agency (Downtown)"},
	},
    ["FIB"] = {
        {x=102, y=-744, z=46.85, label="Federal Investigation Bureau (Downtown)"},
	},
    ["NOOSE"] = {
        {x=2503.99, y=-387.3, z=95.75, label="National Office Of Security Office"},
        {x=-903.35, y=-2403.16, z=15.12, label="National Office Of Security Office LSIA Branch"},
    },
    ["USM"] = {
		{x=-2342.98, y=3262.33, z=34.26, label="Fort Zancudo Tower 1"},
        {x=-2278.29, y=3375.58, z=32.81, label="Fort Zancudo Gate (North)"},
        {x=-1613.96, y=2807.64, z=19.10, label="Fort Zancudo Gate (South)"},
        {x=-1947.14, y=3359.98, z=34.32, label="Fort Zancudo Training Fields"},
    },
    ["USMS"] = {
		{x=-542.51, y=-208.10, z=38.74, label="Town Hall"},
        {x=-2278.29, y=3375.58, z=32.81, label="Fort Zancudo Gate (North)"},
        {x=-1613.96, y=2807.64, z=19.10, label="Fort Zancudo Gate (South)"},
        {x=-1947.14, y=3359.98, z=34.32, label="Fort Zancudo Training Fields"},
    },
    ["LSPD"] = {
        {x=-554.97, y=-135.81, z=39.4, label="Police Department Headquarters"},
        {x=441.35, y=-1013.19, z=30.01, label="Mission Row Police Station"},
        {x=-1109.33, y=-844.86, z=20.81, label="Vespucci Police Station (Upper)"},
        {x=-1063.99, y=-849.05, z=6.2, label="Vespucci Police Station (Lower)"},
		{x=825.96, y=-1289.51, z=29.34, label="La Mesa Police Station"},
        {x=374.35, y=-1611.08, z=30.1, label="Davis Impound Lot"},
    },
    ["LSSD"] = {
		{x=1857.47, y=3678.56, z=35.17, label="Sandy Shores Police Station"},
        {x=-460.76, y=6015.58, z=32.71, label="Paleto Bay Police Station"},
        {x=374.35, y=-1611.08, z=30.10, label="Davis Impound Lot"},
        {x=378.65, y=789.67, z=188.37, label="Vinewood Park Ranger Station"},
        {x=-1491.75, y=4981.27, z=64.63, label="Park Ranger Office Raton Canyon"},
    },
    ["SAHP"] = {
    	{x=2021.33, y=2766.73, z=53.64, label="San Andreas Highway Headquarters"},
    },
    ["SAFD"] = {
        {x=-635.36, y=-126.16, z=40.1, label="Fire Department Headquarters"},
        {x=1213.82, y=-1501.66, z=35.93, label="Fire Station 7"},
        {x=199.94, y=-1632.81, z=31.21, label="Davis Fire Station"},
		{x=1705.9, y=3585.88, z=36.56, label="Sandy Shores Fire Station"},
        {x=-381.01, y=6120.44, z=32.83, label="Paleto Bay Fire Station"},
        --{x=-2497.62, y=2830.03, z=33.91, label="Fort Zancudo Fire Station"}, -- Disabled due to instant Death Bug
        {x=-1071.49, y=-2379.11, z=15.07, label="Los Santos International Airport Fire Station"},
    },
    ["CIV"] = {
        {x=-412.85, y=1168.61, z=327.44, label="Galileo Observatory"},
        {x=-41.57, y=-1109.44, z=27.77, label="Premium Deluxe Motorsport"},
        {x=919.93, y=41.63, z=82.3, label="Diamond Casino & Resort"},
        {x=1168.16, y=-322.98, z=70.11, label="Mirror Park LTD"},
        {x=-355.32, y=-127.94, z=40.5, label="Central Los Santos Customs Shop"},
        {x=-565.25, y=273.47, z=83.94, label="Tequi-La-La"},
		{x=150.89, y=-1308.79, z=30.71, label="Vanilla Unicorn"},
        {x=1982.48, y=3062.99, z=48.16, label="Yellow Jack Inn"},
        {x=1386.22, y=3600.26, z=36.07, label="Ace Liqour"},
        {x=-302.65, y=6252.83, z=32.88, label="The Hen House"},
        {x=121.47, y=6625.99, z=33.15, label="Beekers Garage"},
    }
}

-- {x=, y=, z=, label=""},