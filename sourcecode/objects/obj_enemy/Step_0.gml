//if !active exit

if step != undefined step();

command_update();
movement_update();

if onGround {
	y += render.backgroundSpeed * global.delta_multi;
}

if hp > maxhp {
	maxhp = hp
}

if hp <= 0 {
	if hpMod == undefined {
		global.score += scoreGive;
		
		var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
		inst.targetSize = deathRadius
		inst.sizeSpeed = 32;
		inst.bulletBonus = true;
		inst.destroyAll = destroyAll;
		
		instance_create_depth(x, y, depth+100, obj_effect_hitpop).sprite_index = sprite_index;
	
		repeat pointGive {
			var _spread = min(power(pointGive, 0.5), 3)
			with instance_create_layer(x, y, "Instances", obj_collectable) {
				sprite_index = spr_collectable_point;
				scoreGive = 1000;
				x_vel = random_range(-_spread, _spread);
				y_vel = random_range(-3, -1);
			}
		}
	
		var shockwave = render.shockwave_create(x, y)
		shockwave.mode = 1
		shockwave.scaleTarget = deathRadius * 4
		shockwave.scaleSpeed = 18
	}
	
	onDeath();
	if canDie instance_destroy();
	//func_destroyBullets()
}