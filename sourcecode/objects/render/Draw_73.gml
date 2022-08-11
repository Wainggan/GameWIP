with obj_bullet {
	draw_sprite_ext(sprite_index, 0, round(x), round(y), image_xscale + fade/fadeTime, image_yscale + fade/fadeTime, image_angle, merge_color(c_white, c_blue, (highlight ? 0.01 : 0)), image_alpha-fade/fadeTime);
}

with obj_laser {
	for (var i = 0; i < array_length(positions) - 1; i++)
		draw_line(positions[i][0], positions[i][1], positions[i+1][0], positions[i+1][1]);
}

with obj_player draw_sprite_ext(sprite_index, 5, round(x), round(y), hitboxSize, hitboxSize, 0, c_white, 1)