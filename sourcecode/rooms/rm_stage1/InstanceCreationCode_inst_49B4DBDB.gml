hp = 700;
scoreGive = 120000

deathRadius = WIDTH

important = 1;

bP_test = function() {

}

instvar_direction = 0;
pattern_frame = [
	[[bP_shootDirection,
		[function(){return instvar_direction}],
		1, 5, function() {
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
	], 8],
	[function(){ instvar_direction += 8.6 * global.delta_multi }, 1]
]

mPattern_goAway = [[0,0,0]]

//bulletPattern = testPattern