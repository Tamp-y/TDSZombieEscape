-- Base Information

SWEP.PrintName = "M4A1"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.WeaponType = "rifle"
SWEP.HoldType = "ar2"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 20
STAT.Bullets = 1
STAT.Ammo = "5.56"
STAT.Automatic = true
STAT.Clip = 30
STAT.Firerate = 60/750
STAT.ReloadTime = 3.1

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/m4a1/m4a1_unsil-1.wav"
SND.ShootSilencer = "weapons/m4a1/m4a1-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle_unsil"
ANM.Draw = "draw_unsil"
ANM.Shoot = {
    "shoot1_unsil",
    "shoot2_unsil",
    "shoot3_unsil",
}
ANM.Reload = "reload_unsil"
ANM.Silencer = {
    Attach = "add_silencer",
    Detach = "detach_silencer",
    Idle = "idle",
    Draw = "draw",
    Shoot = {
        "shoot1",
        "shoot2",
        "shoot3",
    },
    Reload = "reload",
}

--[[
SWEP.Anims = {
    Idle = "idle_unsil",
    Deploy = "draw_unsil",
    Attack = {
        "shoot1_unsil",
        "shoot2_unsil",
        "shoot3_unsil"
    },
    Reload = "reload_unsil",
    Silencer = {
        Idle = "idle",
        Deploy = "draw",
        Attack = {
            "shoot1"
        }
    },
}

Stat = SWEP.Primary
Stat.Damage = 20 --Damage
Stat.Bullets = 1 --Bullets to fire
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
]]