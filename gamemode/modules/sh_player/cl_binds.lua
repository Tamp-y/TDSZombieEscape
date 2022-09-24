hook.Add( "PlayerButtonDown", "TDS_ZombieEscape_Binds", function( ply, button )
    if not IsFirstTimePredicted() then return end

    local f1 = input.LookupBinding( "gm_showhelp" )
    local f2 = input.LookupBinding( "showteam" )
    local f3 = input.LookupBinding( "showspare1" )
    local f4 = input.LookupBinding( "showspare2" )
    
    if input.GetKeyName( button ) == f1 then
        ZESettings()
    end
end )