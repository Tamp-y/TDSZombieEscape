ENT.Base = "base_point"
ENT.Type = "point"

ENT.Inputs = {}

function ENT:Initialize()
    --Inputs
    self.m_flMin = self.m_flMin or 0
    self.m_flMax = self.m_flMax or 0
    self.m_bHitMin = self.m_bHitMin or false
    self.m_bHitMax = self.m_bHitMax or false
    self.m_bDisabled = self.m_bDisabled or false
    
    --Outputs
    self.m_OutValue = self.m_OutValue or 0
    self.m_OnGetValue = self.m_OnGetValue or 0
    self.m_OnHitMin = self.m_OnHitMin or nil
    self.m_OnHitMax = self.m_OnHitMax or nil
end

function ENT:AcceptInput( str, activator, call, data )
    local inputc = self:FindInput( str )
    if inputc then
        inputc( self, data )
    else
        MsgC( Color( 180, 40, 40 ), "[ERROR] math_counter: Cannot find call by ID - '" .. str .. "'.\n" )
    end
end

function ENT:KeyValue( k, v )
    lk, sv = string.lower( k ), tonumber( v )
    if lk == "startvalue" then
        self:SetValue( sv )
		--return true
	elseif lk == "min" then
        self:SetMinimal( sv )
	elseif lk == "max" then
		self:SetMaximum( sv )
	end

    self:StoreOutput( k, v )
end

function ENT:FindInput( id )
    return self.Inputs[ id ]
end

-- Values

function ENT:SetValue( int )
    local val = math.Clamp( int, self:GetMinimal(), self:GetMaximum() )

    if val <= self:GetMinimal() and not self:GetIsMinimal() then --Value is less than minimal and not set to minimal
        self:SetIsMinimal( true )
        self:TriggerOutput( "OnHitMin" )
    elseif self:GetIsMinimal() then
        self:SetIsMinimal( false )
    end

    if val >= self:GetMaximum() and not self:GetIsMaximum() then --Value is more than maximum and not set to maximum
        self:SetIsMaximum( true )
        self:TriggerOutput( "OnHitMax" )
    elseif self:GetIsMaximum() then
        self:SetIsMaximum( false )
    end

    self.m_OutValue = val
end

function ENT:GetValue()
    return self.m_OutValue or 0
end

function ENT:SetMinimal( int )
    self.m_flMin = int
end

function ENT:GetMinimal()
    return self.m_flMin or 0
end

function ENT:SetMaximum( int )
    self.m_flMax = int
end

function ENT:GetMaximum()
    return self.m_flMax or 0
end

function ENT:SetIsMinimal( bool )
    self.m_bHitMin = bool
end

function ENT:GetIsMinimal()
    return self.m_bHitMin or false
end

function ENT:SetIsMaximum( bool )
    self.m_bHitMax = bool
end

function ENT:GetIsMaximum()
    return self.m_bHitMax or false
end

function ENT:SetDisabled( bool )
    self.m_bDisabled = bool
end

function ENT:GetDisabled()
    return self.m_bDisabled or false
end

-- ██╗███╗   ██╗██████╗ ██╗   ██╗████████╗███████╗
-- ██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝██╔════╝
-- ██║██╔██╗ ██║██████╔╝██║   ██║   ██║   ███████╗
-- ██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   ╚════██║
-- ██║██║ ╚████║██║     ╚██████╔╝   ██║   ███████║
-- ╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   ╚══════╝

function ENT:CreateInput( id, data )
    self.Inputs[ id ] = data
end

ENT.CreateInput( ENT, "Add", function( self, data )
    local val = self:GetValue()
    val = val + tonumber( data )
    self:SetValue( val )
end)

ENT.CreateInput( ENT, "Subtract", function( self, data )
    local val = self:GetValue()
    val = val - tonumber( data )
    self:SetValue( val )
end)

ENT.CreateInput( ENT, "Multiply", function( self, data )
    local val = self:GetValue()
    val = val * tonumber( data )
    self:SetValue( val )
end)

ENT.CreateInput( ENT, "Divide", function( self, data )
    local val = self:GetValue()
    val = val / tonumber( data )
    self:SetValue( val )
end)

ENT.CreateInput( ENT, "SetValue", function( self, data )
    local val = tonumber( data )
    self:SetValue( val )
end)

ENT.CreateInput( ENT, "SetValueNoFire", function( self, data )
    local val = tonumber( data )
    self.m_OutValue = val
end)

ENT.CreateInput( ENT, "SetHitMax", function( self, data )
    local val = tonumber( data )
    self:SetMaximum( val )
end)

ENT.CreateInput( ENT, "SetHitMin", function( self, data )
    local val = tonumber( data )
    self:SetMinimum( val )
end)

ENT.CreateInput( ENT, "Enable", function( self )
    self:SetDisabled( false )
end)

ENT.CreateInput( ENT, "Disable", function( self )
    self:SetDisabled( true )
end)

ENT.CreateInput( ENT, "Kill", function( self )
    self:Remove()
end)

ENT.CreateInput( ENT, "GetValue", function( self, data )
    self:TriggerOutput( "OnGetValue" )
end)