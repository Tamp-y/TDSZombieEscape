CVarList = CVarList or {}

TDS_ClientConVar = TDS_ClientConVar or function( name, value, save, min, max, info )
    CVarList[ name ] = value
    local cvar = CreateClientConVar( name, value, save, nil, info, min, max )
    return cvar
end

include( "shared.lua" )