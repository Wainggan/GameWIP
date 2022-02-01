hp = 480;
scoreGive = 60000

sprite_index = spr_comcat

deathRadius = WIDTH

important = 1;

var bP_test = new Timeline();
bP_test.add(function() {
	
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x-320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))

		var bP_test = new Timeline();
		bP_test.add([bp_placeBulletDown, 2, 3], 8)
		array_push(bulletPatterns, bP_test)
	}
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x+320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))

		var bP_test = new Timeline();
		bP_test.add([bp_placeBulletDown, 2, 3], 8)
		array_push(bulletPatterns, bP_test)
	}
}, 120)
array_push(bulletPatterns, bP_test)
var bP_test = new Timeline(function(){
		if (instance_exists(obj_player)) {
			for (var i = 0; i < array_length(bulletList); i++) {
				var inst = bulletList[i]
				var d = point_direction(inst.x, inst.y, obj_player.x, obj_player.y);
				
				inst.x_vel = lengthdir_x(2.5, d)
				inst.y_vel = lengthdir_y(2.5, d)
			}
		}
	}, 120)
array_push(bulletPatterns, bP_test)


