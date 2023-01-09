if SERVER then

    local function FixBotTriggers()
        for k, v in pairs( ents.FindByClass( "trigger_*" ) ) do
            local sf = v:GetKeyValues()["spawnflags"]
            if sf == 4097 then
                v:SetKeyValue( "spawnflags", 1 )
            end
        end
    end

    local function FixPhysbox()
        for k, v in pairs( ents.FindByClass( "func_physbox_multiplayer" ) ) do
            local sf = v:GetKeyValues()["spawnflags"]
            if sf == 35841 then
                v:Remove()
            end
        end
    end

    hook.Add( "InitPostEntity", "tds_botstrigger", function()
        FixBotTriggers()
        FixPhysbox()
    end)

    hook.Add( "PostCleanupMap", "tds_botstrigger", function()
        FixBotTriggers()
        FixPhysbox()
    end)

    hook.Add( "AllowPlayerPickup", "tds_fixEpickup", function( ply, ent ) 
        return false
    end)

    hook.Add( "PlayerCanPickupWeapon", "tds_antiweaponstack", function( ply, wep ) 
        if not wep.Base == "tds_basewep" then return false end --ignore weapons not apart of weapon base

        if ply:Team() == 2 and not wep.ZItem then return false end
        if wep:IsPrimaryWeapon() and ply:HasPrimaryWeapon() then return false end
        if wep:IsSecondaryWeapon() and ply:HasSecondaryWeapon() then return false end
        return true
    end)

end