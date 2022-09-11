with obj_bullet {
	if object_index == obj_bullet
		draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime + pop * 0.1, image_yscale + fade/fadeTime + pop * 0.1, image_angle, c_white, image_alpha-fade/fadeTime);
	else {
		draw_sprite_ext(spr_laser_head, 0, round(x), round(y), 1, image_yscale, image_angle, c_white, image_alpha);
		draw_sprite_ext(spr_laser, 0, round(x + lengthdir_x(30, image_angle)), round(y + lengthdir_y(30, image_angle)), image_xscale, image_yscale, image_angle, c_white, image_alpha);
	}
		
}

with obj_player draw_sprite_ext(sprite_index, 5, round(x), round(y), hitboxSize, hitboxSize, 0, c_white, 1)