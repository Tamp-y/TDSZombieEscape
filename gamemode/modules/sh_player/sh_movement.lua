function GM:PlayerNoClip( ply, state )
    return true
end

hook.Add( "SetupMove", "tds_ZombieEscapeMovement", function( ply, mv, cmd )
    local movespeed = SET["MovementSpeed"]
    movespeed = ply:GetActiveWeapon().Base == "tds_basewep" and movespeed - (ply:GetActiveWeapon().Stats.SpeedReduction or 0) or movespeed
    ply:SetJumpPower( SET["JumpHeight"] )
    ply:SetRunSpeed( movespeed )
    ply:SetWalkSpeed( movespeed )
    ply:SetLadderClimbSpeed( 150 )
    ply:SetViewOffset( Vector( 0, 0, 63 ) )
    ply:SetViewOffsetDucked( Vector( 0, 0, 40 ) )
    ply:SetNoCollideWithTeammates( true )
end)

hook.Add( "GetFallDamage", "tds_ZombieEscapeFallDamage", function( ply, speed )
    if SET["FallDamage"] then
        return math.max( 0, math.ceil( 0.2418 * speed - 141.75 ) )
    else
        return 0
    end
end)