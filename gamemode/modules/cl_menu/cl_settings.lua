function ZESettings()
    ZESettings_frame = vgui.Create( "DFrame" )
    ZESettings_frame:SetSize( 600, 700 )
    ZESettings_frame:ShowCloseButton( true )
    ZESettings_frame:Center()
    ZESettings_frame:MakePopup()
    function ZESettings_frame:Paint( w, h )
        surface.SetDrawColor( HUDCOL_TERTIARY )
        surface.DrawRect( 0, 0, w, h )
    end
end