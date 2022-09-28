GM.Bosses = GM.Bosses or {}
BossMeta = {}

OBJ_MATH = 1
OBJ_PHYSBOX = 2

if ( SERVER ) then
    util.AddNetworkString( "tdsze_boss_healthsync" )
    util.AddNetworkString( "tdsze_boss_healthsyncrequest" )
end

-- Object Features

function Boss:Create( name, refEnt, counter )
    local obj = {}
    setmetatable( obj, BossMeta ) --This will apply the uniqueid table to use the 'BossMeta' features
 
    obj:SetName( name )
    obj:SetEntity( refEnt )
    obj:SetCounterEntity( counter )
    
    return obj
end

function Boss:SetName( str )
    self.name = str
end

function Boss:SetEntity( ent )
    self.ent = ent
end

function Boss:SetCounterEntity( ent )
    self.counter = ent
end

function Boss:SetHealth()
    --I need to add something that will work with both counters and default health, unsure of how i want to do this.
end

function Boss:SetMaxHealth( val )
    self.MaxHealth = val
end

function Boss:GetName() --Name to be displayed
    return self.Name or "name?nil"
end

function Boss:GetEntity() --Entity our object references
    return self.Ent
end

function Boss:GetType() --Type of counter our object uses
    return self.Type
end

function Boss:GetCounter() --Counter of our entity reference
    return self.Counter
end

function Boss:GetActiveHealth()
    if self:GetType() == OBJ_MATH then
        return IsValid( self:GetCounter() ) and self:GetCounter():GetOutValue() or 1
    elseif self:GetType() == OBJ_PHYSBOX then
        if not IsValid( self:GetCounter() ) then return 1 end
        
        local health = self:GetCounter():Health()
        if not self:GetMaxHealth() or health >= self:GetMaxHealth() then --Will set the boss' max health in the case that it might be missing.
            self:SetMaxHealth( health )
        end
        return health
    end
end

function Boss:GetHealthCounts()

end

function Boss:GetMaxHealth()
    return self.MaxHealth
end

function Boss:GetMaxHealthCounts()

end

function Boss:HasCounter()
    return self:GetCounter() and true or false
end

function Boss:OnKilled()

end

function Boss:OnDamaged()
    self:ResyncHealth()
end

function Boss:ResyncHealth() --WIP
    if ( SERVER ) then
        net.Start( "tdsze_boss_healthsync" )
            net.WriteEntity( self:GetEntity() )
            net.WriteInt( self:GetActiveHealth(), 32 )
            net.WriteInt( self:GetHealthCounts(), 16 )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start( "tdsze_boss_healthsyncrequest" )
            net.WriteEntity( self:GetEntity() )
        net.SendToServer()
    end
end

-- Object Management

function GAMEMODE:AddBossObject( map, data )
    if game.GetMap() != map then return end --doing this to keep the main table clean
    if not data.entName then return end

    local obj = BossMeta:Create( data.name, data.entName, data.counter )
    table.insert( self.Bosses, obj )
end

function GAMEMODE:GetBosses()
    return self.Bosses or {}
end

function GAMEMODE:GetBoss( ent )
    for k, v in pairs( self:GetBosses() ) do
        if v:GetCounter() == ent then
            return v
        end
    end
end