fx_version 'cerulean'

game 'gta5'
author 'devangelo25 on discord - contactangelograniello@gmail.com'
description 'Script created for esx and qbcore framwork. Mining Job'
version '1.0.0'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'configs/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page {
    "dist/index.html"
}

files {
	'dist/index.html',
	'dist/files/css/*.css',
    'dist/files/javascript/*.js',
    'dist/files/assets/*.png',
    'dist/files/assets/*.ogg',
}

dependencies {
    'es_extended',
    'esx_menu_default',
    'ox_lib',
}