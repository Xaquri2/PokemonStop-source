var player = instance_find(PlayerObject, 0)
if (HasFlag("MutantBadge"))
{
	var badge = instance_create_layer(player.x, player.y, "Important", BadgeObject)
	badge.badgeType = "MutantBadge"
	badge.target = id
}

if (HasFlag("ShadowBadge"))
{
	var badge = instance_create_layer(player.x, player.y, "Important", BadgeObject)
	badge.badgeType = "ShadowBadge"
	badge.target = id
}

if (HasFlag("RobotBadge"))
{
	var badge = instance_create_layer(player.x, player.y, "Important", BadgeObject)
	badge.badgeType = "RobotBadge"
	badge.target = id
}