SWEP.PrintName = "M3 Super 90"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 3

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel = "models/weapons/w_shot_m3super90.mdl"
SWEP.ReloadOneByOne = true

SWEP.ASID = "wep_m3super" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "holster"
Anim.Attack = "shoot2"
Anim.Reload = {
    [1] = "start_reload",
    [2] = "insert",
    [3] = "after_reload",
}

Stat = SWEP.Primary
Stat.Damage = 10 --Damage
Stat.Bullets = 12 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "buckshot" --Ammo Type
Stat.ClipSize = 8 --Mag size
Stat.Firerate = 60/60 --Attack Rate
Stat.Spread = 0.06 --Spread Cone
Stat.SpreadC = 0.035 --Spread Cone while crouching
Stat.RecoilVertical = 7.3 --vertical recoil
Stat.RecoilHorizontal = 5.9 --Horizontal recoil
Stat.Sound = "weapons/m3/m3-1.wav"
Stat.ReloadTime = 0.4
Stat.InsertReloadTime = 0.6

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0