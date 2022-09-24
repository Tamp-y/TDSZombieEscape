SWEP.PrintName = "M4A1"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 3

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 55
SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle_unsil"
Anim.Deploy = "draw_unsil"
Anim.Holster = "adjustment"
Anim.Attack = {"shoot1_unsil", "shoot2_unsil", "shoot3_unsil"}
Anim.Reload = "reload_unsil"

Stat = SWEP.Primary
Stat.Damage = 500 --Damage
Stat.Bullets = 3 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "ar2" --Ammo Type
Stat.ClipSize = 30 --Mag size
Stat.Firerate = 60/750 --Attack Rate
Stat.Spread = 0.015 --Spread Cone
Stat.SpreadC = 0.01 --Spread Cone while crouching
Stat.RecoilVertical = 0.7 --vertical recoil
Stat.RecoilHorizontal = 0.3 --Horizontal recoil
Stat.Sound = "weapons/m4a1/m4a1_unsil-1.wav"
Stat.ReloadTime = 2.8

SWEP.Primary.DefaultClip = 50
SWEP.Secondary.DefaultClip = 0