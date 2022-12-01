angle = 
	angle_target != undefined
		? angle + median(angle_difference(angle_target, angle), angle_accel * global.delta_multi, -angle_accel * global.delta_multi)
		: angle + angle_accel * global.delta_multi;

event_inherited();

mask_index = active ? spr_player_laser : spr_nothing;

image_angle = angle;
image_xscale = 25
image_yscale = 1;
