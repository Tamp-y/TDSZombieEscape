SWEP.PrintName = "TDS Base Weapon"
SWEP.Base = "weapon_base"
SWEP.Spawnable = false
SWEP.UseHands = true
SWEP.DrawCrosshair = false
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
SWEP.CSMuzzleFlashes = true
SWEP.BobScale = 0.1
SWEP.SwayScale = 0.5
SWEP.Weight = 5

include( "networking.lua" )
include( "ammo.lua" )
include( "hud.lua" )
AddCSLuaFile( "networking.lua" )
AddCSLuaFile( "ammo.lua" )
AddCSLuaFile( "hud.lua" )

-- ██╗   ██╗ █████╗ ██╗     ██╗   ██╗███████╗███████╗
-- ██║   ██║██╔══██╗██║     ██║   ██║██╔════╝██╔════╝
-- ██║   ██║███████║██║     ██║   ██║█████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██║     ██║   ██║██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║███████╗╚██████╔╝███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝

function SWEP:SetNextIdle( time )
    self.NextIdle = time
end

function SWEP:GetNextIdle()
    return self.NextIdle or 0
end

-- Gun Specific

function SWEP:SetCurrentSpread( val )
    self.Spread = val
end

function SWEP:GetCurrentSpread()
    return self.Spread or self:GetSpread()
end

function SWEP:SetNextReload( time )
    self.NextReload = time
end

function SWEP:GetNextReload()
    return self.NextReload or 0
end

function SWEP:SetSilenced( bool )
    self.Silenced = bool
    if SERVER then
        self:ResyncSilencedState()
    end
end

function SWEP:GetSilenced()
    return self.Silenced or false
end

-- Melee Specific

function SWEP:SetImpactDelay( time, alt )
    self.ImpactWait = time
    self.ImpactAlt = alt
end

function SWEP:GetImpactDelay()
    return self.ImpactWait or 0, self.ImpactAlt or false
end

-- Utility Specific

function SWEP:SetPrepared( bool )
    self.Prepared = bool
end

function SWEP:GetPrepared()
    return self.Prepared or false
end

function SWEP:SetPreparedIn( time )
    self.PreparedIn = time
end

function SWEP:GetPreparedIn()
    return self.PreparedIn or 0
end

--  ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗
-- ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝
-- ██║     ███████║█████╗  ██║     █████╔╝ ███████╗
-- ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ╚════██║
-- ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████║
--  ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝

-- Gun Specific

function SWEP:IsGun()
    if self.WeaponType == "primary" or self.WeaponType == "secondary" then return true end
    return false
end

function SWEP:CanShoot()
    if self:IsReloading() then return false end
    if self:Clip1() <= 0 then return false end
    return true
end

function SWEP:CanReload()
    if self:IsReloading() then return false end --already reloading
    if self:Clip1() >= self:GetMagSize() then return false end --No reason to reload with a full magainze
    if self.WeaponType == "melee" then return false end --Melee weapons cant reload, i think???
    return true
end

function SWEP:IsPrimaryWeapon()
    if self.WeaponType == "primary" then return true end
    return false
end

function SWEP:IsSecondaryWeapon()
    if self.WeaponType == "secondary" then return true end
    return false
end

-- Melee Specific

function SWEP:IsMelee()
    if self.WeaponType == "melee" then return true end
    return false
end

function SWEP:CanMelee()
    return true
end

-- Utility Specific

function SWEP:IsUtility()
    if self.WeaponType == "utility" then return true end
    return false
end

function SWEP:CanUtilize()
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
    local ply = self.Owner and self.Owner or self:GetOwner()
    local Xspread, Yspread = self:GetSpread(), self:GetSpread()
    local bullet = {
        Attacker = ply,
        Src = ply:EyePos(),
        Dir = ply:GetAimVector(),
        Damage = self:GetDamage(),
        Num = self:GetBullets(),
        Spread = Vector( Xspread, Yspread, 0 ), --First and second value for spread, ignore third
        IgnoreEntity = team.GetPlayers( ply:Team() )
    }
    ply:FireBullets( bullet )

    local snd = self:GetSilenced() and self:RandomValue( self.Sounds.ShootSilencer ) or self:RandomValue( self.Sounds.Shoot )
    self:EmitSound( snd )
    ply:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then 
        local anim = self:GetSilenced() and self:RandomValue( self.Anims.Silencer.Shoot ) or self:RandomValue( self.Anims.Shoot )
        self:PlaySequence( anim ) 
    end

    self:SetNextPrimaryFire( CurTime() + self:GetFirerate() )
    self:SetClip1( self:Clip1() - 1 )
