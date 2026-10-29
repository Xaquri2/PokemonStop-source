// Draw a floor-art region without allocating runtime sprites or surfaces.
draw_sprite_part_ext(tileRegion[0], 0, tileRegion[1], tileRegion[2],
    tileRegion[3], tileRegion[4], x, y, 32 / tileRegion[3], 32 / tileRegion[4],
    image_blend, image_alpha)
