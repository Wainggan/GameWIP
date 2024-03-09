
function bullet_behaviour_0() {
	
	var _dm = global.delta_multi
	
	if fade != 0 {
		fade = max(fade - _dm, 0);
		//if fade == 0 mask_index = sprite_index;
		//else mask_index = spr_nothing;
	}
	
	spd = spd_target != undefined ? approach(spd, spd_target, spd_accel * _dm) : spd + spd_accel * _dm;
	
	var _xv = x_vel + lengthdir_x(spd, dir)
	var _yv = y_vel + lengthdir_y(spd, dir)

	x += _xv * _dm;
	y += _yv * _dm;
	
	if showDirection image_angle = point_direction(0, 0, _xv, _yv)
	
}

function bullet_behaviour_1() {
	
	var _dm = global.delta_multi
	
	x_vel = x_target != undefined ? approach(x_vel, x_target, x_accel * _dm) : x_vel + x_accel * _dm;
	y_vel = y_target != undefined ? approach(y_vel, y_target, y_accel * _dm) : y_vel + y_accel * _dm;

	if fade != 0 {
		fade = max(fade - _dm, 0);
		//if fade == 0 mask_index = sprite_index;
		//else mask_index = spr_nothing;
	}

	spd = spd_target != undefined ? approach(spd, spd_target, spd_accel * _dm) : spd + spd_accel * _dm;

	var _xv = x_vel + lengthdir_x(spd, dir)
	var _yv = y_vel + lengthdir_y(spd, dir)

	x += _xv * _dm;
	y += _yv * _dm;

	if showDirection image_angle = point_direction(0, 0, _xv, _yv)

	if spd == spd_target && spd_target2 != undefined {
		spd_target = spd_target2;
		spd_accel = spd_accel2;
	}
	
}

function bullet_behaviour_2() {
	
	var _dm = global.delta_multi
	
	// level 2

	command_update();

	// level 1

	x_vel = x_target != undefined ? approach(x_vel, x_target, x_accel * _dm) : x_vel + x_accel * _dm;
	y_vel = y_target != undefined ? approach(y_vel, y_target, y_accel * _dm) : y_vel + y_accel * _dm;

	dir = dir_target != undefined ? dir + median(angle_difference(dir_target, dir), dir_accel * _dm, -dir_accel * _dm) : dir + dir_accel * _dm;

	// level 0

	if fade != 0 {
		fade = max(fade - _dm, 0);
		//if fade == 0 mask_index = sprite_index;
		//else mask_index = spr_nothing;
	}

	spd = spd_target != undefined ? approach(spd, spd_target, spd_accel * _dm) : spd + spd_accel * _dm;

	var _xv = x_vel + lengthdir_x(spd, dir)
	var _yv = y_vel + lengthdir_y(spd, dir)

	x += _xv * _dm;
	y += _yv * _dm;

	if showDirection image_angle = point_direction(0, 0, _xv, _yv)

	// level 1

	if spd == spd_target && spd_target2 != undefined {
		spd_target = spd_target2;
		spd_accel = spd_accel2;
	}

	// level 2

	if step != undefined step()

	if life != undefined {
		life -= _dm
		if life <= 0 { 
			instance_destroy(); 
		
			//if object_index != obj_laser particle.burst(x, y, "bulletExplosion", (x_vel + lengthdir_x(spd, dir)), (y_vel + lengthdir_y(spd, dir)))
		}
	}

}

