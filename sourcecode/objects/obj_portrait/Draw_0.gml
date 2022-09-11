draw_sprite_part_ext(
	sprite, subsprite, 
	0, 0, 
	sprite_get_width(sprite), sprite_get_height(sprite) * anim, 
	WIDTH / 2 + (WIDTH / 2 - 96) * side, HEIGHT - 100 - anim * sprite_get_height(sprite), 
	-side, 1, c_white, 1
);