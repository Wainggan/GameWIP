angle_vel = 
	angle_target != undefined
		? approach(angle_vel, angle_target, angle_accel * global.delta_multi)
		: angle_vel + angle_accel * global.delta_multi;
angle += angle_vel;

event_inherited();

if life != undefined {
	if life < endTime mask_index = spr_nothing;
	if life < endTime mask_index = spr_nothing;
}

image_angle = angle;
image_xscale = 25
image_yscale = 1 - (fade < startTime ? fade/startTime : 1 - 1 / 16) - (life != undefined && life < endTime ? 1 - life / endTime : 0);

