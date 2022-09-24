SWEP.PrintName = "M249"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 4

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.ASID = "wep_m249" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle1"
Anim.Deploy = "draw"
Anim.Holster = "idle1"
Anim.Attack = {"shoot1", "shoot2"}
Anim.Reload = "reload"

Stat = SWEP.Primary
Stat.Damage = 23 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "ar2" --Ammo Type
Stat.ClipSize = 100 --Mag size
Stat.Firerate = 60/650 --Attack Rate
Stat.Spread = 0.06 --Spread Cone
Stat.SpreadC = 0.03 --Spread Cone while crouching
Stat.RecoilVertical = 1.2 --Vertical recoil
Stat.RecoilHorizontal = 1.1 --Horizontal recoil
Stat.Sound = "weapons/m249/m249-1.wav"
Stat.ReloadTime = 5.4

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0