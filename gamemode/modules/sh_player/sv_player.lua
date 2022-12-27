function PlyMeta:BecomeHuman()
    self:StripWeapons()
    self:SetTeam( 3 )

    if TDSFRAMEWORK then
        self:InitiateEquipment()
    else
        self:SetModel( "models/player/urban.mdl" )
        for k, v in pairs( SET["HWeapons"] ) do --TODO: Replace this with TDSFramework weapons if detected
            self:Give( v )
        end
    end
end

hook.Add( "TDSOnEquipmentUpdate", "TDS_UpdateEquipment", function( ply ) 
    if TDSFRAMEWORK and GAMEMODE:InPreSelection() then
        ply:InitiateEquipment()
    end
end)

hook.Add( "TDSDataLoaded", "TDS_InitEquipment", function( ply ) 
    if GAMEMODE:InPreSelection() then
        ply:InitiateEquipment()
    end
end)

function PlyMeta:BecomeZombie()
    self:StripWeapons()
    self:SetTeam( 2 )
    self:SetModel( "models/player/zombie_classic.mdl" )
    for k, v in pairs( SET["ZWeapons"] ) do
        self:Give( v )
    end
    self:SetHealth( SET["ZHealth"] )
    self:SetMaxHealth( SET["ZHealth"] )

    self:EmitSound("npc/fast_zombie/fz_scream1.wav", 80, 100, 0.5)
end

function PlyMeta:HasPrimaryWeapon()
    for k, v in pairs( self:GetWeapons() ) do
        if v.WeaponType == "primary" then return true end
    end

    return false
end

function PlyMeta:HasSecondaryWeapon()
    for k, v in pairs( self:GetWeapons() ) do
        if v.WeaponType == "secondary" then return true end
    end

    return false
end

hook.Add( "PlayerSpawn", "tds_ZombieEscapeTeam", function( ply )
    if GAMEMODE:InPreSelection() or GAMEMODE:InWarmup() or Developing() then
        ply:BecomeHuman()
    else
        ply:BecomeZombie()
    end

    ply:AllowFlashlight( true )
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

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

util.AddNetworkString( "tds_dropweapon" )

net.Receive( "tds_dropweapon", function( _, ply )
    local wep = ply:GetActiveWeapon()
    if not wep.Base == "tds_basewep" then return end

    if wep.WeaponType == "primary" or wep.WeaponType == "secondary" then
        ply:DropWeapon( wep )
    end
end)