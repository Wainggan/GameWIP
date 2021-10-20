hp = 120;
scoreGive = 50000

bP_test = function() {
	var bP_food = function(){
		var inst = instance_create_depth(x, y, depth, obj_bullet)
	
		with inst {
			x_vel = 0
			y_vel = 2
		}
		return inst
	}
	
	
	
	var inst = instance_create_depth(x, y, depth, obj_bulletPath);
	with inst {
		var movePath = [
			[256, 64, 1]
		]
		bulletPattern = movePath
		bPToShoot = function(){
			var allBullets = [];
			
			var amount = 8;
			var changeAngle = 0;
			
			repeat amount {
				var inst = instance_create_depth(x, y, depth, obj_bullet);
				with inst {
					x_vel = lengthdir_x(3, changeAngle);
					y_vel = lengthdir_y(3, changeAngle);
				}
				array_push(allBullets, inst);
				changeAngle += 360 / amount;
			}
			return allBullets[0]
	
			
		};
		
		bPReload = 24;
		
		parent = other;
	}
	
	var inst = instance_create_depth(x, y, depth, obj_bulletPath);
	with inst {
		var movePath = [
			[-256, 64, 1]
		]
		bulletPattern = movePath
		bPToShoot = function(){
			var allBullets = [];
			
			var amount = 8;
			var changeAngle = 0;
			
			repeat amount {
				var inst = instance_create_depth(x, y, depth, obj_bullet);
				with inst {
					x_vel = lengthdir_x(3, changeAngle);
					y_vel = lengthdir_y(3, changeAngle);
				}
				array_push(allBullets, inst);
				changeAngle += 360 / amount;
			}
			return allBullets[0]
	
			
		};;
		bPReload = 24;
		
		parent = other;
	}
}

pattern_frame = [
	[bP_test, 120]
]

//bulletPattern = testPattern