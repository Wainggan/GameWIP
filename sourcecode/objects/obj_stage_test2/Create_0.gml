event_inherited();

pattern_add("test-1", function() {
	
	command_set([
		30,
		10,
		function(){
			bullet_shoot_dir2(x, y, 1, 0.3, 2, point_direction(x, y, obj_player.x, obj_player.y));
			commandIndex--;
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
})


addSection(function() {
	enemy("test", WIDTH / 2, 120);
	randomize()
})

