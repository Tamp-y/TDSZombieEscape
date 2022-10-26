-- Base Information

SWEP.PrintName = "AK47"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.Slot = 0

SWEP.WeaponType = "primary"
SWEP.HoldType = "ar2"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 26
STAT.Spread = 0.018
STAT.Bullets = 1
STAT.Ammo = "7.62x39mm"
STAT.SpeedReduction = 30
STAT.Automatic = true
STAT.Clip = 30
STAT.Firerate = 60/650
STAT.ReloadTime = 2.4

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/ak47/ak47-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "ak47_idle"
ANM.Draw = "ak47_draw"
ANM.Shoot = {
    "ak47_fire1",
    "ak47_fire2",
    "ak47_fire3",
}
ANM.Reload = "ak47_reload"