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
	var inst = instance_create_depth(x, y, depth, obj_bullet)
	
	with inst {
		x_vel = 0
		y_vel = 5
	}
	return inst
}