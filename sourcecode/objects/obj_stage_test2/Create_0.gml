event_inherited();

pattern_add("test-1", function() {

	command_set([
		30,
		10,
		function(){
			bullet_shoot_dir2(x, y, 1, 0.3, 2, point_direction(x, y, obj_player.x, obj_player.y));
			command_repeat(20)
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

addEnemy("test", function() {
	setPatterns([
		new Pattern("test-1"),
		new Pattern("test-2"),
		new Pattern("test-3"),
	])
		
	setPhases([
		new AttackPhase(6, [0, 1]),
		new AttackPhase(6, [2]),
	])
	
	startPhase()
})


addSection(function() {
	enemy("test", WIDTH / 2, 120);
	randomize()
})

