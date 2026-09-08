if (!endBattle and instance_number(BattleMenuObject) == 0)
{
	instance_create_layer(x,y,"UIElements",BattleMenuObject)
}
instance_destroy(id)
