function SetActiveTarget( name, health, maxhealth )
    Target = name
    Target_Health = health
    Target_MaxHealth = maxhealth

    SetTargetLength( CurTime() + 5 )
end

function SetTargetLength( time )
    Target_Length = time
end

function GetActiveTarget()
    return Target or nil
end

function GetTargetLength()
    return Target_Length or 0
end

function GetActiveTargetHealth()
    return Target_Health or 100
end

function GetActiveTargetMaxHealth()
    return Target_MaxHealth or 100
end

function HasActiveTarget()
    if GetActiveTarget() then return true else return false end
end

function ClearActiveTarget()
    Target = nil
    Target_Health = nil
    Target_MaxHealth = nil
end

hook.Add("Think", "TDS_ZombieEscapeTarget", function()
    if CurTime() > GetTargetLength() then
        ClearActiveTarget()
    end
end)