end

function SWEP:ReloadGun()
    self:SetNextReload( CurTime() + self:GetReloadTime() )
    local anim = self:GetSilenced() and self:RandomValue( self.Anims.Silencer.Reload ) or self:RandomValue( self.Anims.Reload )
    self:PlaySequence( anim )
    self.Owner:SetAnimation( PLAYER_RELOAD )
end

function SWEP:ToggleSilencer()
    if self:IsReloading() then return end

    if not self:GetSilenced() then
        self:SetSilenced( true )
        self:PlaySequence( self.Anims.Silencer["Attach"] )
    else
        self:SetSilenced( false )
        self:PlaySequence( self.Anims.Silencer["Detach"] )
    end
end

-- Melee Specific

function SWEP:SwingMelee()
    local ply = self.Owner and self.Owner or self:GetOwner()
    ply:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then
        local anim = self:RandomValue( self.Anims.Attack )
        self:PlaySequence( anim )
        ply:EmitSound( self:RandomValue( self.Sounds.AttackMiss ) )
    end

    self:SetImpactDelay( CurTime() + self:GetImpact() )

    self:SetNextPrimaryFire( CurTime() + self:GetDelay() )
    self:SetNextSecondaryFire( CurTime() + self:GetDelay() )
end

function SWEP:SwingMeleeAlt()
    local ply = self.Owner and self.Owner or self:GetOwner()
    ply:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then
        local anim = self:RandomValue( self.Anims.AltMiss )
        self:PlaySequence( anim )
        ply:EmitSound( self:RandomValue( self.Sounds.AltMiss ) )
    end

    self:SetImpactDelay( CurTime() + self:GetAltImpact(), true )

    self:SetNextPrimaryFire( CurTime() + self:GetAltDelay() )
    self:SetNextSecondaryFire( CurTime() + self:GetAltDelay() )
end

function SWEP:MeleeImpact( alt )
    local ply = self.Owner and self.Owner or self:GetOwner()
    local tr = util.TraceLine( {
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * self:GetRange()),
        filter = ply,
        mask = MASK_SHOT_HULL,
    } )

    local ent = tr.Entity
    if tr.Hit then
        local snd = self:RandomValue( self.Sounds.AttackWall )
        if ent and IsValid( ent ) then
            if ent:IsPlayer() or ent:IsNPC() then
                snd = self:RandomValue( self.Sounds.Attack )

                local ef = EffectData()
                ef:SetOrigin( tr.HitPos )
                util.Effect( "BloodImpact", ef )
            end
            if SERVER then
                ply:EmitSound( snd )

                local dam = alt and self:GetAltDamage() or self:GetDamage()

                local dmginfo = DamageInfo()
                dmginfo:SetInflictor( self )
                dmginfo:SetAttacker( ply )
                dmginfo:SetDamage( dam )
                ent:TakeDamageInfo( dmginfo )
            end
        else
            if SERVER then
                ply:EmitSound( snd )
            else
                util.Decal( "ManhackCut", ply:GetShootPos(), ply:GetShootPos() + (ply:GetAimVector() * self:GetRange()), ply )
            end
        end
    end
end

-- Utility Specific

function SWEP:PrepareUtility()
    local anim = self:RandomValue( self.Anims.Ready )
    self:PlaySequence( anim )
    self:SetPreparedIn( CurTime() + self:GetPrepareDelay() )
    self:SetNextPrimaryFire( CurTime() + self:GetPrepareDelay() )
end

function SWEP:ThrowUtility( velocityOverride )
    local ply = self.Owner and self.Owner or self:GetOwner()

    if SERVER then
        local ent = ents.Create( self.Entity )
        ent:SetPos( ply:GetShootPos() )
        ent:SetFuse( CurTime() + self:GetFuse() )
        ent:Spawn()
        ent:SetOwner( ply )
        ent:SetDamage( self:GetDamage() )
        ent:SetRadius( self:GetRadius() )
        ent:SetAudioTable( self.Sounds )
        local physobj = ent:GetPhysicsObject()
        physobj:SetVelocity( ply:GetVelocity() + (ply:EyeAngles():Forward() * 1000) + Vector( 0, 0, 100 ) )
        physobj:Wake()
    end

    self:SetClip1( self:Clip1() - 1 )
    if SERVER and self:Clip1() <= 0 then
        ply:StripWeapon( self:GetClass() )
    else
        local anim = self:RandomValue( self.Anims.Draw )
        self:PlaySequence( anim ) 
    end
