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
        util.Effect( "Explosion", explosion )
        util.BlastDamage( self, self:GetOwner(), self:GetPos(), 200, 100 )
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
    return self.Damage
end

function ENT:SetRadius( int )
    self.Radius = int
end

function ENT:GetRadius()
    return self.Radius
end

function ENT:SetFuse( time )
    self.Fuse = time 
end

function ENT:GetFuse()
    return self.Fuse
end