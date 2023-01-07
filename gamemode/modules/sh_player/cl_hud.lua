-- ██╗   ██╗ █████╗ ██████╗ ██╗ █████╗ ██████╗ ██╗     ███████╗███████╗
-- ██║   ██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║     ██╔════╝██╔════╝
-- ██║   ██║███████║██████╔╝██║███████║██████╔╝██║     █████╗  ███████╗
-- ╚██╗ ██╔╝██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║     ██╔══╝  ╚════██║
--  ╚████╔╝ ██║  ██║██║  ██║██║██║  ██║██████╔╝███████╗███████╗███████║
--   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚══════╝

TDS_ClientConVar( "tds_hud_ze", 1, true ) --enable
TDS_ClientConVar( "tds_hud_ze_scale", 1, true ) --scale
--health
TDS_ClientConVar( "tds_hud_ze_health", 1, true ) --enable
TDS_ClientConVar( "tds_hud_ze_health_xadd", 0, true ) --x pos add
TDS_ClientConVar( "tds_hud_ze_health_yadd", 0, true ) --y pos add
TDS_ClientConVar( "tds_hud_ze_health_width", 200, true ) --bar width
TDS_ClientConVar( "tds_hud_ze_health_height", 20, true ) --bar height
--target
TDS_ClientConVar( "tds_hud_ze_target", 1, true ) --enable
TDS_ClientConVar( "tds_hud_ze_target_xadd", 0, true ) --x pos add
TDS_ClientConVar( "tds_hud_ze_target_yadd", 0, true ) --y pos add
TDS_ClientConVar( "tds_hud_ze_target_width", 300, true ) --bar width
TDS_ClientConVar( "tds_hud_ze_target_height", 10, true ) --bar height
--player target
TDS_ClientConVar( "tds_hud_ze_playertarget", 1, true ) --enable
TDS_ClientConVar( "tds_hud_ze_playertarget_xadd", 0, true ) --x pos add
TDS_ClientConVar( "tds_hud_ze_playertarget_yadd", 0, true ) --y pos add
--timer
TDS_ClientConVar( "tds_hud_ze_timer", 1, true ) --enable
TDS_ClientConVar( "tds_hud_ze_timer_xadd", 0, true ) --x pos add
TDS_ClientConVar( "tds_hud_ze_timer_yadd", 0, true ) --y pos add
TDS_ClientConVar( "tds_hud_ze_timer_width", 350, true ) --bar width
TDS_ClientConVar( "tds_hud_ze_timer_height", 75, true ) --bar height
--other
TDS_ClientConVar( "tds_hud_ze_fulldisplay", 0, true )

--[[
HUDCOL_PRIMARY = HUDCOL_PRIMARY or Color( 0, 115, 150, 255 )
HUDCOL_SECONDARY = HUDCOL_SECONDARY or Color( 0, 75, 100)
HUDCOL_TERTIARY = HUDCOL_TERTIARY or Color( 100, 100, 100, 100 )
HUDCOL_GOOD = HUDCOL_GOOD or Color( 150, 75, 50, 255 )
HUDCOL_BAD = HUDCOL_BAD or Color( 150, 20, 20, 255 )
]]

-- ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║███████║
-- ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

function SetupVariables()
    HUDCOL_PRIMARY = Color( 0, 105, 200 )
    HUDCOL_SECONDARY = Color( 100, 100, 100 )
    HUDCOL_TERTIARY = Color( 45, 45, 45 )
    HUDCOL_GOOD = Color( 115, 175, 50 )
    HUDCOL_BAD = Color( 150, 20, 20, 255 )
    HUDCOL_BLACK = Color( 0, 0, 0 )
    HUDCOL_WHITE = Color( 255, 255, 255 )
    HUD_SCALE = GetConVar("tds_hud_ze_scale"):GetFloat()
end

function FD()
    local bool = tobool( GetConVar("tds_hud_ze_fulldisplay"):GetInt() ) and true or false
    return bool
end

