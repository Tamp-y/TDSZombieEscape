GM.Name = "Zombie Escape"

INITIALLOADFINISHED = INITIALLOADFINISHED or false

DeriveGamemode( "tds" )

function GM:TDSFrameworkActive()
    if TDSFRAMEWORK then return true else return false end
end

print( "Loading Zombie Escape..." )

include( "_moduleload.lua" )
if SERVER then AddCSLuaFile( "_moduleload.lua" ) end

print( "Finished!" )

if not INITIALLOADFINISHED then
    if GM:TDSFrameworkActive() then
        print( "TDSFramework detected, player info and framework features will be present.")
    else
        print( "TDSFramework is absent. The gamemode will still function with exclusion of any framework features." )
    end
    INITIALLOADFINISHED = true
end