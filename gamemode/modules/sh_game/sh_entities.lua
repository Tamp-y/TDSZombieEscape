if SERVER then

    local function FixBotTriggers()
        for k, v in pairs( ents.FindByClass( "trigger_*" ) ) do
            local sf = v:GetKeyValues()["spawnflags"]
            if sf == 4097 then
                v:SetKeyValue( "spawnflags", 1 )
            end
        end
    end

    hook.Add( "InitPostEntity", "tds_botstrigger", function()
        FixBotTriggers()
    end)

    hook.Add( "PostCleanupMap", "tds_botstrigger", function()
        FixBotTriggers()
    end)
end