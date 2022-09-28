hook.Add( "Initialize", "tds_basewep_ammotypes", function()
    game.AddAmmoType( {
        name = "5.56x45mm",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )

    game.AddAmmoType( {
        name = "5.7x28mm",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )

    game.AddAmmoType( {
        name = ".50 AE",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )

    game.AddAmmoType( {
        name = "9x19mm",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )
end)