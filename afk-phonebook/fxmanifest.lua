fx_version 'bodacious'
game 'gta5'

author 'Discord baksteen#4478'
description 'QB-Core script for a phonebook directory'
version '1.0.0'


shared_scripts {
    'config.lua'
}

client_script 'client/client.lua'
server_script { 
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

ui_page {
    'html/index.html', 
   }
   
   --File Part-- 
   files {
    'html/index.html',
    'html/app.js', 
    'html/style.css',
   } 

lua54 'yes'