end

--  █████╗  ██████╗████████╗██╗ ██████╗ ███╗   ██╗     ██████╗ █████╗ ██╗     ██╗     ███████╗
-- ██╔══██╗██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔════╝██╔══██╗██║     ██║     ██╔════╝
-- ███████║██║        ██║   ██║██║   ██║██╔██╗ ██║    ██║     ███████║██║     ██║     ███████╗
-- ██╔══██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██║     ██╔══██║██║     ██║     ╚════██║
-- ██║  ██║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ╚██████╗██║  ██║███████╗███████╗███████║
-- ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

function SWEP:Initialize()
    self:SetClip1( self:GetMagSize() )
end

function SWEP:Deploy()
    local anim = self:GetSilenced() and self:RandomValue( self.Anims.Silencer.Draw ) or self:RandomValue( self.Anims.Draw )
    self:PlaySequence( anim )

    self:SetNextPrimaryFire( CurTime() + self:GetDeployTime() )
    self:SetNextSecondaryFire( CurTime() + self:GetDeployTime() )

    return true
end

function SWEP:Holster()
    if self:IsReloading() then self:SetNextReload( 0 ) end 
    if self:IsPreparing() then self:SetPreparedIn( 0 ) end 
    if self:GetPrepared() then self:SetPrepared( false ) end 
    return true
end

function SWEP:PrimaryAttack()
    if self:IsGun() then

        if self:CanShoot() then 
            self:Shoot()
        elseif self:Clip1() <= 0 and self:CanReload() then
            self:ReloadGun()
        end

    elseif self:IsMelee() then

        if self:CanMelee() then
            self:SwingMelee()
        end

    elseif self:IsUtility() then

        if self:CanUtilize() then
            self:PrepareUtility()
        end

    end
end

function SWEP:SecondaryAttack()
    if self:IsMelee() then
        self:SwingMeleeAlt()
    end
end

function SWEP:Reload()

    if self:IsGun() then

        if self:CanReload() then
            self:ReloadGun()
        end

    elseif self:IsUtility() then

        if self:GetPrepared() then
            self:SetPrepared( false )
            local anim = self:RandomValue( self.Anims.Draw )
            self:PlaySequence( anim )
        end

    end
end

-- ███████╗███████╗ ██████╗ ██╗   ██╗███████╗███╗   ██╗ ██████╗██╗███╗   ██╗ ██████╗
-- ██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝████╗  ██║██╔════╝██║████╗  ██║██╔════╝
-- ███████╗█████╗  ██║   ██║██║   ██║█████╗  ██╔██╗ ██║██║     ██║██╔██╗ ██║██║  ███╗
-- ╚════██║██╔══╝  ██║▄▄ ██║██║   ██║██╔══╝  ██║╚██╗██║██║     ██║██║╚██╗██║██║   ██║
-- ███████║███████╗╚██████╔╝╚██████╔╝███████╗██║ ╚████║╚██████╗██║██║ ╚████║╚██████╔╝
-- ╚══════╝╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:PlaySequence( sequence )
    local anim = sequence
    local viewmodel = self:GetOwner() and self:GetOwner().GetViewModel and self:GetOwner():GetViewModel() or nil
    if not viewmodel or not IsValid( viewmodel ) then return end
    local seq = self:RandomValue( anim )
    local dur = viewmodel:SequenceDuration( viewmodel:LookupSequence( seq ) )
    viewmodel:SendViewModelMatchingSequence( viewmodel:LookupSequence( seq ) )
    self:SetNextIdle( CurTime() + dur )
end

-- ███╗   ███╗██╗███████╗ ██████╗
-- ████╗ ████║██║██╔════╝██╔════╝
-- ██╔████╔██║██║███████╗██║
-- ██║╚██╔╝██║██║╚════██║██║
-- ██║ ╚═╝ ██║██║███████║╚██████╗
-- ╚═╝     ╚═╝╚═╝╚══════╝ ╚═════╝

function SWEP:RandomValue( var )
    local value = var

    if istable( var ) then
        value = table.Random( var )
    end

    return value
end

function SWEP:GetStats()
    return self.Stats
end

function SWEP:GetDamage()
    return self:GetSilenced() and self:GetStats().DamageSilencer or self:GetStats().Damage or 1
end

function SWEP:GetAltDamage()
    return self:GetStats().AltDamage
end

function SWEP:GetSpread()
    return self:GetSilenced() and self:GetStats().SpreadSilencer or self:GetStats().Spread or 0
