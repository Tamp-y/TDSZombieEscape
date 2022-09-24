function ZESettings()
    ZESettings = vgui.Create( "DFrame" )
    ZESettings:SetSize( 600, 700 )
    ZESettings:ShowCloseButton( true )
    ZESettings:Center()
    ZESettings:MakePopup()
    function ZESettings:Paint( w, h )
        surface.SetDrawColor( HUDCOL_PRIMARY )
        surface.DrawRect( 0, 0, w, h )
    end
end