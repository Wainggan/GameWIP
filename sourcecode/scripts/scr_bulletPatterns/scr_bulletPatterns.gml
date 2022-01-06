function bP_aimPlayerDirect(_addFunc = function(){}) {
	if instance_exists(obj_player) {
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, depth, obj_bullet);
		
		with inst {
			x_vel = lengthdir_x(4, dir)
			y_vel = lengthdir_y(4, dir)
			script_execute(method_get_index(_addFunc))
		}
		
		return inst//array_push(bulletList, inst)
	}
}

function bP_shootDownNormal(_addFunc = function(){}) {
	if instance_exists(obj_player) {
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, depth, obj_bullet)
		
		var normDir = point_direction(0, 0, 0, 5)
		var newDir = normDir - angle_difference(normDir, dir) * 0.1
	
		with inst {
			x_vel = lengthdir_x(5, newDir)
			y_vel = lengthdir_y(5, newDir)
			script_execute(method_get_index(_addFunc))
		}
		return inst
	}
}

function bP_shootDirection(_dir, _spd, _amount = 1, _addFunc = function(){}) {
	var newDir = _dir;
	var allBullets = []
	for (var i = 0; i < _amount; i++) {
		var inst = instance_create_layer(x, y, layer, obj_bullet)
		with inst {
			dir = newDir;
			spd = _spd;
			script_execute(method_get_index(_addFunc))
		}
		array_push(allBullets, inst)
		newDir += 360/_amount
	}
	return allBullets
}

function bP_shootAround(_amount, _spd, _startAngle = 0, _addFunc = function(){}) {
	var allBullets = [];
	
	var changeAngle = _startAngle;
			
	repeat _amount {
		var inst = instance_create_depth(x, y, layer, obj_bullet);
		with inst {
			spd = _spd;
			dir = changeAngle
			script_execute(method_get_index(_addFunc))
		}
		array_push(allBullets, inst);
		changeAngle += 360 / _amount;
	}
	return allBullets
}

function bp_placeBulletDown(_addFunc = function(){}) {
	var inst = instance_create_depth(x, y, layer, obj_bullet);
	with inst script_execute(method_get_index(_addFunc))
	return inst
}

