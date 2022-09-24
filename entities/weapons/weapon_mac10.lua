SWEP.PrintName = "Mac-10"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 2

SWEP.HoldType = "smg"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"

SWEP.ASID = "wep_mac" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "mac10_idle"
Anim.Deploy = "mac10_draw"
Anim.Holster = "mac10_idle"
Anim.Attack = {"mac10_fire", "mac10_fire2", "mac10_fire3"}
Anim.Reload = "mac10_reload"

Stat = SWEP.Primary
Stat.Damage = 20 --Damage
Stat.Bullets = 1 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "smg1" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/1500 --Attack Rate
Stat.Spread = 0.04 --Spread Cone
Stat.SpreadC = 0.031 --Spread Cone while crouching
Stat.RecoilVertical = 0.1 --vertical recoil
Stat.RecoilHorizontal = 1.3 --Horizontal recoil
Stat.Sound = "weapons/mac10/mac10-1.wav"
Stat.ReloadTime = 2.8

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0