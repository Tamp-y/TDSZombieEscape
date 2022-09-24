SWEP.PrintName = "420NOSCOPECANNONEXTREME"
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
Stat.Damage = 9999 --Damage
Stat.Bullets = 999 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "ar2" --Ammo Type
Stat.ClipSize = 9999 --Mag size
Stat.Firerate = 60/9999 --Attack Rate
Stat.Spread = 0 --Spread Cone
Stat.SpreadC = 0 --Spread Cone while crouching
Stat.RecoilVertical = 0.7 --vertical recoil
Stat.RecoilHorizontal = 0.3 --Horizontal recoil
Stat.Sound = "weapons/m4a1/m4a1_unsil-1.wav"
Stat.ReloadTime = 2.8

SWEP.Primary.DefaultClip = 30
SWEP.Secondary.DefaultClip = 0