hook.Add( "PlayerButtonDown", "TDS_ZombieEscape_Binds", function( ply, button )
    if not IsFirstTimePredicted() then return end

    local help = input.LookupBinding( "gm_showhelp" )
    local shteam = input.LookupBinding( "gm_showteam" )
    local spare1 = input.LookupBinding( "gm_showspare1" )
    local spare2 = input.LookupBinding( "gm_showspare2" )
    
    if input.GetKeyName( button ) == spare2 then
        ZESettings()
    end
end )