GM.Name = "Zombie Escape"

INITIALLOADFINISHED = INITIALLOADFINISHED or false
TDSFRAMEWORK = TDSFRAMEWORK or false

DeriveGamemode( "tds" )

print( "Loading Zombie Escape..." )

include( "_moduleload.lua" )
if SERVER then AddCSLuaFile( "_moduleload.lua" ) end

print( "Finished!" )

if not INITIALLOADFINISHED then
    if TDSFRAMEWORK then
        print( "TDSFramework detected, player info and framework features will be present.")
    else
        print( "TDSFramework is absent. The gamemode will still function with exclusion of any framework features." )
    end
    INITIALLOADFINISHED = true
end