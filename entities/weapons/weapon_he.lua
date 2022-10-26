-- Base Information

SWEP.PrintName = "HE Grenade"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_eq_fraggrenade.mdl"
SWEP.Slot = 3

SWEP.WeaponType = "utility"
SWEP.HoldType = "grenade"

-- Statistics

SWEP.Entity = "ent_hegrenade"

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 100
STAT.PrepareDelay = 1
STAT.Fuse = 1.5
STAT.Clip = 1
STAT.Firerate = 60/400
STAT.ReloadTime = 2.8

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Explode = "weapons/hegrenade/explode5.wav"
SND.Bounce = "weapons/hegrenade/he_bounce-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle"
ANM.Draw = "deploy"
ANM.Ready = {
    "pullpin",
    "pullpin2",
    "pullpin3",
    "pullpin4",
}
ANM.Throw = "throw"