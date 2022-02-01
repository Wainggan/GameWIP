hp = 580;
scoreGive = 90000

important = 1;

deathRadius = WIDTH

var bP_test = new Timeline()
bP_test.add(function() {
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x-320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))


		var bP_test = new Timeline();
		bP_test.add([bP_shootAround, [function(){return irandom_range(16, 30)}], 4, [function(){return random(100)}], function(){
				spd_target = 0.5
				spd_targetSpd = random_range(0.02, 0.04)
				
				sprite_index = spr_bullet_point
			}], 38)
		array_push(bulletPatterns, bP_test)
	}
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x+320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))

		var bP_test = new Timeline();
		bP_test.add([bP_shootAround, [function(){return irandom_range(16, 30)}], 4, [function(){return random(100)}], function(){
				spd_target = 0.5
				spd_targetSpd = random_range(0.02, 0.04)
				
				sprite_index = spr_bullet_point
			}], 38)
		array_push(bulletPatterns, bP_test)
	}
}, 110)
array_push(bulletPatterns, bP_test)

