hook.Add( "PlayerBindPress", "tds_dropweapon", function( ply, bind, string, num ) 
    if bind == "gmod_undo" then
        net.Start( "tds_dropweapon" )
        net.SendToServer()
    end
end)