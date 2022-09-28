-- ██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗     ████████╗██╗███╗   ███╗███████╗██████╗
-- ██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
-- ██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║       ██║   ██║██╔████╔██║█████╗  ██████╔╝
-- ██╔══██╗██║   ██║██║   ██║██║╚██╗██║██║  ██║       ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
-- ██║  ██║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝       ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

function GM:SetTimer( int )
    SetGlobalFloat( "RoundTime", CurTime() + int )
end

function GM:GetTimer()
    return GetGlobalFloat( "RoundTime" )
end

function GM:CalculateTimeLeft()
    local timeleft = self:GetTimer()
    timeleft = timeleft - CurTime()
    timeleft = timeleft < 0 and 0 or timeleft
    return timeleft
end

function GM:TimeLeftMinutesSeconds()
    local time = math.ceil( self:CalculateTimeLeft() )
    local minutes = math.floor( time / 60 )
    local seconds = time - (minutes * 60)
    if seconds < 10 then seconds = 0 .. seconds end
    return minutes .. ":" .. seconds
end

-- ███╗   ███╗ █████╗ ██████╗     ████████╗██╗███╗   ███╗███████╗██████╗
-- ████╗ ████║██╔══██╗██╔══██╗    ╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
-- ██╔████╔██║███████║██████╔╝       ██║   ██║██╔████╔██║█████╗  ██████╔╝
-- ██║╚██╔╝██║██╔══██║██╔═══╝        ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
-- ██║ ╚═╝ ██║██║  ██║██║            ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝            ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

function GM:SetMapTimer( int )
    SetGlobalFloat( "MapTime", CurTime() + int )
end

function GM:GetMapTimer()
    return GetGlobalFloat( "MapTime" )
end

function GM:CalculateMapTimeLeft()
    local timeleft = self:GetMapTimer()
    timeleft = timeleft - CurTime()
    timeleft = timeleft < 0 and 0 or timeleft
    return timeleft
end

function GM:MapTimeLeftMinutesSeconds()
    local time = math.ceil( self:CalculateMapTimeLeft() )
    local minutes = math.floor( time / 60 )
    local seconds = time - (minutes * 60)
    if seconds < 10 then seconds = 0 .. seconds end
    return minutes .. ":" .. seconds
end

-- ███████╗███████╗██╗     ███████╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗    ████████╗██╗███╗   ███╗███████╗██████╗
-- ██╔════╝██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ╚══██╔══╝██║████╗ ████║██╔════╝██╔══██╗
-- ███████╗█████╗  ██║     █████╗  ██║        ██║   ██║██║   ██║██╔██╗ ██║       ██║   ██║██╔████╔██║█████╗  ██████╔╝
-- ╚════██║██╔══╝  ██║     ██╔══╝  ██║        ██║   ██║██║   ██║██║╚██╗██║       ██║   ██║██║╚██╔╝██║██╔══╝  ██╔══██╗
-- ███████║███████╗███████╗███████╗╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║       ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║
-- ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝       ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

function GM:SetSelectionTimer( int )
    SetGlobalFloat( "SelectionTime", CurTime() + int )
end

function GM:GetSelectionTimer()
    return GetGlobalFloat( "SelectionTime" )
end

function GM:CalculateSelectionTimer()
    local timeleft = self:GetSelectionTimer()
    timeleft = timeleft - CurTime()
    timeleft = timeleft < 0 and 0 or timeleft
    return timeleft
end

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗ █████╗ ██╗     ██╗████████╗██╗   ██╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔══██╗██║     ██║╚══██╔══╝╚██╗ ██╔╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████║██║     ██║   ██║    ╚████╔╝
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║██╔══██║██║     ██║   ██║     ╚██╔╝
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║██║  ██║███████╗██║   ██║      ██║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝

--Warmup

function GM:StartWarmup() --Will start warmup. Usually 30 seconds to give players a chance to load in.
    SetGlobalBool( "Warmup", true )
    self:SetTimer( SET["WarmupLength"] )
end

function GM:EndWarmup() --Will end warmup and begin the game.
    self.WarmupEnded = true
    SetGlobalBool( "Warmup", false )
    self:ResetRound()
end

function GM:InWarmup()
    if GetGlobalBool( "Warmup" ) then
        return true
    else
        return false
    end
end

--Rounds

