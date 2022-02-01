hp = 700;
scoreGive = 120000

deathRadius = WIDTH

important = 1;

instvar_direction = 0;
var bP_test = new Timeline()
	.add([bP_shootDirection,
		[function(){return instvar_direction}],
		1, 3, function() {
			sprite_index = spr_bullet_point
			y_accel = 0.002
			dir_vel = -1
			step = function(){
				if y_vel < 0.68 
					dir += wave(-2.5, 2.5, 1) * global.delta_multi
				else {
					dir_vel = 0.3
					y_accel = 0.001
				}
			}
		}
	], 0)
	.add([bP_shootDirection,
		[function(){return instvar_direction}],
		1, 3, function() {
			sprite_index = spr_bullet_point
			y_accel = 0.002
			dir_vel = 1
			step = function(){
				if y_vel < 0.68 
					dir += wave(-2.5, 2.5, 1) * global.delta_multi
				else {
					dir_vel = -0.3
					y_accel = 0.001
				}
			}
		}
	], 0)
	.add(function(){ instvar_direction += 8.6 * global.delta_multi }, 12)
array_push(bulletPatterns, bP_test)

instvar_circDir = 0
instvar_d = 1
var bP_test = new Timeline([bP_shootAround, 64, 2, [function(){return instvar_circDir}], function(){
	dir_vel = other.instvar_d * 0.25;
}], 240)
	.add(function(){instvar_d *= -1; instvar_circDir += 180 / 40; }, 0)
array_push(bulletPatterns, bP_test)
