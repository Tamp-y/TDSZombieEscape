SWEP.PrintName = "TDS Base Weapon"
SWEP.Base = "weapon_base"
SWEP.Spawnable = false
SWEP.UseHands = true
SWEP.DrawCrosshair = false

-- ██╗   ██╗ █████╗ ██╗     ██╗   ██╗███████╗███████╗
-- ██║   ██║██╔══██╗██║     ██║   ██║██╔════╝██╔════╝
-- ██║   ██║███████║██║     ██║   ██║█████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██║     ██║   ██║██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║███████╗╚██████╔╝███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝

-- Gun Specific

function SWEP:SetSpread( val )
    self.Spread = val
end

function SWEP:GetSpread()
    return self.Spread or 0
end

function SWEP:SetNextReload( time )
    self.NextReload = time
end

function SWEP:GetNextReload()
    return self.NextReload or 0
end

-- Melee Specific

function SWEP:SetImpactDelay( time )
    self.NextImpact = time
end

function SWEP:GetImpactDelay()
    return self.NextImpact or 0
end

--  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗
-- ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝
-- ██║     ███████║█████╗  ██║     █████╔╝ ███████╗
-- ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ╚════██║
-- ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████║
--  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝

-- Gun Specific

function SWEP:CanShoot()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() <= 0 then return false end
    return true
end

function SWEP:CanReload()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() >= self.Primary.ClipSize then return false end --No reason to reload with a full magainze
    if self:Ammo1() == 0 then return false end --Cannot reload with no spare ammo
    return true
end

function SWEP:CanMelee()
    return true
end

-- ██╗    ██╗███████╗ █████╗ ██████╗  ██████╗ ███╗   ██╗    ██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝██╔══██╗██╔══██╗██╔═══██╗████╗  ██║    ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗  ███████║██████╔╝██║   ██║██╔██╗ ██║    ██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝  ██╔══██║██╔═══╝ ██║   ██║██║╚██╗██║    ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗██║  ██║██║     ╚██████╔╝██║ ╚████║    ██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝

-- Gun Specific

function SWEP:Shoot()
    local bullet = {}
    bullet.Attacker = self.Owner
    bullet.Src = self.Owner:GetShootPos()
    bullet.Dir = self.Owner:GetAimVector()
    bullet.Damage = self.Primary.Damage
    bullet.Num = self.Primary.Bullets
    bullet.Spread = Vector( self:GetSpread(), self:GetSpread(), 0 )
    bullet.Tracer = 1
    bullet.Distance = 10000
    self.Owner:FireBullets( bullet )

    local snd = istable( self.Primary.Sound ) and table.Random( self.Primary.Sound ) or self.Primary.Sound
    self:EmitSound( snd )
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then 
        self:PlaySequence( self.Anim.Attack ) 
    end

    self:SetNextPrimaryFire( CurTime() + self.Primary.Firerate )
    self:SetClip1( self:Clip1() - 1 )
end

-- Melee Specific

--[[

function SWEP:Melee()
    if not self:CanMeleeSwing() then return end

    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then
        self:PlaySequence( self.Anim.Attack )
        local snd = istable( self.Primary.Sound ) and table.Random( self.Primary.Sound ) or self.Primary.Sound
        self.Owner:EmitSound( snd )
    end

    self:SetImpactDelay( CurTime() + self.Primary.ImpactDelay )

    self:SetNextPrimaryFire( CurTime() + self.Primary.Firerate )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Firerate )
end

function SWEP:MeleeImpact()
    local trace = util.TraceLine( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.Primary.Distance,
        filter = self.Owner,
        mask = MASK_SHOT_HULL
    } )

    if trace.Hit and not (trace.Entity:IsPlayer() or trace.Entity:IsNPC()) then
        local snd = istable(self.Primary.Impact) and table.Random(self.Primary.Impact) or self.Primary.Impact
        self:EmitSound( snd )
    elseif trace.Hit and (trace.Entity:IsPlayer() or trace.Entity:IsNPC()) then
        local snd = istable(self.Primary.ImpactFlesh) and table.Random(self.Primary.ImpactFlesh) or self.Primary.ImpactFlesh
        self:EmitSound( snd )
    end

    if SERVER and (trace.Entity and IsValid( trace.Entity )) and (trace.Entity:IsNPC() or trace.Entity:IsPlayer() or trace.Entity:Health() > 0) then
        local dmginfo = DamageInfo()
        dmginfo:SetInflictor( self )
        dmginfo:SetAttacker( self.Owner )
        dmginfo:SetDamage( self.Primary.Damage )
        trace.Entity:TakeDamageInfo( dmginfo )
        local snd = istable(self.Primary.ImpactFlesh) and table.Random(self.Primary.ImpactFlesh) or self.Primary.ImpactFlesh
        self:EmitSound( snd )
    end
