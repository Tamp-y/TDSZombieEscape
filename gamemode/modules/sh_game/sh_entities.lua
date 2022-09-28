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
end