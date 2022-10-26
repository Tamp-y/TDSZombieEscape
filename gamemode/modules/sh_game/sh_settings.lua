Settings = {}
SET = Settings

SET["Developer"] = 1 --Enable/Disable Developing Mode, this turns off most game features.

--Timer/Round
SET["MapLength"] = 1800 --Time left on a map before map changes (seconds)
SET["RoundLength"] = 1200 --Time left on a round before humans force lose (seconds)
SET["WarmupLength"] = 20 --Time given to players to warmup/load in (seconds)
SET["EndRoundLength"] = 5 --Time after round ends for players.
SET["ExtendVoteBegin"] = 180 --Time left on map length before vote extend begins (seconds)
SET["ExtendLength"] = 1200 --How long a map should be extended for if vote successful (seconds)
--Selection
SET["SelectionLength"] = 20 --Time until mother zombie selection (seconds)
SET["NoSelection"] = 0 --Disable selection, usually meant for if you are offlining.
SET["SelectionPercent"] = 20 --0-100%, how many humans should start as mother zombie
--Movement
SET["MovementSpeed"] = 250
SET["JumpHeight"] = 300
SET["FallDamage"] = false
--Zombie
SET["ZHealth"] = 10000
--Triggers
SET["TriggerDamageMult"] = 2
--Teams
SET["HWeapons"] = { --Default weapons to spawn with (TDSFramework will override this)
    "weapon_m4a1",
    "weapon_usp",
    "weapon_knife",
    "weapon_he",
}
SET["ZWeapons"] = { --Default weapons to spawn with
    "weapon_knife_z",
}