SWEP.PrintName = "AS_BaseWep"
SWEP.Category = "Aftershock"
SWEP.Spawnable = false
SWEP.UseHands = true
SWEP.DrawCrosshair = false

-- ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗     ██╗██████╗ ███████╗████████╗██████╗ ██╗███████╗██╗   ██╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝    ██╔╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██║██╔════╝██║   ██║██║████╗  ██║██╔════╝
-- ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗  ██╔╝ ██████╔╝█████╗     ██║   ██████╔╝██║█████╗  ██║   ██║██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║ ██╔╝  ██╔══██╗██╔══╝     ██║   ██╔══██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╗██║██║   ██║
-- ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝██╔╝   ██║  ██║███████╗   ██║   ██║  ██║██║███████╗ ╚████╔╝ ██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝    ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:SetSpread( val )
    self.Spread = val
end

function SWEP:GetSpread()
    return self.Spread or 0
end

function SWEP:SetHolsteredState( bool )
    self.Holstered = bool
end

function SWEP:GetHolsteredState()
    return self.Holstered or false
end

function SWEP:ToggleHolsteredState()
    if not self:GetHolsteredState() then --We arent holstered, but we are going to holster.
        self:SetHolsteredState( true )
        self:SetHoldType( "normal" )
        if SERVER then
            self:PlaySequence( self.Anim.Holster )
            local viewmodel = self.Owner:GetViewModel()
            timer.Simple( viewmodel:SequenceDuration( viewmodel:LookupSequence( self.Anim.Holster ) ), function()
                if IsValid( self ) and self.Owner:Alive() then
                    self:PlaySequence( self.Anim.HolsterIdle )
                end
            end)
        end
    else
        self:SetHolsteredState( false )
        self:SetHoldType( self.HoldType )
        if SERVER then
            self:PlaySequence( self.Anim.Deploy )
        end
    end
end

function SWEP:SetNextReload( time )
    self.NextReload = time
end

function SWEP:GetNextReload()
    return self.NextReload or 0
end

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

function SWEP:CanReload()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() >= self.Primary.ClipSize then return false end --No reason to reload with a full magainze
    if self:Ammo1() == 0 then return false end --Cannot reload with no spare ammo
    return true
end

function SWEP:CanMeleeSwing()
    if CurTime() < self:GetNextReload() then return false end
    if self:GetHolsteredState() == true then return false end
    return true
end

function SWEP:CanShootGun()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() <= 0 then return false end
    return true
end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ██╗████████╗██╗   ██╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║     ██║╚══██╔══╝╚██╗ ██╔╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║     ██║   ██║    ╚████╔╝
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║     ██║   ██║     ╚██╔╝
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗██║   ██║      ██║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝

function SWEP:Initialize()
    self:SetHoldType( self.HoldType )
    if self.Melee then
        self:SetHolsteredState( false )
    end
end

function SWEP:Deploy()
    if self:GetHolsteredState() == false then
        self:PlaySequence( self.Anim.Deploy )
    end
end

function SWEP:PrimaryAttack()
    if self.Melee then
        self:MeleeSwing()
    else
        self:ShootGun()
    end
end

function SWEP:SecondaryAttack()
    if self.Melee then --Temp;
        self:PrimaryAttack()
    end
end

function SWEP:Reload()
    if self.Melee and not self.NoHolster then
        if CurTime() > self:GetNextReload() then
            self:ToggleHolsteredState()
            self:SetNextReload( CurTime() + 1 )
        end
    else

        if not self:CanReload() then return end
        
        self.Owner:SetAnimation( PLAYER_RELOAD )
        if not self.ReloadOneByOne then
            self:SetNextReload( CurTime() + self.Primary.ReloadTime )
            if self.Primary.Reload then
                self:EmitSound( self.Primary.Reload )
            end
            if SERVER then
                self:PlaySequence( self.Anim.Reload )
            end
        else
            self:PlaySequence( self.Anim.Reload[1] )
            self:SetNextReload( CurTime() + self.Primary.ReloadTime )
        end

    end
end

-- Melee Functions

function SWEP:MeleeSwing()
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

function SWEP:MeleeDamage()
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

-- Firearm Functions

function SWEP:ShootGun()
    if self:Clip1() <= 0 then self:Reload() end
    if not self:CanShootGun() then return end

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
    if self.Melee then

        local impactdelay = self:GetImpactDelay()
        if impactdelay ~= 0 and CurTime() >= impactdelay then
            self:MeleeDamage()
            self:SetImpactDelay( 0 )
        end

    else

        --Weapon Spread
        if not self.Owner:Crouching() then
            if self:GetSpread() != self.Primary.Spread then
                self:SetSpread( self.Primary.Spread )
            end
        else
            if self.Owner:IsOnGround() and self:GetSpread() != self.Primary.SpreadC then
                self:SetSpread( self.Primary.SpreadC )
            end
        end
        if (self.Zoomed or false) and self:GetSpread() != self.Primary.SpreadC * 0.5 and self.Owner:IsOnGround() then
            self:SetSpread( self.Primary.SpreadC * 0.2 )
        end

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

    end
end

function SWEP:DrawHUD()
    surface.DrawCircle( ScrW() / 2, ScrH() / 2, 2, HUDCOL_PRIMARY )
end

function SWEP:DrawWorldModel( flags )
    if CLIENT then

        if not self:GetHolsteredState() then --This will just hide melee weapons when they're holstered.
            self:DrawModel( flags )
        end

    end
end