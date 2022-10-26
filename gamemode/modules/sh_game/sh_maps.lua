ZE.Maps = {}

function ZE:RegisterMap( map, data )
    if game.GetMap() != map then return end --doing this to keep the main table clean if we arent on the map.

    ZE.Maps = ZE.Maps or {}
    ZE.Maps[map] = data
end