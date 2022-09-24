SWEP.PrintName = "XM1014"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 3

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.ReloadOneByOne = true

SWEP.ASID = "wep_xm1014" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "idle"
Anim.Attack = {"shoot1", "shoot2"}
Anim.Reload = {
    [1] = "start_reload",
    [2] = "insert",
    [3] = "after_reload",
}

Stat = SWEP.Primary
Stat.Damage = 8 --Damage
Stat.Bullets = 12 --Bullets to fire
Stat.Automatic = true
Stat.Ammo = "buckshot" --Ammo Type
Stat.ClipSize = 6 --Mag size
Stat.Firerate = 60/180 --Attack Rate
Stat.Spread = 0.07 --Spread Cone
Stat.SpreadC = 0.05 --Spread Cone while crouching
Stat.RecoilVertical = 5.4 --vertical recoil
Stat.RecoilHorizontal = 5.4 --Horizontal recoil
Stat.Sound = "weapons/xm1014/xm1014-1.wav"
Stat.ReloadTime = 0.4
Stat.InsertReloadTime = 0.6

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0