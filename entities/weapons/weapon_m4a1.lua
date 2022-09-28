-- Base Information

SWEP.PrintName = "M4A1"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "ar2"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 20
STAT.DamageSilencer = 17
STAT.Spread = 0.015
STAT.SpreadSilencer = 0.0085
STAT.Bullets = 1
STAT.Ammo = "5.56x45mm"
STAT.SpeedReduction = 35
STAT.Automatic = true
STAT.Clip = 30
STAT.Firerate = 60/750
STAT.ReloadTime = 2.8

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/m4a1/m4a1_unsil-1.wav"
SND.ShootSilencer = "weapons/m4a1/m4a1-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle_unsil"
ANM.Draw = "draw_unsil"
ANM.Shoot = {
    "shoot1_unsil",
    "shoot2_unsil",
    "shoot3_unsil",
}
ANM.Reload = "reload_unsil"
ANM.Silencer = {
    Attach = "add_silencer",
    Detach = "detach_silencer",
    Idle = "idle",
    Draw = "draw",
    Shoot = {
        "shoot1",
        "shoot2",
        "shoot3",
    },
    Reload = "reload",
}

-- Custom

function SWEP:SecondaryAttack()
    if self:IsReloading() then return end

    if not self:GetSilenced() then
        self:SetSilenced( true )
        self:PlaySequence( self.Anims.Silencer["Attach"] )
    else
        self:SetSilenced( false )
        self:PlaySequence( self.Anims.Silencer["Detach"] )
    end

    self:SetNextPrimaryFire( CurTime() + 1.8 )
    self:SetNextSecondaryFire( CurTime() + 1.8 )
end