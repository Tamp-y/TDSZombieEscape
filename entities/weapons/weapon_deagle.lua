-- Base Information

SWEP.PrintName = "Desert Eagle"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.Slot = 1

SWEP.WeaponType = "secondary"
SWEP.HoldType = "pistol"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 42
STAT.Spread = 0.017
STAT.Bullets = 1
STAT.Ammo = ".50 AE"
STAT.SpeedReduction = 15
STAT.Automatic = false
STAT.Clip = 7
STAT.Firerate = 60/250
STAT.ReloadTime = 2.1

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/deagle/deagle-1.wav"

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