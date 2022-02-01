
with obj_bullet {
	draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale, image_yscale, image_angle, merge_color(c_white, c_blue, (highlight ? 0.01 : 0)), image_alpha);
}

with obj_player draw_sprite_ext(sprite_index, 1, round(x), round(y), hitboxSize, hitboxSize, 0, c_white, 1)