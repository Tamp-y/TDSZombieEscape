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
}

-- ███╗   ███╗███████╗████████╗██╗  ██╗ ██████╗ ██████╗ ███████╗
-- ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██╔════╝
-- ██╔████╔██║█████╗     ██║   ███████║██║   ██║██║  ██║███████╗
-- ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║██║  ██║╚════██║
-- ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝██████╔╝███████║
-- ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝

BossMeta = {}

function BossMeta:Create( name, ent, counter )
    local obj = {}
    setmetatable( obj, BossMeta )
    self.__index = self

    obj.name = name --Display name for clients
    obj.ent = ent --The entity that takes the damage
    obj.counter = counter --The counter for the health

    for k, v in pairs( ents.FindByName( obj.counter ) ) do
        if COUNTERS[v:GetClass()] then
            obj.type = OBJ_COUNTER
        elseif BREAKABLE[v:GetClass()] then
            obj.type = OBJ_PHYSBOX
        end
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
    local health
    if self:GetType() == OBJ_COUNTER then
        print( self:GetCounterEntity():Health() )
        --print( self:GetCounterEntity() )
        --health = self:GetCounterEntity():GetOutValue()
    elseif self:GetType() == OBJ_PHYSBOX then
        health = self:GetCounterEntity():Health()
    end
    return health or 1
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
        self:Resync( dmginfo:GetAttacker() )
    end
end

function BossMeta:OnKilled()
    if self.Damage then
        for k, v in pairs( player.GetAll() ) do
            v:ChatPrint( "===== Boss Defeated =====" )
            v:ChatPrint( "Highest Damagers:" )
            local i = 1
            for k2, v2 in SortedPairsByValue( self.Damage ) do
                v:ChatPrint( k2:Nick() .. " - " .. v2 .. " HITs" )
                if i >= 3 then break end
                i = i + 1
            end
        end
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

    local obj = BossMeta:Create( data.name, data.ent, data.counter )
    table.insert( self.Bosses, obj )
end

function ZE:GetBosses()
    return self.Bosses
end

function ZE:GetBoss( ent )
    for _, boss in pairs( self:GetBosses() ) do
        if boss:GetCounterEntity() == ent then
            return boss
        end
        if boss:GetIntakeEntity() == ent then
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
    end
end)

hook.Add( "EntityRemoved", "tdsze_bosskilled", function( ent )
    local boss = ZE:GetBoss( ent )
    if boss then
        boss:OnKilled()
    end
end)

hook.Add( "PostCleanupMap", "tdsze_enttypeupdate", function()
    for _, boss in pairs( ZE:GetBosses() ) do
        for k, v in pairs( ents.FindByName( boss:GetCounter() ) ) do
            if COUNTERS[v:GetClass()] then
                boss:SetType( OBJ_COUNTER )
            elseif BREAKABLE[v:GetClass()] then
                boss:SetType( OBJ_PHYSBOX )
            end
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