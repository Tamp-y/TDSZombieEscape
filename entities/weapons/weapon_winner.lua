-- Base Information

SWEP.PrintName = "IM A WINNER"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "ar2"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 100
STAT.Spread = 0
STAT.Bullets = 50
STAT.Ammo = "5.7x28mm"
STAT.SpeedReduction = 20
STAT.Automatic = true
STAT.Clip = 1000
STAT.Firerate = 60/1500
STAT.ReloadTime = 3.4

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/p90/p90-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle"
ANM.Draw = "draw"
ANM.Shoot = {
    "shoot1",
    "shoot2",
    "shoot3",
}
ANM.Reload = "reload"