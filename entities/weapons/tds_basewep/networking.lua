-- ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗ ██████╗
-- ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██║████╗  ██║██╔════╝
-- ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ██║██╔██╗ ██║██║  ███╗
-- ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ██║██║╚██╗██║██║   ██║
-- ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝

function SWEP:ResyncSilencedState()
    if ( SERVER ) then
        net.Start( "basewep_sync_silenced" )
            net.WriteEntity( self )
            net.WriteBool( self:GetSilenced() )
        net.Broadcast()
    elseif ( CLIENT ) then
        net.Start( "basewep_syncreq_silenced" )
            net.WriteEntity( self )
        net.SendToServer()
    end
end

if ( SERVER ) then

    util.AddNetworkString( "basewep_sync_silenced" )
    util.AddNetworkString( "basewep_syncreq_silenced" )

    net.Receive( "basewep_sync_silenced_request", function( _, ply ) 
        local ent = net.ReadEntity()
        if not IsValid( ent ) then return end

        net.Start( "basewep_sync_silenced" )
            net.WriteEntity( self )
            net.WriteBool( self:GetSilenced() )
        net.Send( ply )
    end)

elseif ( CLIENT ) then

    net.Receive( "basewep_sync_silenced", function()
        local ent = net.ReadEntity()
        local state = net.ReadBool()

        if not IsValid( ent ) then return end

        ent:SetSilenced( state )
    end)

end