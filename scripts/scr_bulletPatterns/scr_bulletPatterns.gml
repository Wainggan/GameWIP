function bP_aimPlayerDirect() {
	if instance_exists(obj_player) {
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, depth, obj_bullet);
		
		with inst {
			x_vel = lengthdir_x(4, dir)
			y_vel = lengthdir_y(4, dir)
		}
		
		return inst//array_push(bulletList, inst)
	}
}

function bp_shootDownNormal() {
	if instance_exists(obj_player) {
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, depth, obj_bullet)
		
		var normDir = point_direction(0, 0, 0, 5)
		var newDir = normDir - angle_difference(normDir, dir) * 0.1
	
		with inst {
			x_vel = lengthdir_x(5, newDir)
			y_vel = lengthdir_y(5, newDir)
		}
		return inst
	}
}