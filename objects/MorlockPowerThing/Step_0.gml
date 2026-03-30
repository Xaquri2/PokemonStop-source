var MorlockNumber = instance_number(Morlock)
var MorPos_x = random_range(180,800) //*MorlockNumber
var MorPos_y = random_range(30,720) //*MorlockNumber

if (instance_number(Morlock) < 12)
{
    var m = instance_create_layer(MorPos_x, MorPos_y, "Instances", Morlock);

	m.name = Morlock;
	m.enemyName = "Morlock";
	m.trainerTeam = ds_list_create();
	    AddPokemonTrainer(
        m.trainerTeam,
        1,
        "Morlock",
        floor(random_range(8,15)),
        GetRandomGender(50),
        MorlockBattleSprite
    );
}

