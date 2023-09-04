sprite_index = sprite

var _s = sprite_get_info(sprite)

// TODO FIX
draw_sprite_part_ext(
	sprite, subsprite, 
	0, 0, 
	sprite_get_width(sprite), 
	_s.frames[0].original_height - (_s.frames[0].original_height - sprite_yoffset * anim), 
	WIDTH / 2 + (WIDTH / 2 - 96) * side - sprite_xoffset, 
	HEIGHT - 100 - sprite_yoffset + (y - bbox_top) * (1 - anim), 
	-side, 1, c_white, 1
);


