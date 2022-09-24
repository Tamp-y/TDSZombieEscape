-- ██╗  ██╗██╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗
-- ██║  ██║██║   ██║████╗ ████║██╔══██╗████╗  ██║    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
-- ███████║██║   ██║██╔████╔██║███████║██╔██╗ ██║    ███████╗██║     ██║   ██║██████╔╝█████╗
-- ██╔══██║██║   ██║██║╚██╔╝██║██╔══██║██║╚██╗██║    ╚════██║██║     ██║   ██║██╔══██╗██╔══╝
-- ██║  ██║╚██████╔╝██║ ╚═╝ ██║██║  ██║██║ ╚████║    ███████║╚██████╗╚██████╔╝██║  ██║███████╗
-- ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

function GM:SetHumanScore( int )
    SetGlobalInt( "HumanScore", int )
end

function GM:GetHumanScore()
    return GetGlobalInt( "HumanScore" )
end

function GM:IncreaseHumanScore( int )
    scr = self:GetHumanScore()
    scr = scr + int
    self:SetHumanScore( scr )
end

function GM:ResetHumanScore()
    self:SetHumanScore( 0 )
end

-- ███████╗ ██████╗ ███╗   ███╗██████╗ ██╗███████╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗
-- ╚══███╔╝██╔═══██╗████╗ ████║██╔══██╗██║██╔════╝    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
--   ███╔╝ ██║   ██║██╔████╔██║██████╔╝██║█████╗      ███████╗██║     ██║   ██║██████╔╝█████╗
--  ███╔╝  ██║   ██║██║╚██╔╝██║██╔══██╗██║██╔══╝      ╚════██║██║     ██║   ██║██╔══██╗██╔══╝
-- ███████╗╚██████╔╝██║ ╚═╝ ██║██████╔╝██║███████╗    ███████║╚██████╗╚██████╔╝██║  ██║███████╗
-- ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚═╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

function GM:SetZombieScore( int )
    SetGlobalInt( "ZombieScore", int )
end

function GM:GetZombieScore()
    return GetGlobalInt( "ZombieScore", int )
end

function GM:IncreaseZombieScore( int )
    scr = self:GetZombieScore()
    scr = scr + int
    self:SetZombieScore( scr )
end

function GM:ResetZombieScore()
    self:SetZombieScore( 0 )
end