-- ███╗   ███╗ █████╗ ██████╗     ██████╗  █████╗ ████████╗ █████╗
-- ████╗ ████║██╔══██╗██╔══██╗    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
-- ██╔████╔██║███████║██████╔╝    ██║  ██║███████║   ██║   ███████║
-- ██║╚██╔╝██║██╔══██║██╔═══╝     ██║  ██║██╔══██║   ██║   ██╔══██║
-- ██║ ╚═╝ ██║██║  ██║██║         ██████╔╝██║  ██║   ██║   ██║  ██║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝         ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

ZE:RegisterMap( "ze_ffvii_mako_reactor_v5_3", {
    name = "Mako Reactor",
    stageCounter = "",
} )

-- ██████╗  ██████╗ ███████╗███████╗███████╗███████╗
-- ██╔══██╗██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝
-- ██████╔╝██║   ██║███████╗███████╗█████╗  ███████╗
-- ██╔══██╗██║   ██║╚════██║╚════██║██╔══╝  ╚════██║
-- ██████╔╝╚██████╔╝███████║███████║███████╗███████║
-- ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚══════╝╚══════╝

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Monstruo", --Boss name, will be displayed to players.
    ent = "monstruo", --Parent entity, or the object that the counter will be attached to. Sometimes both the ent and counter will be the same.
    counter = "monstruo_breakable", --Counter entity, or the entity that will be taking damage.
    healthOverride = 1250, --Base health
    healthPerPlayer = 400, --Health added for each player that is alive. This excludes the first player.
} )

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Bahamut",
    ent = "bahamut",
    counter = "bahamut_vida",
    healthOverride = 100,
    healthPerPlayer = 40,
} )

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Wall",
    ent = "tierra_b",
    counter = "tierra_b",
    healthOverride = 750,
    healthPerPlayer = 350,
} )

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Sephiroth",
    ent = "glassT",
    counter = "glassT",
    healthOverride = 5,
    healthPerPlayer = 1,
} )

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Bahamut",
    ent = "bahamutend",
    counter = "bahamutend",
    healthOverride = 400,
    healthPerPlayer = 100,
} )

ZE:AddBoss( "ze_ffvii_mako_reactor_v5_3", {
    name = "Sephiroth",
    ent = "bahamutend1",
    counter = "bahamutend1",
    healthOverride = 600,
    healthPerPlayer = 200,
} )