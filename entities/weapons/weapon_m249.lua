-- Base Information

SWEP.PrintName = "M249"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "shotgun"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 18
STAT.Spread = 0.026
STAT.Bullets = 1
STAT.Ammo = "5.56x45mm"
STAT.SpeedReduction = 50
STAT.Automatic = true
STAT.Clip = 100
STAT.Firerate = 60/800
STAT.ReloadTime = 5.4

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/m249/m249-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle1"
ANM.Draw = "draw"
ANM.Shoot = {
    "shoot1",
    "shoot2",
}
ANM.Reload = "reload"