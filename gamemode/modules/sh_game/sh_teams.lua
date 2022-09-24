hook.Add( "CreateTeams", "tds_ZombieEscapeTeams", function()
    team.SetUp( 2, "zombie", Color( 225, 100, 40 ), false )
    team.SetUp( 3, "human", Color( 0, 125, 255 ), false )
end)