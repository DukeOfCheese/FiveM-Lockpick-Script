fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '2.0.1'

author 'DukeOfCheese'
description 'Standalone lockpick script'

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