function ShouldDrawHUD()
    local HUD = GetConVar("tds_hud_ze"):GetInt()

    if FD() then return true end
    if not tobool( HUD ) then return false end
    return true
end

function ShouldDrawHealth()
    local HUD_HEALTH = GetConVar("tds_hud_ze_health"):GetInt()

    if FD() then return true end
    if not tobool( HUD_HEALTH ) then return false end
    if not LocalPlayer():Alive() then return false end
    return true
end

function ShouldDrawTarget()
    local HUD_TARGET = GetConVar("tds_hud_ze_target"):GetInt()

    if FD() then return true end
    if not tobool( HUD_TARGET ) then return false end
    if not HasActiveTarget() then return false end
    if not LocalPlayer():Alive() then return false end
    return true
end

function ShouldDrawPlayerTarget()
    local HUD_TARGET = GetConVar("tds_hud_ze_playertarget"):GetInt()

    if FD() then return true end
    if not tobool( HUD_TARGET ) then return false end
    if not LocalPlayer():Alive() then return false end
    return true
end

function ShouldDrawTimer()
    local HUD_TIMER = GetConVar("tds_hud_ze_timer"):GetInt()

    if FD() then return true end
    if not tobool( HUD_TIMER ) then return false end
    if not LocalPlayer():Alive() then return false end
    return true
end

function ShouldDrawRoundEnd()
    if not GAMEMODE:RoundEnding() then return false end
    return true
end

-- ██████╗ ██████╗  █████╗ ██╗    ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██║    ██║
-- ██║  ██║██████╔╝███████║██║ █╗ ██║
-- ██║  ██║██╔══██╗██╔══██║██║███╗██║
-- ██████╔╝██║  ██║██║  ██║╚███╔███╔╝
-- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝

