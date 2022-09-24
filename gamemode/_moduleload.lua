REALM_SH = 0
REALM_SV = 1
REALM_CL = 2

local Path = "zombieescape/"

local function FetchRealm( path )
    local sub = string.lower( string.sub( path, 0, 3 ) )
    local realm = (sub == "cl_" and REALM_CL) or (sub == "sv_" and REALM_SV) or REALM_SH
    return realm
end

local function InitializeFiles( path, realm, nonotice )
    realm = realm or FetchRealm( path )
    local files, folders = file.Find( path .. "/*", "LUA" )
    files = files or {}
    folders = folders or {}

    for _, v in pairs( files ) do
        local fileRealm = realm and realm != REALM_SH and realm or FetchRealm( v )
        if string.sub( v, -4, -1 ) == ".txt" then continue end --Ignore text files, sometimes I have them for helping purposes.

        if fileRealm != REALM_SV then
            AddCSLuaFile( path .. "/" .. v )
            if ( CLIENT ) then
                include( path .. "/" .. v )
            end
        end
        if ( SERVER ) and fileRealm != REALM_CL then
            include( path .. "/" .. v )
        end
    end

    for _, v in pairs( folders ) do
        local folderRealm = FetchRealm( v )
        InitializeFiles( path .. "/" .. v, folderRealm )

        if not nonotice then
            print( "Module: " .. v )
        end
    end
end

InitializeFiles( Path .. "gamemode/modules" )