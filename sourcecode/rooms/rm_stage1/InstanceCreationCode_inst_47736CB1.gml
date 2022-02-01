hp = 580;
scoreGive = 90000

important = 1;

deathRadius = WIDTH

bP_test = function() {
	
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x-320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))
		var _bPattern = new Timeline()
		_bPattern.add([bP_shootAround, [function(){return irandom_range(1, 2)}], 3, [function(){return random(100)}], function(){
				spd_target = 0
				spd_targetSpd = 0.03
				
				sprite_index = spr_bullet_large
				
				life = 110
				death = function() {
					var inst = bp_placeBulletDown(4, 24, function(){
						x_vel = random_range(-0.2, 0.2)
						y_accel = 0.01
						y_vel = random_range(-0.5, -1)
						
						step = function() {
							if y_vel >= 1 y_accel = 0
						}
					})
				}
			}], 30)
		array_push(bulletPatterns, _bPattern)
	}
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	with _inst {
		invinsible = true;
		parent = other;
		movePattern.add(new Tween(1.4, [x, y], [x+320, y+32], TWEEN_XY, "linear", function(){instance_destroy()}))
		var _bPattern = new Timeline()
		_bPattern.add([bP_shootAround, [function(){return irandom_range(1, 2)}], 3, [function(){return random(100)}], function(){
				spd_target = 0
				spd_targetSpd = 0.03
				
				sprite_index = spr_bullet_large
				
				life = 110
				death = function() {
					var inst = bp_placeBulletDown(4, 24, function(){
						x_vel = random_range(-0.2, 0.2)
						y_accel = 0.01
						y_vel = random_range(-0.5, -1)
						
						step = function() {
							if y_vel >= 1 y_accel = 0
						}
					})
				}
			}], 30)
		array_push(bulletPatterns, _bPattern)
	}
}


var _bPattern = new Timeline()
_bPattern.add(bP_test, 110)
array_push(bulletPatterns, _bPattern)

_bPattern = new Timeline()
_bPattern.add([bP_shootAround, 89, 1.7, [function(){return random(200)}]], 120)
array_push(bulletPatterns, _bPattern)

//bulletPattern = testPattern