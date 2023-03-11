if distance_to_object(obj_player) < obj_player.collectDist latch = true;
latchTimer -= global.delta_multi
if latch && !latchTimer {
	var _dir = point_direction(x, y, obj_player.x, obj_player.y)
	x_vel += lengthdir_x(accel * global.delta_multi, _dir);
	y_vel += lengthdir_y(accel * global.delta_multi, _dir);
	var tX = abs(lengthdir_x(8, _dir));
	var tY = abs(lengthdir_y(8, _dir));
	x_vel = clamp(x_vel, -tX, tX);
	y_vel = clamp(y_vel, -tY, tY);
	
	accel = clamp(accel + 0.05 * global.delta_multi, 0, 0.6)

	image_angle = point_direction(0, 0, x_vel, y_vel) + 90;
	
	if place_meeting(x, y, obj_player) {
		global.score += scoreGive;
		if scoreGive > 0
			text_splash_random(x, y, scoreGive, 64, 6, 2)
		if func != undefined func();
		instance_destroy();
	}
	
} else {
	x_vel = approach(x_vel, 0, 0.02 * global.delta_multi)
	y_vel = min(y_vel + 0.04 * global.delta_multi, 3);
	image_angle = 0;
}
x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;
if y > HEIGHT + 64
		instance_destroy()