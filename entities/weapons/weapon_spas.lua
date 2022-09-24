SWEP.PrintName = "SPAS-12"
SWEP.Category = "Aftershock"
SWEP.Spawnable = true
SWEP.Base = "as_basewep"
SWEP.Slot = 3

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 60
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ReloadOneByOne = true

SWEP.ASID = "wep_spas" --Aftershock item ID

SWEP.Anim = {}
Anim = SWEP.Anim
Anim.Idle = "idle"
Anim.Deploy = "draw"
Anim.Holster = "holster"
Anim.Attack = "fire01"
Anim.Reload = {
    [1] = "reload1",
    [2] = "reload2",
    [3] = "reload3",
}

Stat = SWEP.Primary
Stat.Damage = 9 --Damage
Stat.Bullets = 12 --Bullets to fire
Stat.Automatic = false
Stat.Ammo = "buckshot" --Ammo Type
Stat.ClipSize = 6 --Mag size
Stat.Firerate = 60/420 --Attack Rate
Stat.Spread = 0.06 --Spread Cone
Stat.SpreadC = 0.035 --Spread Cone while crouching
Stat.RecoilVertical = 6.3 --vertical recoil
Stat.RecoilHorizontal = 7 --Horizontal recoil
Stat.Sound = "weapons/shotgun/shotgun_fire6.wav"
Stat.Reload = "weapons/shotgun/shotgun_reload3.wav"
Stat.ReloadTime = 0.3
Stat.InsertReloadTime = 0.4

SWEP.Primary.DefaultClip = 0
SWEP.Secondary.DefaultClip = 0