fx_version 'cerulean'
game 'gta5'
lua54 'true'

author 'Fearx'
description 'Fearx-StarterPacks'
version '1.0.0'

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

dependencies {
    'oxmysql',
}