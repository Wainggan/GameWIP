hp = 580;
scoreGive = 90000

important = 1;

deathRadius = WIDTH

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
			[[bP_shootAround, [function(){return irandom_range(16, 35)}], 0.5], 38]
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
			[[bP_shootAround, [function(){return irandom_range(16, 30)}], 0.5], 38]
		]
	}
}
mPattern_goAway = [[0,0,0]]
pattern_frame = [
	[bP_test, 110]
]

//bulletPattern = testPattern