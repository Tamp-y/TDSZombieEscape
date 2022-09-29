local hud = TDS_ClientConVar( "tds_hud_ze", 1, true ) --enable hud
local scale = TDS_ClientConVar( "tds_hud_ze_scale", 1, true ) --hud scale
local widthedge = TDS_ClientConVar( "tds_hud_ze_wedge", 0, true ) --hud width edge
local heightedge = TDS_ClientConVar( "tds_hud_ze_hedge", 0, true ) --hud height edge
--health vars
local health = TDS_ClientConVar( "tds_hud_ze_health", 1, true )
local health_xadd = TDS_ClientConVar( "tds_hud_ze_health_xadd", 0, true )
local health_yadd = TDS_ClientConVar( "tds_hud_ze_health_yadd", 0, true )
local health_width = TDS_ClientConVar( "tds_hud_ze_health_width", 200, true )
local health_height = TDS_ClientConVar( "tds_hud_ze_health_height", 20, true )
--time vars
local time = TDS_ClientConVar( "tds_hud_ze_time", 1, true )
local time_xadd = TDS_ClientConVar( "tds_hud_ze_time_xadd", 0, true )
local time_yadd = TDS_ClientConVar( "tds_hud_ze_time_yadd", 0, true )

HUDCOL_PRIMARY = HUDCOL_PRIMARY or Color( 0, 115, 150, 255 )
HUDCOL_SECONDARY = HUDCOL_SECONDARY or Color( 0, 75, 100)
HUDCOL_TERTIARY = HUDCOL_TERTIARY or Color( 100, 100, 100, 100 )
HUDCOL_GOOD = HUDCOL_GOOD or Color( 150, 75, 50, 255 )
HUDCOL_BAD = HUDCOL_BAD or Color( 150, 20, 20, 255 )

function GM:HUDPaint()
    if not tobool( hud:GetInt() ) then return end

    CheckScale = CheckScale or nil
    if CheckScale != scale:GetInt() then BuildFonts() end

    local ply = LocalPlayer()

    --Health
    if tobool( health:GetInt() ) then
        local xadd, yadd, width, height, outline = health_xadd:GetInt(), health_yadd:GetInt(), health_width:GetInt() * scale:GetInt(), health_height:GetInt() * scale:GetInt(), 1
        local xpos, ypos = 50, (ScrH() * 0.955) - height
        local x, y = (xpos + xadd) * scale:GetInt(), ypos + (yadd * scale:GetInt())
        local colT = HUDCOL_TERTIARY:ToTable()
        draw.SimpleTextOutlined( "HP", "TDSHudNormal", x, y + (height / 2), HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, HUDCOL_SECONDARY )
        x = x + (35 * scale:GetInt())
        surface.SetDrawColor( colT[1], colT[2], colT[3], 50 )
        surface.DrawRect( x, y, width, height, outline )
        surface.SetDrawColor( HUDCOL_SECONDARY )
        surface.DrawOutlinedRect( x, y, width, height, outline )
        surface.SetDrawColor( HUDCOL_PRIMARY )
        surface.DrawRect( x + 1, y + 1, math.Clamp( ply:Health() / ply:GetMaxHealth() * width, 0, width ) - 2, height - 2 )
        draw.SimpleTextOutlined( ply:Health(), "TDSHudSmall", x + width + 5, y + (height / 2), HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, HUDCOL_SECONDARY )
    end

    if HasActiveTarget() then
        local targetname, targethealth, targetmaxhealth = GetActiveTarget(), GetActiveTargetHealth(), GetActiveTargetMaxHealth()
        local width, height, outline = 250, 15, 1
        local xpos, ypos = ScrW() / 2 - width / 2, ScrH() * 0.3
        local x, y = xpos, ypos
        local colT = HUDCOL_TERTIARY:ToTable()
        surface.SetDrawColor( colT[1], colT[2], colT[3], 50 )
        surface.DrawRect( x, y, width, height )
        surface.SetDrawColor( HUDCOL_SECONDARY )
        surface.DrawOutlinedRect( x, y, width, height )
        surface.SetDrawColor( HUDCOL_PRIMARY )
        surface.DrawRect( x, y, math.Clamp( (targethealth / targetmaxhealth) * width, 0, width ), height )
        draw.SimpleTextOutlined( targetname, "TDSHudSmall", x + (width / 2), y + (height / 2) - 20, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_SECONDARY )
        draw.SimpleTextOutlined( targethealth, "TDSHudSmall", x + (width / 2), y + (height / 2), HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, HUDCOL_SECONDARY )
    end

    local width, height = 350, 65
    local colT = Color( 0, 0, 0 ):ToTable()
    surface.SetDrawColor( colT[1], colT[2], colT[3], 150 )
    surface.DrawRect( ScrW() / 2 - width / 2, 0, width, height )
    draw.SimpleTextOutlined( GAMEMODE:MapTimeLeftMinutesSeconds(), "TDSHudLarge", ScrW() / 2, 10, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
    
    if GAMEMODE:InWarmup() then
        draw.SimpleTextOutlined( "Warmup ending in " .. math.ceil(GAMEMODE:CalculateTimeLeft()) .. " seconds.", "TDSHudNormal", ScrW() / 2, ScrH() * 0.35, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, HUDCOL_SECONDARY )
    else
        if GAMEMODE:InPreSelection() and not SET["NoSelection"] then
            draw.SimpleTextOutlined( "Mother Zombies Spawning in " .. math.ceil(GAMEMODE:CalculateSelectionTimer()) .. " seconds.", "TDSHudSmall", ScrW() / 2, ScrH() * 0.275, HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
        end
        draw.SimpleTextOutlined( GAMEMODE:GetHumanScore() .. " - " .. GAMEMODE:GetZombieScore(), "TDSHudSmall", ScrW() / 2, 40, HUDCOL_PRIMARY, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
        draw.SimpleTextOutlined( "Humans", "TDSHudSmall", ScrW() / 2 - 125, 10, HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
        draw.SimpleTextOutlined( #team.GetPlayers( 3 ), "TDSHudLarge", ScrW() / 2 - 125, 25, HUDCOL_GOOD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
        draw.SimpleTextOutlined( "Zombies", "TDSHudSmall", ScrW() / 2 + 125, 10, HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
        draw.SimpleTextOutlined( #team.GetPlayers( 2 ), "TDSHudLarge", ScrW() / 2 + 125, 25, HUDCOL_BAD, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, HUDCOL_SECONDARY )
    end


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

end

function BuildFonts()
    surface.CreateFont( "TDSHudNormal", {
        font 		= "CloseCaption_Bold",
        extended 	= false,
        size 		= 25 * scale:GetInt(),
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
        size 		= 15 * scale:GetInt(),
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
        size 		= 30 * scale:GetInt(),
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
        size 		= 50 * scale:GetInt(),
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

    CheckScale = scale:GetInt()
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