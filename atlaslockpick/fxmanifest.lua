fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'DukeOfCheese'
description 'Uses oxTarget to lockpick vehicles locked via vMenu'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
}

dependencies {
    'ox_lib',
    'ox_target'
}