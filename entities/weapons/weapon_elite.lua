-- Base Information

SWEP.PrintName = "Dual Berettas"
SWEP.Base = "tds_basewep"
SWEP.ViewModel = "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.ViewModelFOV = 55
SWEP.WorldModel = "models/weapons/w_pist_elite.mdl"
SWEP.Slot = 1

SWEP.WeaponType = "secondary"
SWEP.HoldType = "duel"

-- Statistics

SWEP.Stats = {}
STAT = SWEP.Stats
STAT.Damage = 19
STAT.Spread = 0.017
STAT.Bullets = 1
STAT.Ammo = "9x19mm"
STAT.SpeedReduction = 10
STAT.Automatic = false
STAT.Clip = 30
STAT.Firerate = 60/500
STAT.ReloadTime = 3.5

-- Sounds

SWEP.Sounds = {}
SND = SWEP.Sounds
SND.Shoot = "weapons/elite/elite-1.wav"

-- Animations

SWEP.Anims = {}
ANM = SWEP.Anims
ANM.Idle = "idle"
ANM.Draw = "draw"
ANM.ShootLeft = {
    "shoot_left1",
}
ANM.ShootRight = {
    "shoot_right1",
}
ANM.Reload = "reload"

-- Custom

SWEP.NextShotLeft = false

function SWEP:Shoot()
    local ply = self.Owner and self.Owner or self:GetOwner()
    local Xspread, Yspread = self:GetSpread(), self:GetSpread()
    local bullet = {
        Attacker = ply,
        Src = ply:GetShootPos(),
        Dir = ply:GetAimVector(),
        Damage = self:GetDamage(),
        Num = self:GetBullets(),
        Spread = Vector( Xspread, Yspread, 0 ), --First and second value for spread, ignore third
    }
    ply:FireBullets( bullet )

    local snd = self:GetSilenced() and self:RandomValue( self.Sounds.ShootSilencer ) or self:RandomValue( self.Sounds.Shoot )
    self:EmitSound( snd )
    ply:SetAnimation( PLAYER_ATTACK1 )
    if SERVER then 
        local anim = self.NextShotLeft and self:RandomValue( self.Anims.ShootLeft ) or self:RandomValue( self.Anims.ShootRight ) 
        self:PlaySequence( anim ) 
    end

    if self.NextShotLeft then self.NextShotLeft = false else self.NextShotLeft = true end
    self:SetNextPrimaryFire( CurTime() + self:GetFirerate() )
    self:SetClip1( self:Clip1() - 1 )
end