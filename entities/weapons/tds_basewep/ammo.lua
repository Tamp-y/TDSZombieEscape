hook.Add( "Initialize", "tds_basewep_ammotypes", function()
    game.AddAmmoType( {
        name = "5.56x45mm",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )
end)