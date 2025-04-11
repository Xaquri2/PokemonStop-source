if (!ds_list_empty(team))
{
	draw_text(x-128,y-32,GetHealth(ds_list_find_value(team, 1)))
}
draw_self()
//Delete this event after fixing the Squirtle bug
//Bug is that whenever the player deals the finishing blow
//on the Pikachu, the next Pokémon gets damaged as well for some
//reason.