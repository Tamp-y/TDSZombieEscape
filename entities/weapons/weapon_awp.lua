SWEP.PrintName = "AWP"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 4

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"

SWEP.ASID = "wep_awp" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "awm_idle"
Anim.Deploy = "awm_draw"
Anim.Holster = "awm_idle"
Anim.Attack = "awm_fire"
Anim.Reload = "awm_reload"

Stat = SWEP.Primary
Stat.Damage = 63 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "SniperRound" --Ammo Type
Stat.ClipSize = 10 --Mag size
Stat.Firerate = 60/30 --Attack Rate
Stat.Spread = 0.06 --Spread Cone
Stat.SpreadC = 0.02 --Spread Cone while crouching
Stat.RecoilVertical = 4 --vertical recoil
Stat.RecoilHorizontal = 4 --Horizontal recoil
Stat.Sound = "weapons/awp/awp1.wav"
Stat.ReloadTime = 3.7

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0

SWEP.Zoomed = SWEP.Zoomed or false
SWEP.ZoomedFOV = 35

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