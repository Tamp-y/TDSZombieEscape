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

if SERVER then

    util.AddNetworkString( "tdsze_debugent" )
    util.AddNetworkString( "tdsze_debugent_request" )

    net.Receive( "tdsze_debugent_request", function( _, ply ) 
        local ent = net.ReadEntity()
        local kv = ent:GetKeyValues()

        net.Start( "tdsze_debugent" )
            net.WriteTable( kv )
        net.Send( ply )
    end)

elseif CLIENT then 

    function EntInfo()
        tr = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 2000),
            filter = LocalPlayer(),
        })

        if not tr.Entity or not IsValid( tr.Entity ) then print("No entity found, make sure to look at it and be close to it.") return end

        print( tr.Entity )
        print( "Fetching Data..." )
        net.Start( "tdsze_debugent_request" )
            net.WriteEntity( tr.Entity )
        net.SendToServer()
    end
    concommand.Add( "tdsze_debugent", EntInfo )

    net.Receive( "tdsze_debugent", function()
        local tbl = net.ReadTable()
        PrintTable( tbl )
    end)

end