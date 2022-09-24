function GM:PlayerNoClip( ply, state )
    return true
end

hook.Add( "SetupMove", "tds_ZombieEscapeMovement", function( ply, mv, cmd )
    if SERVER then
        ply:SprintDisable()
    end
    ply:SetJumpPower( SET["JumpHeight"] )
    ply:SetWalkSpeed( SET["MovementSpeed"] )
    ply:SetViewOffset( Vector( 0, 0, 58 ) )
    ply:SetViewOffsetDucked( Vector( 0, 0, 40 ) )
    ply:SetHull( Vector( -16, -16, 0 ), Vector( 16, 16, 63 ) )
    ply:SetHullDuck( Vector( -16, -16, 0 ), Vector( 16, 16, 45 ) )
    ply:SetNoCollideWithTeammates( true )
end)

hook.Add( "GetFallDamage", "tds_ZombieEscapeFallDamage", function( ply, speed )
    if SET["FallDamage"] then
        return math.max( 0, math.ceil( 0.2418 * speed - 141.75 ) )
    else
        return 0
    end
end)