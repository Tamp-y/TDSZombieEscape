SWEP.PrintName = "Scout"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 4

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_snip_scout.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"

SWEP.ASID = "wep_scout" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle1"
Anim.Deploy = "draw"
Anim.Holster = "adjustment"
Anim.Attack = "shoot"
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 42 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "SniperRound" --Ammo Type
Stat.ClipSize = 10 --Mag size
Stat.Firerate = 60/40 --Attack Rate
Stat.Spread = 0.04 --Spread Cone
Stat.SpreadC = 0.01 --Spread Cone while crouching
Stat.RecoilVertical = 1.3 --vertical recoil
Stat.RecoilHorizontal = 1 --Horizontal recoil
Stat.Sound = "weapons/scout/scout_fire-1.wav"
Stat.ReloadTime = 2.8

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.Zoomed = SWEP.Zoomed or false
SWEP.ZoomedFOV = 40

function SWEP:ToggleZoom()
    if not self.Zoomed then
        self.Zoomed = true
        self.Owner:SetFOV( self.ZoomedFOV, 0.1, self )
    else
        self.Zoomed = false
        self.Owner:SetFOV( 0, 0.1, self )
    end
    self:EmitSound( "weapons/zoom.wav" )
end

function SWEP:SecondaryAttack()
    if IsFirstTimePredicted() then
        self:ToggleZoom()
    end
    self:SetNextSecondaryFire( CurTime() + 0.5 )
end

function SWEP:Holster()
    if self.Zoomed then
        self:ToggleZoom()
    end

    return true
end

function SWEP:AdjustMouseSensitivity()
    if self.Zoomed then
        return GetConVar("aswep_scope_sensitivity"):GetInt() * 0.01
    else
        return 1
    end
end