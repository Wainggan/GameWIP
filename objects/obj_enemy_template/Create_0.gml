bulletList = [];

x_vel = 0;
y_vel = 0;

bP_aimPlayerDirect = function() {
	if instance_exists(obj_player) {
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		var inst = instance_create_depth(x, y, depth, obj_bullet);
		
		with inst {
			x_vel = lengthdir_x(2, dir)
			y_vel = lengthdir_y(2, dir)
		}
		
		array_push(bulletList, inst)
	}
}


defaultPattern = [
	[bP_aimPlayerDirect, 10],
	[bP_aimPlayerDirect, 10],
	[bP_aimPlayerDirect, 10],
	[bP_aimPlayerDirect, 10],
	[bP_aimPlayerDirect, 10],
	[bP_aimPlayerDirect, 60]
]


bulletPattern = defaultPattern;
bulletPatternTimeline = 0;
bulletPatternBuffer = 0;