SWEP.PrintName = "Knife"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 1

SWEP.Melee = true
SWEP.HoldType = "knife"
SWEP.ViewModelFOV = 52
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.DefaultCrosshair = true
SWEP.NoAmmo = true
SWEP.NoHolster = true

SWEP.ASID = "wep_knife" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle_cycle"
Anim.Deploy = "draw"
Anim.Holster = "idle"
Anim.HolsterIdle = "reference"
Anim.Attack = {"midslash1", "midslash2"}

Stat = SWEP.Primary
Stat.Damage = 19 --Damage
Stat.Firerate = 60/80 --Attack Rate
Stat.Distance = 75 --Attack Distance
Stat.ImpactDelay = 0.15 --Delay before impacting
Stat.Automatic = true
Stat.Sound = {"weapons/knife/knife_slash1.wav", "weapons/knife/knife_slash2.wav"}
Stat.Impact = "weapons/knife/knife_hitwall1.wav"
Stat.ImpactFlesh = {"weapons/knife/knife_hit1.wav", "weapons/knife/knife_hit2.wav", "weapons/knife/knife_hit3.wav", "weapons/knife/knife_hit4.wav"}

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0