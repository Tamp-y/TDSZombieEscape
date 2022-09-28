-- Base Information

SWEP.PrintName = "USP-S"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.Slot = 1

SWEP.WeaponType = "secondary"
SWEP.HoldType = "pistol"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 19
STAT.DamageSilencer = 18
STAT.Spread = 0.017
STAT.SpreadSilencer = 0.012
STAT.Bullets = 1
STAT.Ammo = "9x19mm"
STAT.SpeedReduction = 10
STAT.Automatic = false
STAT.Clip = 12
STAT.Firerate = 60/400
STAT.ReloadTime = 2.8

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/usp/usp_unsil-1.wav"
SND.ShootSilencer = "weapons/usp/usp1.wav"

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
    self:ToggleSilencer()

    self:SetNextPrimaryFire( CurTime() + 2.2 )
    self:SetNextSecondaryFire( CurTime() + 2.2 )
end