function GM:HUDPaint()
    if not ShouldDrawHUD() then return end

    SetupVariables()

    CheckScale = CheckScale or nil
    if CheckScale != HUD_SCALE then BuildFonts() end

    --Health
    if ShouldDrawHealth() then
        local xadd, yadd, cwidth, cheight = GetConVar("tds_hud_ze_health_xadd"):GetInt(), GetConVar("tds_hud_ze_health_yadd"):GetInt(), GetConVar("tds_hud_ze_health_width"):GetInt(), GetConVar("tds_hud_ze_health_height"):GetInt() --Adjustable Settings
        local xpos, ypos = 50, (ScrH() * 0.955) --Default
        local width, height = (cwidth * HUD_SCALE), (cheight * HUD_SCALE) --Calculations
        local x, y = xpos, ypos - height --Calculations

        y = y + (height / 2) - (2 * HUD_SCALE)
        draw.SimpleTextOutlined( "HP", "TDSHudNormal", x, y, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        x, y = x + (40 * HUD_SCALE), y - height
        surface.SetDrawColor( HUDCOL_PRIMARY )
        surface.DrawOutlinedRect( x - 3, y - 3, width + 6, height + 6 ) --Outline
        surface.DrawRect( x, y, math.Clamp( LocalPlayer():Health() / LocalPlayer():GetMaxHealth() * width, 0, width ), height ) --Bar
        x, y = x + width + 10, y + (height / 2) - 2
        draw.SimpleTextOutlined( LocalPlayer():Health(), "TDSHudNormal", x, y, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, HUDCOL_BLACK )
    end

    --Target
    if ShouldDrawTarget() then
        local xadd, yadd, cwidth, cheight = GetConVar("tds_hud_ze_target_xadd"):GetInt(), GetConVar("tds_hud_ze_target_yadd"):GetInt(), GetConVar("tds_hud_ze_target_width"):GetInt(), GetConVar("tds_hud_ze_target_height"):GetInt() --Adjustable Settings
        local xpos, ypos = (ScrW() / 2), (ScrH() * 0.29) --Default
        local width, height = (cwidth * HUD_SCALE), (cheight * HUD_SCALE) --Calculations
        local x, y = xpos - ((cwidth * HUD_SCALE) / 2), ypos --Calculations
        local targetname, targethealth, targetmaxhealth = GetActiveTarget() or "Example", GetActiveTargetHealth(), GetActiveTargetMaxHealth()

        surface.SetDrawColor( HUDCOL_BAD )
        surface.DrawOutlinedRect( x - 3, y - 3, width + 6, height + 6 )
        surface.DrawRect( x, y, math.Clamp( (targethealth / targetmaxhealth) * width, 0, width ), height )
        draw.SimpleTextOutlined( targetname, "TDSHudSmall", xpos, y - (5 * HUD_SCALE), HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( targethealth, "TDSHudSmall", xpos, y + (4 * HUD_SCALE), HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_BLACK )
    end

    --Player Target
    if ShouldDrawPlayerTarget() then
        local xadd, yadd = GetConVar("tds_hud_ze_playertarget_xadd"):GetInt(), GetConVar("tds_hud_ze_playertarget_yadd"):GetInt() --Adjustments
        local xpos, ypos = (ScrW() / 2), (ScrH() * 0.55) --Default
        local x, y = (xpos + xadd), (ypos + yadd) --Calculations
        local tr = util.TraceLine({
            start = LocalPlayer():EyePos(),
            endpos = LocalPlayer():GetShootPos() + (LocalPlayer():GetAimVector() * 10000),
            filter = LocalPlayer()
        })
        local ent = tr.Entity
        
        if FD() or ent and IsValid( ent ) and ent:IsPlayer() then
            local plytarget, plyhealth = ent:Nick() or "Player Name", ent:Health() or 100

            draw.SimpleTextOutlined( plytarget, "TDSHudSmall", x, y, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
            draw.SimpleTextOutlined( plyhealth, "TDSHudSmall", x, y + (15 * HUD_SCALE), HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        end
    end

    --Timer
    if ShouldDrawTimer() then
        local xadd, yadd, cwidth, cheight = GetConVar("tds_hud_ze_timer_xadd"):GetInt(), GetConVar("tds_hud_ze_timer_yadd"):GetInt(), GetConVar("tds_hud_ze_timer_width"):GetInt(), GetConVar("tds_hud_ze_timer_height"):GetInt() --Adjustable Settings
        local xpos, ypos = ScrW() / 2, 0 --Default
        local width, height = (cwidth * HUD_SCALE), (cheight * HUD_SCALE) --Calculations
        local x, y = xpos - (width / 2), ypos --Calculations
        local maptime, roundtime, hwin, zwin, hteam, zteam = Developing() and "Devmode" or GAMEMODE:MapTimeLeftMinutesSeconds(), GAMEMODE:CalculateTimeLeft(), GAMEMODE:GetHumanScore(), GAMEMODE:GetZombieScore(), #team.GetPlayers( 3 ), #team.GetPlayers( 2 )
    
        local colT = HUDCOL_BLACK:ToTable()
        surface.SetDrawColor( Color( colT[1], colT[2], colT[3], 200 ) )
        surface.DrawRect( x, y, width, height )
        draw.SimpleTextOutlined( maptime, "TDSHudLarge", xpos, y + 10, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( hwin .. " - " .. zwin, "TDSHudNormal", xpos, y + height - 10, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( "Humans", "TDSHudNormal", x + ( 50 * HUD_SCALE ), y + 10, HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( hteam, "TDSHudNormal", x + ( 50 * HUD_SCALE ), y + height - (10 * HUD_SCALE), HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( "Zombies", "TDSHudNormal", x + width - ( 50 * HUD_SCALE ), y + 10, HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( zteam, "TDSHudNormal", x + width - ( 50 * HUD_SCALE ), y + height - (10 * HUD_SCALE), HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        if FD() or not GAMEMODE:InWarmup() and not GAMEMODE:RoundEnding() and not Developing() and GAMEMODE:CalculateTimeLeft() <= 300 then
            draw.SimpleTextOutlined( "Round Ending in " .. GAMEMODE:TimeLeftMinutesSeconds(), "TDSHudSmall", xpos, height + 5, HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        end
    end

    if FD() or GAMEMODE:InWarmup() then
        draw.SimpleTextOutlined( "Warmup ending in " .. math.ceil(GAMEMODE:CalculateTimeLeft()) .. " seconds.", "TDSHudNormal", ScrW() / 2, ScrH() * 0.35, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_BLACK )
    end
    if FD() or GAMEMODE:InPreSelection() then
        draw.SimpleTextOutlined( "Zombie Selection in " .. math.ceil(GAMEMODE:CalculateSelectionTimer()) .. " seconds.", "TDSHudNormal", ScrW() / 2, ScrH() * 0.35, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_BLACK )
    end

    --Round End
    if ShouldDrawRoundEnd() then
        local winner = GetGlobalInt( "RoundWinner" )

        surface.SetDrawColor( 0, 0, 0, 150 )
        surface.DrawRect( 0, 0, ScrW(), ScrH() )

        local txt = FD() and "$Team Win" or winner == 2 and "Zombies Win" or winner == 3 and #team.GetPlayers(3) <= 1 and "Solo Win!!!" or winner == 3 and "Humans Win"
        local col = FD() and HUDCOL_GOOD or winner == 2 and HUDCOL_BAD or winner == 3 and HUDCOL_GOOD

        draw.SimpleTextOutlined( txt, "TDSHudVeryLarge", ScrW() / 2, ScrH() * 0.35, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( "Round Restarting in " .. math.ceil( GAMEMODE:CalculateTimeLeft() ) .. " seconds.", "TDSHudVeryLarge", ScrW() / 2, ScrH() * 0.35, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
    end

    --[[

    --Round End
    if GAMEMODE:RoundEnding() then
        local winner = GetGlobalInt( "RoundWinner" )

        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawRect( 0, 0, ScrW(), ScrH() )

        if winner == 2 then
            draw.SimpleTextOutlined( "Zombies Win", "TDSHudVeryLarge", ScrW() / 2, ScrH() * 0.4, HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_BAD )
        elseif winner == 3 then
            draw.SimpleTextOutlined( "Humans Win", "TDSHudVeryLarge", ScrW() / 2, ScrH() * 0.4, HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_GOOD )
        end
        draw.SimpleTextOutlined( "Round restarting in " .. math.ceil( GAMEMODE:CalculateTimeLeft() ) .. " seconds", "TDSHudNormal", ScrW() / 2, ScrH() * 0.435, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_SECONDARY )
    end
    ]]
end

function BuildFonts()
    surface.CreateFont( "TDSHudNormal", {
        font 		= "CloseCaption_Bold",
        extended 	= false,
        size 		= 25 * HUD_SCALE,
        weight 		= 2000,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    } )

    surface.CreateFont( "TDSHudSmall", {
        font 		= "CloseCaption_Bold",
        extended 	= false,
        size 		= 15 * HUD_SCALE,
        weight 		= 2000,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    } )

    surface.CreateFont( "TDSHudLarge", {
        font 		= "CloseCaption_Bold",
        extended 	= false,
        size 		= 30 * HUD_SCALE,
        weight 		= 2000,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    } )

    surface.CreateFont( "TDSHudVeryLarge", {
        font 		= "CloseCaption_Bold",
        extended 	= false,
        size 		= 50 * HUD_SCALE,
        weight 		= 2000,
        blursize 	= 0,
        scanlines 	= 0,
        antialias 	= true,
        underline 	= false,
        italic 		= false,
        strikeout 	= false,
        symbol 		= false,
        rotary 		= false,
        shadow 		= false,
        additive 	= false,
        outline 	= false,
    } )

    CheckScale = HUD_SCALE
end

hook.Add( "HUDShouldDraw", "TDS_ZE_HideDefaultHUD", function( obj )
    local Hidden = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true,
    }
    if Hidden[ obj ] then return false end
    return true
end)