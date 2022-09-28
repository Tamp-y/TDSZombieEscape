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
        MsgC( Color( 100, 175, 50 ), "TDSFramework detected, player info and framework features will be present.\n")
    else
        MsgC( Color( 205, 75, 15), "TDSFramework is absent. The gamemode will still function with exclusion of any framework features.\n" )
    end
    INITIALLOADFINISHED = true
end

function Developing()
    if SET["Developer"] then return true else return false end
end