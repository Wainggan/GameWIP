function bP_functionRunner(_addFunc, _bullets) {
	if _addFunc != -1 {
		array_append(_bullets, script_execute(method_get_index(_addFunc)))
	}
}

function bP_aimPlayerDirect(_addFunc = -1) {
	if instance_exists(obj_player) {
		var allBullets = []
		
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, 0, obj_bullet);
		
		with inst {
			x_vel = lengthdir_x(4, dir)
			y_vel = lengthdir_y(4, dir)
			bP_functionRunner(_addFunc, allBullets)
		}
		
		array_push(allBullets, inst)
		return allBullets
	}
}

function bP_shootDownNormal(_addFunc = -1) {
	if instance_exists(obj_player) {
		var allBullets = []
		
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, 0, obj_bullet)
		
		var normDir = point_direction(0, 0, 0, 5)
		var newDir = normDir - angle_difference(normDir, dir) * 0.1
	
		with inst {
			x_vel = lengthdir_x(5, newDir)
			y_vel = lengthdir_y(5, newDir)
			bP_functionRunner(_addFunc, allBullets)
		}
		array_push(allBullets, inst)
		return allBullets
	}
}

function bP_shootDirection(_dir, _spd, _amount = 1, _addFunc = -1) {
	var newDir = _dir;
	var allBullets = []
	for (var i = 0; i < _amount; i++) {
		var inst = instance_create_depth(x, y, 0, obj_bullet)
		with inst {
			dir = newDir;
			spd = _spd;
			bP_functionRunner(_addFunc, allBullets)
		}
		array_push(allBullets, inst)
		newDir += 360/_amount
	}
	return allBullets
}

function bP_shootAround(_amount, _spd, _startAngle = 0, _addFunc = -1) {
	var allBullets = [];
	
	var changeAngle = _startAngle;
			
	repeat _amount {
		var inst = instance_create_depth(x, y, 0, obj_bullet);
		with inst {
			spd = _spd;
			dir = changeAngle
			bP_functionRunner(_addFunc, allBullets)
		}
		array_push(allBullets, inst);
		changeAngle += 360 / _amount;
	}
	return allBullets
}

function bp_placeBulletDown(_amount = 1, _noise = 0, _addFunc = -1) {
	var allBullets = [];
	
	repeat _amount {
		var inst = instance_create_depth(x + random_range(-_noise, _noise), y + random_range(-_noise, _noise), layer, obj_bullet);
		with inst bP_functionRunner(_addFunc, allBullets)
		array_push(allBullets, inst)
	}
	
	return allBullets
}

