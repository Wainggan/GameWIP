bP_test = function() {
	var inst = instance_create_depth(x, y, depth, obj_bulletPath);
	
	with inst {
		var movePath = [
			[256, 0, 1]
		]
		bulletPattern = movePath
		bPToShoot = bp_shootDownNormal;
		bPReload = 24;
		
		parent = other;
	}
	var inst = instance_create_depth(x, y, depth, obj_bulletPath);
	
	with inst {
		var movePath = [
			[-256, 0, 1]
		]
		bulletPattern = movePath
		bPToShoot = bp_shootDownNormal;
		bPReload = 24;
		
		parent = other;
	}
}

testPattern = [
	[bP_test, 120]
]

bulletPattern = testPattern