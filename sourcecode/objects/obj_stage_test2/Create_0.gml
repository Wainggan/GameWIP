event_inherited();

pattern_add("test-1", function() {
	
	b_colors = [
		cb_red, cb_rust, cb_yellow, cb_lime, cb_green, cb_teal, cb_blue, cb_indigo, cb_pink,
		cb_black, cb_grey, cb_white
	];
	b_sprites = [
		spr_bullet_arrow, spr_bullet_normal, spr_bullet_point, spr_bullet_small, spr_bullet_spark,
		spr_bullet_inverted, spr_bullet_large, spr_bullet_largeinverted, spr_bullet_square,
		spr_bullet_star
	];

	command_set([
		30,
		6,
		function(){
			bullet_preset_ring(x, y, array_length(b_colors), 8, random(360), function(_x, _y, _dir, i) {
				with bullet_shoot_dir(_x, _y, 2, _dir) {
					glow = other.b_colors[i]
					sprite_index = array_shuffle(other.b_sprites)[0]
				}
			})
			commandIndex--;
		},
		function(){
			nextPattern()
		}
	]);
	
})

pattern_add("test-2", function() {
	
	command_set([
		30,
		20,
		function(){
			bullet_preset_ring(x, y, 30, 8, irandom(360), function(_x, _y, _dir) {
				bullet_shoot_dir2(_x, _y, 1, 0.3, 2, _dir);
			})
			
			command_repeat(4)
		},
		function(){
			nextPattern()
		}
	]);
	
})

pattern_add("test-3", function() {
	
	command_set([
		30,
		4,
		function(){
			bullet_preset_ring(x, y, 14, 8, wave(-720, 720, 9), function(_x, _y, _dir) {
				bullet_shoot_dir2(_x, _y, 1, 0.3, 3, _dir);
			})
			
			command_repeat(20)
		},
		function(){
			nextPattern()
		}
	]);
	
})

// dfdfdf

addEnemy("test", function() {
	setBoss()
	
	setPatterns([
		new Pattern("test-1"),
		new Pattern("test-2"),
		new Pattern("test-3"),
	])
		
	setPhases([
		new AttackPhase(6, [0, 1]),
		new AttackPhase(6, [2]),
		new AttackPhase(6, [2, 0], 1),
	])
	
	startPhase()
})


addSection(function() {
	enemy("test", WIDTH / 2, 120);
	randomize()
})