end
]]

--  █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗     ██████╗ █████╗ ██╗     ██╗     ███████╗
-- ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔════╝██╔══██╗██║     ██║     ██╔════╝
-- ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║    ██║     ███████║██║     ██║     ███████╗
-- ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██║     ██╔══██║██║     ██║     ╚════██║
-- ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╗██║  ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

--[[
function SWEP:Initialize()
    self:SetHoldType( self.HoldType )
end
]]

function SWEP:Deploy()
    self:PlaySequence( self.Anims.Draw )
end

function SWEP:PrimaryAttack()
    
end

function SWEP:SecondaryAttack()
    
end

function SWEP:Reload()
    
end

-- ███████╗███████╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗ ██████╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔════╝██║████╗  ██║██╔════╝
-- ███████╗█████╗  ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║     ██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ██║╚██╗██║██║     ██║██║╚██╗██║██║   ██║
-- ███████║███████╗╚██████╔╝╚██████╔╝███████╗██║ ╚████║╚██████╗██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:PlaySequence( sequence )
    local anim = sequence
    local viewmodel = self.Owner:GetViewModel()
    local tblcheck = istable(anim) and table.Random(anim) or anim
    viewmodel:SendViewModelMatchingSequence( viewmodel:LookupSequence( tblcheck ) )
end

-- ███╗   ███╗██╗███████╗ ██████╗
-- ████╗ ████║██║██╔════╝██╔════╝
-- ██╔████╔██║██║███████╗██║
-- ██║╚██╔╝██║██║╚════██║██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝

function SWEP:Think()
    self:SetWeaponHoldType( self.HoldType )

    --[[
    --Reloading
    if CurTime() > self:GetNextReload() and self:GetNextReload() != 0 then
        if not self.ReloadOneByOne then
            self:SetNextReload( 0 )
            local ammoMissing = self.Primary.ClipSize - self:Clip1()
            if self:Ammo1() >= ammoMissing then
                self.Owner:SetAmmo( self:Ammo1() - ammoMissing, self:GetPrimaryAmmoType() )
                self:SetClip1( self:Clip1() + ammoMissing )
            elseif self:Ammo1() < ammoMissing then
                self:SetClip1( self:Clip1() + self:Ammo1() )
                self.Owner:SetAmmo( 0, self:GetPrimaryAmmoType() )
            end
        else
            if self:Clip1() >= self.Primary.ClipSize or self:Ammo1() <= 0 or not self.Owner:KeyDown( IN_RELOAD ) then
                self:PlaySequence( self.Anim.Reload[3] )
                self:SetNextReload( 0 )
            else
                self:PlaySequence( self.Anim.Reload[2] )
                self:SetClip1( self:Clip1() + 1 )
                self.Owner:SetAmmo( self:Ammo1() - 1, self:GetPrimaryAmmoType())
                self:SetNextReload( CurTime() + self.Primary.InsertReloadTime )
                if self.Primary.Reload then
                    self:EmitSound( self.Primary.Reload )
                end
            end
        end
    end
    ]]
end

function SWEP:DrawHUD()
    local length, thick, shadowthick, space, opacity = 4, 1, 1, 5, 200
    
    --Shadow
    surface.SetDrawColor( Color( 0, 0, 0, opacity ))
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, thick + (shadowthick * 2), thick + (shadowthick * 2) ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - (length + space) - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 + (thick / 2) + space - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Bottom Line

    --Front
    local col = HUDCOL_PRIMARY:ToTable()
    surface.SetDrawColor( col[1], col[2], col[3], opacity )
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2), thick, thick ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space), ScrH() / 2 - (thick / 2), length, thick ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space, ScrH() / 2 - (thick / 2), length, thick ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2) - (length + space), thick, length ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 + (thick / 2) + space, thick, length ) --Bottom Line
end