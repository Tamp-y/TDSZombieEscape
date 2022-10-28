AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"

if ( SERVER ) then

    function ENT:Initialize()
        self:SetModel( "models/weapons/w_eq_fraggrenade_thrown.mdl" )
        self:SetSolid( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    end

    function ENT:Explode()
        self:Remove()
        local explosion = EffectData()
        explosion:SetOrigin( self:GetPos() )
        explosion:SetFlags( 4 )
        util.Effect( "Explosion", explosion, false )
        local snd = self:GetAudioTable().Explode
        self:EmitSound( snd, 110, 100, 1, CHAN_WEAPON, nil, 2 )
        util.BlastDamage( self, self:GetOwner(), (self:GetPos() + self:OBBCenter()), self:GetRadius(), self:GetDamage() )
    end

    function ENT:Think()
        if CurTime() > self:GetFuse() then
            self:Explode()
        end
    end

end

function ENT:Draw()
    self:DrawModel()
end

-- ██╗   ██╗ █████╗ ██╗     ██╗   ██╗███████╗███████╗
-- ██║   ██║██╔══██╗██║     ██║   ██║██╔════╝██╔════╝
-- ██║   ██║███████║██║     ██║   ██║█████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██║     ██║   ██║██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║███████╗╚██████╔╝███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝

function ENT:SetOwner( ent )
    self.Owner = ent
end

function ENT:GetOwner()
    return self.Owner or nil
end

function ENT:SetDamage( int )
    self.Damage = int 
end

function ENT:GetDamage()
    return self.Damage or 100
end

function ENT:SetRadius( int )
    self.Radius = int
end

function ENT:GetRadius()
    return self.Radius or 200
end

function ENT:SetFuse( time )
    self.Fuse = time 
end

function ENT:GetFuse()
    return self.Fuse or 1
end

function ENT:SetAudioTable( tbl )
    self.Sounds = tbl
end

function ENT:GetAudioTable()
    return self.Sounds or {}
end