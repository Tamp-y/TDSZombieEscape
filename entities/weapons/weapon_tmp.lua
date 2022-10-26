-- Base Information

SWEP.PrintName = "TMP"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "smg"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 16
STAT.Spread = 0.021
STAT.Bullets = 1
STAT.Ammo = "9x19mm"
STAT.SpeedReduction = 20
STAT.Automatic = true
STAT.Clip = 30
STAT.Firerate = 60/1000
STAT.ReloadTime = 2.1

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/tmp/tmp-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle1"
ANM.Draw = "draw"
ANM.Shoot = "fire1"
ANM.Reload = "reload"