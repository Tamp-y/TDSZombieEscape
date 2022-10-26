function SWEP:DrawHUD()
    local length, thick, shadowthick, space, opacity = 4, 1, 1, 1, 200

    space = space + ( self:GetCurrentSpread() * 600 )

    --Crosshair Shadow
    local colT = HUDCOL_BLACK:ToTable()
    surface.SetDrawColor( Color( colT[1], colT[2], colT[3], opacity ) )
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, thick + (shadowthick * 2), thick + (shadowthick * 2) ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space) - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space - shadowthick, ScrH() / 2 - (thick / 2) - shadowthick, length + (shadowthick * 2), thick + (shadowthick * 2) ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 - (thick / 2) - (length + space) - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2) - shadowthick, ScrH() / 2 + (thick / 2) + space - shadowthick, thick + (shadowthick * 2), length + (shadowthick * 2) ) --Bottom Line

    --Crosshair Front
    local col = HUDCOL_PRIMARY:ToTable()
    surface.SetDrawColor( col[1], col[2], col[3], opacity )
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2), thick, thick ) --Dot
    surface.DrawRect( ScrW() / 2 - (thick / 2) - (length + space), ScrH() / 2 - (thick / 2), length, thick ) --Left Line
    surface.DrawRect( ScrW() / 2 + (thick / 2) + space, ScrH() / 2 - (thick / 2), length, thick ) --Right Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 - (thick / 2) - (length + space), thick, length ) --Top Line
    surface.DrawRect( ScrW() / 2 - (thick / 2), ScrH() / 2 + (thick / 2) + space, thick, length ) --Bottom Line

    if self:IsGun() then
        --Ammo
        local width, height, xoff, yoff = 250, 70, 50, 50
        local boxx, boxy = ScrW() - (width + xoff), ScrH() - (height + yoff)
        local colT = HUDCOL_TERTIARY:ToTable()
        surface.SetDrawColor( colT[1], colT[2], colT[3], 200 )
        surface.DrawRect( boxx, boxy, width, height )
        draw.SimpleTextOutlined( "Ammo", "TDSHudNormal", boxx + 5, boxy + 5, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( self:Clip1() .. " / " .. self:GetMagSize(), "TDSHudNormal", boxx + 5, boxy + 60, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( self:GetAmmoTypeName(), "TDSHudNormal", boxx + 235, boxy + 5, HUDCOL_PRIMARY, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
    elseif self:IsUtility() then
        local width, height, xoff, yoff = 250, 70, 50, 50
        local boxx, boxy = ScrW() - (width + xoff), ScrH() - (height + yoff)
        local colT = HUDCOL_TERTIARY:ToTable()
        surface.SetDrawColor( colT[1], colT[2], colT[3], 200 )
        surface.DrawRect( boxx, boxy, width, height )
        draw.SimpleTextOutlined( self.PrintName, "TDSHudNormal", boxx + 5, boxy + 5, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, HUDCOL_BLACK )
        draw.SimpleTextOutlined( self:Clip1(), "TDSHudNormal", boxx + 5, boxy + 60, HUDCOL_PRIMARY, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, HUDCOL_BLACK )
    end
end

function SWEP:DrawWeaponSelection()

end