function SetActiveTarget( ent )
    Target = ent
end

function GetActiveTarget()
    return Target or nil
end

function HasActiveTarget()
    if GetActiveTarget() then return true else return false end
end

function ClearActiveTarget()
    Target = nil
end

function SetTargetLength( time )
    TargetLoss = time
end

function GetTargetLength()
    return TargetLoss
end

hook.Add("Think", "TDS_ZombieEscapeTarget", function()
    local ply = LocalPlayer()
    local wep = ply:GetActiveWeapon()
    local trace = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + (ply:GetAimVector() * 10000),
        filter = ply,
        mask = MASK_SHOT
    })
    local ent = trace.Entity
    if IsValid(ent) and ent:Health() > 0 then
        SetActiveTarget( ent )
        SetTargetLength( CurTime() + 5 )
    end

    if HasActiveTarget() and CurTime() > GetTargetLength() or not IsValid( GetActiveTarget() ) then
        ClearActiveTarget()
    end
end)