SWEP.PrintName = "TDS Base Weapon"
SWEP.Base = "weapon_base"
SWEP.Spawnable = false
SWEP.UseHands = true
SWEP.DrawCrosshair = false

hook.Add( "Initialize", "tds_basewep_ammotypes", function()
    game.AddAmmoType( {
        name = "5.56x45mm",
        dmgtype = DMG_BULLET,
        tracer = TRACER_LINE,
    } )
end)

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

function SWEP:IsGun()
    if self.WeaponType != "melee" then return true end
end

function SWEP:IsSuppressed()
    return false
end

-- Gun Specific

function SWEP:CanShoot()
    if CurTime() < self:GetNextReload() then return false end
    if self:Clip1() <= 0 then return false end
    return true
end

function SWEP:CanReload()
    if self.WeaponType == "melee" then return false end
    if CurTime() < self:GetNextReload() then return false end
    --if self:Clip1() >= self.Primary.ClipSize then return false end --No reason to reload with a full magainze
    --if self:Ammo1() == 0 then return false end --Cannot reload with no spare ammo
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
    local ply = self.Owner and self.Owner or self:GetOwner()
    local bullet = {}
    bullet.Attacker = ply
    bullet.Src = ply:GetShootPos()
    bullet.Dir = ply:GetAimVector()
    bullet.Damage = self:GetDamage()
    bullet.Num = self:GetBullets()
    bullet.Spread = Vector( 0, 0, 0 ) --First and second value for spread, ignore third
    ply:FireBullets( bullet )

    local snd = self:RandomValue( self.Sounds.Shoot )
    if self:IsSuppressed() then
        snd = self:RandomValue( self.Sounds.ShootSilencer )
    end
    self:EmitSound( snd )
    ply:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then 
        self:PlaySequence( self:RandomValue( self.Anims.Shoot ) ) 
    end

    self:SetNextPrimaryFire( CurTime() + self:GetFirerate() )
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

function SWEP:Initialize()
    self:SetClip1( self:GetMagSize() )
end

function SWEP:Deploy()
    self:PlaySequence( self:RandomValue( self.Anims.Draw ) )
end

function SWEP:PrimaryAttack()
    if self:IsGun() then
        if self:CanShoot() then 
            self:Shoot()
        else
            if self:Clip1() <= 0 then
                self:Reload()
            end
        end
    end
end

function SWEP:SecondaryAttack()
    
end

function SWEP:Reload()
    if not self:CanReload() then return end

    self:SetNextReload( CurTime() + self:GetReloadTime() )
    self:PlaySequence( self:RandomValue( self.Anims.Reload ) )
    self.Owner:SetAnimation( PLAYER_RELOAD )
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

function SWEP:RandomValue( var )
    local value = var

    if istable( var ) then
        value = table.Random( var )
    end

    return value
end

function SWEP:GetDamage()
    return self.Stats.Damage
end

function SWEP:GetBullets()
    return self.Stats.Bullets
end

function SWEP:GetFirerate()
    return self.Stats.Firerate
end

function SWEP:IsAutomatic()
    return true
end

function SWEP:GetMagSize()
    return self.Stats.Clip
end

function SWEP:GetReloadTime()
    return self.Stats.ReloadTime
end

function SWEP:GetAmmoType()
    return game.GetAmmoID( self.Stats.Ammo )
end

function SWEP:GetAmmoTypeName()
    return game.GetAmmoName( self:GetAmmoType() )
end

function SWEP:IsReloading()
    reload = self:GetNextReload() <= 0 and 
end

function SWEP:Think()
    self:SetWeaponHoldType( self.HoldType )
    if self:IsAutomatic() then
        self.Primary.Automatic = true
    else
        self.Primary.Automatic = false
    end

    --Reloading
    if self:IsReloading() and CurTime() > self:GetNextReload() then
        self:SetNextReload( 0 )
        self:SetClip1( self:GetMagSize() )
    end
end

function SWEP:DrawHUD()
    local length, thick, shadowthick, space, opacity = 4, 1, 1, 5, 200
    
    --Crosshair Shadow
    surface.SetDrawColor( Color( 0, 0, 0, opacity ))
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, thick + (shadowthick * 2), thick + (shadowthick * 2) ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - (length + space) - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 + (thick / 2) + space - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Bottom Line

    --Crosshair Front
    local col = HUDCOL_PRIMARY:ToTable()
    surface.SetDrawColor( col[1], col[2], col[3], opacity )
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2), thick, thick ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space), ScrH() / 2 - (thick / 2), length, thick ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space, ScrH() / 2 - (thick / 2), length, thick ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2) - (length + space), thick, length ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 + (thick / 2) + space, thick, length ) --Bottom Line

    --Ammo
    local width, height, xoff, yoff = 250, 70, 50, 50
    local boxx, boxy = ScrW() - (width + xoff), ScrH() - (height + yoff)
    surface.SetDrawColor( HUDCOL_SECONDARY )
    surface.DrawRect( boxx, boxy, width, height )
    draw.SimpleText( "Ammo", "TDSHudNormal", boxx + 5, boxy + 5, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    draw.SimpleText( self:Clip1() .. " / " .. self:GetMagSize(), "TDSHudNormal", boxx + 5, boxy + 60, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
    draw.SimpleText( self:GetAmmoTypeName(), "TDSHudNormal", boxx + 235, boxy + 60, HUDCOL_PRIMARY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
end