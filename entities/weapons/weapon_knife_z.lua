-- Base Information

SWEP.PrintName = "Infected Knife"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.ViewModelFOV = 50
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.Slot = 2

SWEP.WeaponType = "melee"
SWEP.HoldType = "knife"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 25
STAT.AltDamage = 60
STAT.Range = 70
STAT.Automatic = true
STAT.AltAutomatic = true
STAT.Impact = 0.1
STAT.AltImpact = 0.1
STAT.Delay = 60/120
STAT.AltDelay = 60/60

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Deploy = "weapons/knife/knife_deploy1.wav"
SND.Attack = {
    "weapons/knife/knife_hit1.wav",
    "weapons/knife/knife_hit2.wav",
    "weapons/knife/knife_hit3.wav",
    "weapons/knife/knife_hit4.wav",
}
SND.AttackWall = {
    "weapons/knife/knife_hitwall1.wav",
}
SND.AttackMiss = {
    "weapons/knife/knife_slash1.wav",
    "weapons/knife/knife_slash2.wav",
}
SND.Alt = {
    "weapons/knife/knife_stab.wav",
}
SND.AltWall = {
    "weapons/knife/knife_hitwall1.wav",
}
SND.AltMiss = {
    "weapons/knife/knife_slash1.wav",
    "weapons/knife/knife_slash2.wav",
}

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle_cycle"
ANM.Draw = "draw"
ANM.Attack = {
    "midslash1",
    "midslash2",
}
ANM.AttackMiss = {
    "midslash1",
    "midslash2",
}
ANM.Alt = {
    "stab",
}
ANM.AltMiss = {
    "stab_miss",
}