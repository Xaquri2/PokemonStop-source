if (scaleDown)
{
	image_xscale -= scaleDownValue
	image_yscale -= scaleDownValue
	
	if (image_xscale <= 0) instance_destroy(id)
}