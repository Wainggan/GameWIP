with obj_bullet_player {
	draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale, image_yscale, 0, merge_color(c_white, c_blue, 0.2), 0.4);
	
}
with obj_bullet {
	draw_sprite(sprite_index, 1, round(x), round(y));
	
}