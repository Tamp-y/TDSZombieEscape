--[[
    To quickly explain this somewhat confusing mess, bosses in ZE either use a breakable entity or a math counter to determine when they are dead.
    In the case that they use a breakable, they only have a single health bar, so calculating the health will be easy. However, with math counters,
    the boss is set to only intake a static amount of damage (ex; bahamut on mako only takes 5 damage per shot), so an entity will intake the damage
    and tell the counter to decrease it's value.
]]

OBJ_UNK = 0
OBJ_COUNTER = 1
OBJ_PHYSBOX = 2

local COUNTERS = {
    ["math_counter"] = true,
}
local BREAKABLE = {
    ["func_physbox_multiplayer"] = true,
    ["func_physbox"] = true,
    ["func_breakable"] = true,
    ["prop_physics"] = true,
}

-- ███╗   ███╗███████╗████████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
-- ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
-- ██╔████╔██║█████╗     ██║   ███████║██║   ██║██║  ██║███████╗
-- ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║██║  ██║╚════██║
-- ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝

BossMeta = {}

function BossMeta:Create( tbl )
    local obj = {}
    setmetatable( obj, BossMeta )
    self.__index = self

    for k, v in pairs( tbl ) do
        obj[k] = v
    end

    return obj
end

-- Setting

function BossMeta:SetName( str )
    self.name = str
end

function BossMeta:SetIntake( ent )
    self.ent = ent
end

function BossMeta:SetCounter( ent )
    self.counter = ent
end

function BossMeta:SetType( int )
    self.type = int
end

function BossMeta:SetHealth( int )
    self.health = int

    if self:GetType() == OBJ_COUNTER then
        local ent = self:GetCounterEntity()
        if IsValid( ent ) then
            ent:SetValue( int )
        end
    end
    if self:GetType() == OBJ_PHYSBOX then
        local ent = self:GetCounterEntity()
        if IsValid( ent ) then
            ent:SetHealth( int )
        end
    end
end

function BossMeta:UpdateHealth() --Preferable use this when finalizing a boss' health, will do the calculations for you.
    local ent = self:GetCounterEntity()
    if not IsValid( ent ) then return end

    if not self:GetType() then
        if BREAKABLE[ent:GetClass()] then
            self:SetType( OBJ_PHYSBOX )
        end
        if COUNTERS[ent:GetClass()] then
            self:SetType( OBJ_COUNTER )
        end
    end

    if (self:GetCounterEntity().healthUpdated or false) then return end

    local health = self.healthOverride or self:GetType() == OBJ_PHYSBOX and ent:Health() or self:GetType() == OBJ_COUNTER and ent:GetValue()

    if self.healthPerPlayer then
        local humans = math.Clamp( #team.GetPlayers() - 1, 0, game.MaxPlayers() ) --Minus one, because base hp would be what one player would be fighting against.
        health = health + (self.healthPerPlayer * humans)
    end

    self:GetCounterEntity().healthUpdated = true
    self:SetHealth( health )
end

function BossMeta:SetMaxHealth( int )
    self.maxhealth = int
end

-- Fetching

function BossMeta:GetName()
    return self.name or "name?nil"
end

function BossMeta:GetIntake()
    return self.ent
end

function BossMeta:GetCounter()
    return self.counter
end

function BossMeta:GetMassCounter()
    return self.masscounter
end

function BossMeta:GetType()
    return self.type
end

function BossMeta:GetIntakeEntity()
    for k, v in pairs( ents.FindByName( self:GetIntake() ) ) do
        return v
    end
end

function BossMeta:GetCounterEntity()
    for k, v in pairs( ents.FindByName( self:GetCounter() ) ) do
        return v
    end
end

function BossMeta:GetHealth()
    local health = 1
    if self:GetType() == OBJ_COUNTER then
        health = self:GetCounterEntity():GetValue()
    end
    if self:GetType() == OBJ_PHYSBOX then
        health = self:GetCounterEntity():Health()
    end
    return health
end

function BossMeta:GetMaxHealth()
    if not self.maxhealth then
        self.maxhealth = self:GetHealth()
    end
    return self.maxhealth or 1
end

-- Actions

function BossMeta:OnDamage( dmginfo )
    if IsValid( dmginfo:GetAttacker() ) and dmginfo:GetAttacker():IsPlayer() then
        self.Damage = self.Damage or {}
        self.Damage[dmginfo:GetAttacker()] = (self.Damage[dmginfo:GetAttacker()] or 0) + 1
        self:UpdateHealth()
        self:Resync( dmginfo:GetAttacker() )
    end
end

function BossMeta:OnKilled()
    if self.Damage and not (self:GetCounterEntity().killed or false) then
        for k, v in pairs( player.GetAll() ) do
            self:GetCounterEntity().killed = true

            v:ChatPrint( "===== Boss Defeated =====" )
            v:ChatPrint( "Highest Damagers:" )
            local i = 1
            for k2, v2 in SortedPairsByValue( self.Damage ) do
                v:ChatPrint( k2:Nick() .. " - " .. v2 .. " HITs" )
                if i >= 3 then break end
                i = i + 1
            end
        end
        self.Damage = nil
    end
end

-- ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗███╗   ███╗███████╗███╗   ██╗████████╗
-- ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
-- ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██╔████╔██║█████╗  ██╔██╗ ██║   ██║
-- ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║
-- ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║ ╚═╝ ██║███████╗██║ ╚████║   ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝

ZE.Bosses = {}

function ZE:AddBoss( map, data )
    if game.GetMap() != map then return end --doing this to keep the main table clean if we arent on the map.

    local obj = BossMeta:Create( data )
    table.insert( self.Bosses, obj )
end

function ZE:GetBosses()
    return self.Bosses
end

function ZE:GetBoss( ent )
    for _, boss in pairs( self:GetBosses() ) do
        if IsValid( boss:GetCounterEntity() ) and boss:GetCounterEntity() == ent then
            return boss
        end
        if IsValid( boss:GetIntakeEntity() ) and boss:GetIntakeEntity() == ent then
            return boss
        end
    end
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

hook.Add( "EntityTakeDamage", "tdsze_bossdamage", function( ent, dmginfo ) 
    local boss = ZE:GetBoss( ent )
    if boss then
        boss:OnDamage( dmginfo )
        if boss:GetHealth() <= 0 then
            boss:OnKilled()
        end
    end
end)

hook.Add( "PostCleanupMap", "tdsze_enttypeupdate", function()
    if SERVER then
        for _, boss in pairs( ZE:GetBosses() ) do
            if boss.health then
                boss:UpdateHealth()
            end
        end
    end
end)

hook.Add( "CounterSetValue", "tdsze_bossfixhealth", function( ent, int ) 
    for k, v in pairs( ZE:GetBosses() ) do
        if v.counter == ent:GetName() and v.healthOverride then
            ent:SetValue( v.healthOverride, true )
        end
    end
end)

-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

if ( SERVER ) then

    util.AddNetworkString( "tdsze_boss_sync" )

    function BossMeta:Resync( ply )
        net.Start("tdsze_boss_sync")
            net.WriteString( self:GetName() )
            net.WriteInt( self:GetHealth(), 16 )
            net.WriteInt( self:GetMaxHealth(), 16 )
        net.Send( ply )
    end

elseif ( CLIENT ) then

    net.Receive( "tdsze_boss_sync", function()
        local name = net.ReadString()
        local health = net.ReadInt( 16 )
        local maxhealth = net.ReadInt( 16 )

        SetActiveTarget( name, health, maxhealth )
    end)
end