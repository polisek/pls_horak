fx_version 'adamant'

game 'gta5'

description 'Polisek scripts'

dependencies {	'ox_lib',  'ox_target'}

shared_scripts {   
    '@ox_lib/init.lua', 
}


client_scripts {
	'client/client.lua',
}


lua54 "yes"
