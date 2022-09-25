function PlyMeta:BecomeZombie()
    self:StripWeapons()

    self:SetTeam( 2 )
    self:SetModel( "models/player/zombie_classic.mdl" )
    self:Give( "weapon_knife" )
    self:SetHealth( SET["ZHealth"] )
    self:SetMaxHealth( SET["ZHealth"] )
    self:EmitSound("npc/fast_zombie/fz_scream1.wav", 80, 100, 0.5)
end

hook.Add( "PlayerSpawn", "tds_ZombieEscapeTeam", function( ply )
    if GAMEMODE:InPreSelection() then
        ply:SetTeam( 3 )
        ply:SetModel( "models/player/urban.mdl" )
        ply:Give( "weapon_m4a1" )
        ply:Give( "weapon_knife" )
    else
        ply:BecomeZombie()
    end
end)

hook.Add( "PlayerDeath", "tds_ZombieEscapeDeath", function( ply ) 
    ply:SetTeam( 2 )
end)

hook.Add( "PlayerShouldTakeDamage", "tds_ZombieEscapeNoTK", function( ply, atk )
    if not atk:IsPlayer() then return true end

    if ply:Team() == atk:Team() then
        return false
    end
end )

hook.Add( "EntityTakeDamage", "tds_ZombieEscapeDamageMult", function( target, dmg )
    local dmgTrigger = {
        ["func_breakable"] = true
    }

    if dmgTrigger[target:GetClass()] then
        dmg:SetDamage( dmg:GetDamage() * SET["TriggerDamageMult"] )
    end
end )