//if !active exit

if step != undefined step();

command_update();
movement_update();

shakeAmount -= global.delta_multiNP

if onGround {
	y += render.backgroundSpeed * global.delta_multi;
}

if hp > maxhp {
	maxhp = hp
}


if timer != -1 || timerMod != undefined {
	timer += global.delta_multi;
	if timerMod != undefined {
		if timerMod[currentTimerMod] < timer {
			if currentTimerMod == currentHpMod hp = 0;
			currentTimerMod++;
		}
	} else {
		if timer > ftime {
			hp = 0;
			time()
		}
	}
}
if timerMinActive timerMin -= global.delta_multi

if hp <= 0 && shakeFix == undefined {
	if timerMod == undefined time()
	
	var _godWHYY = false
	if currentPhase != -1 {
		_godWHYY = nextPhase()
	}
	
	if !_godWHYY {
		var _checkHpMod = hpModArray == undefined || currentHpMod >= array_length(hpModArray)
		if _checkHpMod {
			global.score += scoreGive;
		
			repeat 20
				text_splash_random(x, y, round(scoreGive/20), 96, 20, 20)
		
			var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
			inst.targetSize = deathRadius
			inst.sizeSpeed = 32;
			inst.bulletBonus = true;
			inst.destroy = !destroyAll;
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
			shockwave.scaleTarget = deathRadius * 2
			shockwave.scaleSpeed = 24
		
			//game_pause(2)
			screenShake_set(2, 0.25);
		
		
		}
	
		onDeath();
		if canDie shakeFix = 1
	}
	
	//func_destroyBullets()
}
if shakeFix != undefined {
	particle_burst(x, y, ps_enemypop_1)

	shakeFix -= global.delta_multi
	if canDie && shakeFix < 0 instance_destroy();
}


importantAnim.update(global.delta_milli, x);