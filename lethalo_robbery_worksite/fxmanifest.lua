fx_version 'cerulean'
game 'gta5'

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/client.lua',
}

shared_scripts {
    'config.lua',
}

server_scripts {
	--'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}