function GM:StartRound() --Will begin the round.
    SelectionOver = false
    self:SetTimer( SET["RoundLength"] )
    self:SetSelectionTimer( SET["SelectionLength"] )
    for k, v in pairs( player.GetAll() ) do
        v:Spawn()
    end
end

function GM:MotherSelection() --Will randomly pick players to be mother zombie.
    local zombiesToPick = math.ceil( #player.GetAll() * (SET["SelectionPercent"] / 100) )

    for i = 1, zombiesToPick do
        local ply = table.Random( player.GetAll() )
        ply:BecomeZombie()
        ply:Spawn()
    end

    SelectionOver = true
end

function GM:InPreSelection() --Game is prior to zombie selection
    if CurTime() < self:GetSelectionTimer() then
        return true
    else
        return false
    end
end

function GM:EndRound( winner ) --Will end the round and perform a map cleanup.
    SetGlobalBool( "RoundEnd", true )
    self:SetTimer( SET["EndRoundLength"] )

    if winner == "human" then
        self:IncreaseHumanScore( 1 )
        SetGlobalInt( "RoundWinner", 3 )
    elseif winner == "zombie" then
        self:IncreaseZombieScore( 1 )
        SetGlobalInt( "RoundWinner", 2 )
    end
end

function GM:RoundEnding()
    if GetGlobalBool( "RoundEnd" ) then
        return true
    else
        return false
    end
end

function GM:ResetRound() --Will reset the round entirely but keep the map progress.
    if SERVER then
        for k, v in pairs( player.GetAll() ) do
            v:Spectate( OBS_MODE_ROAMING )
        end
        game.CleanUpMap( false, {"info_target", "func_brush"} )
    end

    SetGlobalBool( "RoundEnd", false )
    self:StartRound()
end

function GM:ResetGame() --Performs a full gamemode reset. The game behaviour will be the same as if it just swapped maps.
    for k, v in pairs( player.GetAll() ) do
        v:Spectate( OBS_MODE_ROAMING )
    end
    game.CleanUpMap( false )

    self:StartRound()

    self.WarmupEnded = false
end

-- ██╗  ██╗ ██████╗  ██████╗ ██╗  ██╗███████╗
-- ██║  ██║██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝
-- ███████║██║   ██║██║   ██║█████╔╝ ███████╗
-- ██╔══██║██║   ██║██║   ██║██╔═██╗ ╚════██║
-- ██║  ██║╚██████╔╝╚██████╔╝██║  ██╗███████║
-- ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝

if SERVER then

    hook.Add( "InitPostEntity", "tds_BeginGame", function() --Everything needed to begin the game goes here (after map has finished loading)
        if Developing() then return end
        GAMEMODE:StartWarmup()
        GAMEMODE:SetMapTimer( SET["MapLength"] )
    end)

    hook.Add( "Think", "tds_TimerFunction", function()

        if Developing() then return end

        local zAlive = 0
            for k, v in pairs( team.GetPlayers( 2 ) ) do
                if v:Alive() then
                    zAlive = zAlive + 1
                end
            end

        if #player.GetAll() > 0 and not GAMEMODE:InWarmup() and not GAMEMODE.WarmupEnded then --Begin a warmup round
            GAMEMODE:StartWarmup()
        end

        if GAMEMODE:InWarmup() and CurTime() > GAMEMODE:GetTimer() then --Warmup ends
            GAMEMODE:EndWarmup()
        end

        if not GAMEMODE:InWarmup() and not GAMEMODE:RoundEnding() then

            if not SET["NoSelection"] and not (SelectionOver or false) and CurTime() > GAMEMODE:GetSelectionTimer() then
                GAMEMODE:MotherSelection()
            end

            if #team.GetPlayers( 3 ) == 0 then --All humans died, zombies win
                GAMEMODE:EndRound( "zombie" )
            end

            if not SET["NoSelection"] and #player.GetAll() > 1 and SelectionOver and CurTime() > (GAMEMODE:GetSelectionTimer() + 1) and (#team.GetPlayers( 3 ) > 0 and zAlive <= 0) then --All zombies died, humans win
                GAMEMODE:EndRound( "human" )
            end

        end

        if CurTime() > GAMEMODE:GetTimer() then
            GAMEMODE:ResetRound()
        end
    end)

end