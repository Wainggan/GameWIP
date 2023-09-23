//if !active exit

lastX = x;

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
time_total += global.delta_multi

phaseTimer += global.delta_milliP
if phaseStartTimer >= 0 {
	phaseStartTimer -= global.delta_milliP
	if phaseStartTimer < 0 {
		phaseStartTimer = -1;
		startPattern()
	}
} else {
	time_phase += global.delta_multi
}


if hp <= 0 && shakeFix == undefined { // todo: complete rewrite
	if timerMod == undefined time()
	
	var _godWHYY = false
	if currentPhase != -1 {
		_godWHYY = nextPhase()
		
		screenShake_set(4, 0.3)
		game_pause(4)
		
		var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
		inst.targetSize = deathRadius
		inst.sizeSpeed = 32;
		inst.bulletBonus = true;
		inst.destroy = false;
		inst.destroyAll = true;
		
		sound.play(snd_bossphase)
	}
	
	if !_godWHYY {
		var _checkHpMod = hpModArray == undefined || currentHpMod >= array_length(hpModArray)
		if _checkHpMod {
			global.score += scoreGive;
		
			repeat 20
				text_splash_random(x, y, round(scoreGive/20), 96, 20, 20)
			
			if !bossFlag {
				var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
				inst.targetSize = deathRadius
				inst.sizeSpeed = 32;
				inst.bulletBonus = true;
				inst.destroy = true;
				inst.destroyAll = false;
			}
		
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
			if bossFlag {
				screenShake_set(5, 0.2);
				//instance_create_layer(0, 0, "Instances", obj_koSplash);
				
				game_pause(26)
				shakeAmount = 26
				
				instance_create_layer(x, y, layer, obj_effect_hit)

				
			} else {
				screenShake_set(2, 0.25);
				sound.play(snd_enemydeath)
			}
		
		}
	
		onDeath();
		if canDie {
			shakeFix = 1
			particle_burst(x, y, ps_enemypop_1)
		}
	}
	
	//func_destroyBullets()
}
if shakeFix != undefined {
	

	shakeFix -= global.delta_multi
	if canDie && shakeFix < 0 instance_destroy();
}


importantAnim.update(global.delta_milli, x);