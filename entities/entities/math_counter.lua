ENT.Base = "base_point"
ENT.Type = "point"

function ENT:Initialize()
    
end

function ENT:AcceptInput( str, activator, caller, data )
    if str == "Add" then

    elseif str == "Subtract" then


    print( str, activator )
end

-- Input Funcs

function ENT:Add()

end

-- Values

function ENT:SetObjectValue( int )
    self:OnValueChanged( self.value, int )
    self.value = int
end

function ENT:GetObjectValue()
    return self.value or 0
end

function ENT:SetMaxValue( int )
    self.maxValue = int
end

function ENT:GetMaxValue()
    return self.maxValue or 0
end

function ENT:SetMinValue( int )
    self.minValue = int
end

function ENT:GetMinValue()
    return self.minValue or 0
end

-- Events

function ENT:OnValueChanged( old, new )
    hook.Call( "MathCounterValueChange", GAMEMODE, self )

    if self:GetObjectValue() >= self:GetMaxValue() then self:OnHitMaxValue() end
    if self:GetObjectValue() <= self:GetMinValue() then self:OnHitMinValue() end
end

function ENT:OnHitMaxValue()
    local curValue = self:GetObjectValue()
    hook.Call( "MathCounterHitMax", GAMEMODE, self )
end

function ENT:OnHitMinValue()
    local curValue = self:GetObjectValue()
    hook.Call( "MathCounterHitMin", GAMEMODE, self )
end