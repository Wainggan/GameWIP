hp = 350;
scoreGive = 60000

sprite_index = spr_comcat

deathRadius = WIDTH

important = 1;

bP_test = function() {
	
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern = [
			[-320, 32, 1.4],
			[0, 0, 1, function(){ instance_destroy() }]
		]
		bulletPattern = [
			[bp_placeBulletDown, 24]
		]
	}
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern = [
			[320, 32, 1.4],
			[0, 0, 1, function(){ instance_destroy() }]
		]
		bulletPattern = [
			[bp_placeBulletDown, 24]
		]
	}
}

pattern_frame = [
	[bP_test, 120],
	[function(){
		if (instance_exists(obj_player)) {
			for (var i = 0; i < array_length(bulletList); i++) {
				var inst = bulletList[i]
				var d = point_direction(inst.x, inst.y, obj_player.x, obj_player.y);
				
				inst.x_vel = lengthdir_x(3, d)
				inst.y_vel = lengthdir_y(3, d)
			}
		}
	}, 40]
]

mPattern_goAway = [[0,0,0]]

//bulletPattern = testPattern