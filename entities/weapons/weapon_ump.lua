-- Base Information

SWEP.PrintName = "UMP"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "smg"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 22
STAT.Spread = 0.015
STAT.Bullets = 1
STAT.Ammo = ".45ACP"
STAT.SpeedReduction = 15
STAT.Automatic = true
STAT.Clip = 25
STAT.Firerate = 60/650
STAT.ReloadTime = 3.2

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/ump45/ump45-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle1"
ANM.Draw = "draw"
ANM.Shoot = {
    "shoot1",
    "shoot2",
    "shoot3",
}
ANM.Reload = "reload"