hp = 120;
scoreGive = 50000

important = 1;

bP_test = function() {
	
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	_inst.invinsible = true;
	with _inst {
		movePattern = [
			[-320, 32, 1.4],
			[0, 0, 1, function(){ instance_destroy() }]
		]
		bulletPattern = [
			[[bP_shootAround, 15], 32]
		]
	}
	var _inst = instance_create_layer(x, y, layer, obj_enemy);
	_inst.invinsible = true;
	with _inst {
		movePattern = [
			[320, 32, 1.4],
			[0, 0, 1, function(){ instance_destroy() }]
		]
		bulletPattern = [
			[[bP_shootAround, 15], 32]
		]
	}
}

pattern_frame = [
	[bP_test, 120]
]

//bulletPattern = testPattern