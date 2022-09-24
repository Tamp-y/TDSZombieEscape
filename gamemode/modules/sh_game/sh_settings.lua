Settings = {}
SET = Settings

--Timer/Round
SET["MapLength"] = 1800 --Time left on a map before map changes (seconds)
SET["RoundLength"] = 1200 --Time left on a round before humans force lose (seconds)
SET["WarmupLength"] = 30 --Time given to players to warmup/load in (seconds)
SET["EndRoundLength"] = 5 --Time after round ends for players.
SET["ExtendVoteBegin"] = 180 --Time left on map length before vote extend begins (seconds)
SET["ExtendLength"] = 1200 --How long a map should be extended for if vote successful (seconds)
SET["SelectionLength"] = 15 --Time until mother zombie selection (seconds)
--Selection
SET["NoSelection"] = true --Disable selection, usually meant for if you are offlining.
SET["SelectionPercent"] = 15 --0-100%, how many humans should start as mother zombie
--Movement
SET["MovementSpeed"] = 250
SET["JumpHeight"] = 300
SET["FallDamage"] = false
--Zombie
SET["ZHealth"] = 10000
--Triggers
SET["TriggerDamageMult"] = 2