end

function SWEP:GetBullets()
    return self:GetStats().Bullets or 1
end

function SWEP:GetRange()
    return self:GetStats().Range or 150
end

function SWEP:GetFirerate()
    return self:GetStats().Firerate or 60/60
end

function SWEP:GetDeployTime()
    return self:GetStats().DeployTime or 1
end

function SWEP:GetPrepareDelay()
    return self:GetStats().PrepareDelay or 1
end

function SWEP:GetFuse()
    return self:GetStats().Fuse or 1
end

function SWEP:GetRadius()
    return self:GetStats().Radius or 100
end

function SWEP:GetImpact()
    return self:GetStats().Impact or 0.1
end

function SWEP:GetAltImpact()
    return self:GetStats().AltImpact or 0.1
end

function SWEP:GetDelay()
    return self:GetStats().Delay or 60/60
end

function SWEP:GetAltDelay()
    return self:GetStats().AltDelay or 60/60
end

function SWEP:IsAutomatic()
    return self:GetStats().Automatic or false
end

function SWEP:IsAltAutomatic()
    return self:GetStats().AltAutomatic or false
end

function SWEP:GetMagSize()
    return self:GetStats().Clip or 1
end

function SWEP:GetReloadTime()
    return self:GetStats().ReloadTime or 1
end

function SWEP:GetAmmoType()
    return game.GetAmmoID( self:GetStats().Ammo )
end

function SWEP:GetAmmoTypeName()
    return game.GetAmmoName( self:GetAmmoType() )
end

function SWEP:IsReloading()
    if self:GetNextReload() > 0 then return true else return false end
end

function SWEP:ImpactDelaying()
    if self:GetImpactDelay() > 0 then return true else return false end
end

function SWEP:IsPreparing()
    if self:GetPreparedIn() > 0 then return true else return false end
end

-- ████████╗██╗  ██╗ ██████╗ ███╗   ██╗██╗  ██╗██╗███╗   ██╗ ██████╗
-- ╚══██╔══╝██║  ██║██╔═══██╗████╗  ██║██║ ██╔╝██║████╗  ██║██╔════╝
--    ██║   ███████║██║   ██║██╔██╗ ██║█████╔╝ ██║██╔██╗ ██║██║  ███╗
--    ██║   ██╔══██║██║   ██║██║╚██╗██║██╔═██╗ ██║██║╚██╗██║██║   ██║
--    ██║   ██║  ██║╚██████╔╝██║ ╚████║██║  ██╗██║██║ ╚████║╚██████╔╝
--    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝
-- ( ͡° ͜ʖ ͡°)

function SWEP:Think()
    self:SetWeaponHoldType( self.HoldType )
    if self:IsAutomatic() then self.Primary.Automatic = true else self.Primary.Automatic = false end
    if self:IsAltAutomatic() then self.Secondary.Automatic = true else self.Secondary.Automatic = false end

    local ply = self.Owner and self.Owner or self:GetOwner()

    if self:IsGun() then

        --Reloading
        if self:IsReloading() and CurTime() >= self:GetNextReload() - 0.2 then
            self:SetClip1( self:GetMagSize() )
        end
        if self:IsReloading() and CurTime() >= self:GetNextReload() then
            self:SetNextReload( 0 )
        end

        if ( CLIENT ) then
            if CurTime() > (self.NextResync or 0) then
                self:ResyncSilencedState()
                self.NextResync = CurTime() + (NWSetting and NWSetting.AutoSync or 5)
            end
        end

    elseif self:IsMelee() then

        --Impact Delay
        local del, alt = self:GetImpactDelay()
        if self:ImpactDelaying() and CurTime() >= del then
            self:SetImpactDelay( 0 )
            self:MeleeImpact( alt )
        end

    elseif self:IsUtility() then

        --Preparing
        if self:IsPreparing() and CurTime() > self:GetPreparedIn() then
            self:SetPreparedIn( 0 )
            self:SetPrepared( true )
        end

        --Throwing
        if self:GetPrepared() and not ply:KeyDown( IN_ATTACK ) then
            self:ThrowUtility()
            self:SetPrepared( false )
        end

    end

    if SERVER and CurTime() > self:GetNextIdle() and not (self:GetPrepared() or self:IsPreparing()) then
        local anim = self:GetSilenced() and self:RandomValue( self.Anims.Silencer.Idle ) or self:RandomValue( self.Anims.Idle )
        self:PlaySequence( anim )
    end
end