if instance_number(obj_player) > 1 {
	instance_destroy();
	exit;
}

moveSpeed = 5;
fastMoveSpeed = 5;
slowMoveSpeed = 2;

x_vel = 0;
y_vel = 0

accel = 2.5;
slowAccel = 1;


isShooting = false;


collectDist = 64;
collectPoint = 0;
collectAllBullets = false;


grazeRadius = 38;

grazeCombo = 0;
tGrazeComboTimer = 60 * 10;
grazeComboTimer = 0;

grazeComboQueue = 0;
grazeComboQueueTimer = 0;
tGrazeComboQueueTimer = 2;
grazeComboQueueLastX = 0;
grazeComboQueueLastY = 0;

grazeBulletList = {};
grazeBulletListClearTime = 60 * 4;
grazeBulletListClearTimeLaser = 8;

grazeReflectChance = 0;

grazeHitboxGraphicShow = 0;
grazeHitboxGraphicShowSpeed = 0.05;


bulletCharge = 0;
bulletChargeSpeed = 0.1;
bulletChargeSpeedSlow = 0.005;
bulletChargeTarget = 1.6;

grazeComboBulletMult = 1
grazeComboBulletExp = 0.15


tReloadTime = 7;
reloadTime = tReloadTime;

#region bullet upgrade defines
bulletAmount = 3;
bulletSpread = 6;
bulletSpreadAngle = 14;
bulletSpreadSlow = 6
bulletSpreadAngleSlow = 1
bulletSpeed = 14;
bulletDamage = 1;

tReloadHomingTime = 12;
reloadHomingTime = tReloadHomingTime;

bulletHomingAmount = 0;
bulletHomingSpreadAngle = 90;
bulletHomingSpreadAngleSlow = 45;
bulletHomingSpeed = 8;
bulletHomingDamage = 0.2;

bulletLaserList = [];
bulletLaserSpreadAngle = 24
bulletLaserSpreadAngleSlow = -18
bulletLaserSpread = 16
bulletLaserSpreadSlow = 32
bulletLaserDamage = 0.02;

func_addLaser = function(){
	bulletHomingDamage *= array_length(bulletLaserList) / ((array_length(bulletLaserList) * 2 + 1) / 2);
	with instance_create_layer(x, y, "Instances", obj_laser_player) {
		xOff = 0;
		yOff = 0;
		angle = 90;
		angle_target = 90;
		angle_accel = 5;
		damage = other.bulletLaserDamage;
		array_push(other.bulletLaserList, self);
	}
	bulletLaserSpread *= 0.9;
	bulletLaserSpreadSlow *= 0.9;
	bulletLaserSpreadAngle *= 1.05;
	bulletLaserSpreadAngleSlow *= 0.98;
	/*
	bulletLaserSpread *= 0.9;
	bulletLaserSpreadSlow *= 0.96;
	bulletLaserSpreadAngle *= 1.05;
	bulletLaserSpreadAngleSlow *= 1.2;
	*/
}

tReloadRoundTime = 4;
reloadRoundTime = tReloadRoundTime;

bulletRoundAmount = 0;
bulletRoundSpeed = 12;
bulletRoundDamage = 0.2;

tReloadWavyTime = 36;
reloadWavyTime = tReloadWavyTime;

bulletWavyAmount = 0;
bulletWavySplashAmount = 16;
bulletWavySpread = 8;
bulletWavySpreadAngle = 38;
bulletWavySpreadSlow = 2
bulletWavySpreadAngleSlow = 16
bulletWavySpeed = 5;
bulletWavySplashSpeed = 8;
bulletWavyDamage = 4;
bulletWavySplashDamage = 0.04;

bulletHelperList = [];
bulletHelperDamage = 0.5;
bulletHelperReload = 6;

func_addHelper = function(){
	if array_length(bulletHelperList) > 0 bulletHelperDamage *= array_length(bulletHelperList) / ((array_length(bulletHelperList) * 2 + 0.75) / 2);
	with instance_create_layer(x, y, "Instances", obj_helper) {
		array_push(other.bulletHelperList, self);
	}
	bulletHelperReload++;
}

bulletEvilList = [];
bulletEvilDamage = 0.4;
bulletEvilReload = 8;

func_addEvil = function(){
	if array_length(bulletEvilList) > 0 bulletEvilDamage *= array_length(bulletEvilList) / ((array_length(bulletEvilList) * 2 + 0.75) / 2);
	with instance_create_layer(x, y, "Instances", obj_helperButEvil) {
		array_push(other.bulletEvilList, self);
	}
	bulletEvilReload++;
}

ignore {
	bulletSpread = 6;
	bulletSpreadAngle = 32
	bulletSpreadSlow = 2
	bulletSpreadAngleSlow = 1
	bulletAmount = 32;
	bulletSpeed = 14;
}

#endregion

livesLeft = 3;
bombsLeft = 3;

lifeCharge = 0.0;
lifeChargeSpeed = 0.0000;
lifeChargeGraze = 0.0000;
lifeChargeGraphicX = x;
lifeChargeGraphicY = y;

hook_x = 0;
hook_icon_xAnim = new Sod(4, 1, 0);
hook_icon_showAnim = new Sod(2, 1, 0);
hook_icon_rotate = 0;
hook_ind_xAnim = new Sod(4, 0.7, 0);
hook_ind_yAnim = new Sod(4, 0.7, 0);
hook_ind_showAnim = new Sod(4, 1, 0);
hook_line_showAnim = new Sod(5, 1, 0);
hook_y = 0;
hook_ing = false;
hook_target = noone;
hook_maybeTarget = false;
hook_buffer = 0;
hook_charge = 0;


#region input
horzMovementPriority = [];
vertMovementPriority = [];

func_inputUpdate = function(kleft = 0, kright = 0, kup = 0, kdown = 0) {
	// horz
	// left = -1, right = 1;
	// up = -1, down = 1;
	var upCheck, downCheck, leftCheck, rightCheck;
	upCheck = 0;
	downCheck = 0;
	leftCheck = 0;
	rightCheck = 0;
	for (var i = 0; i < array_length(horzMovementPriority); i++) {
		
		if horzMovementPriority[i] == -1 {
			leftCheck = 1
		}
		if horzMovementPriority[i] == 1 {
			rightCheck = 1
		}
	}
	for (var i = 0; i < array_length(vertMovementPriority); i++) {
		if vertMovementPriority[i] == -1 {
			upCheck = 1
		}
		if vertMovementPriority[i] == 1 {
			downCheck = 1
		}
	}
	
	if kleft && leftCheck == 0  {
		array_insert(horzMovementPriority, 0, -1)
	}
	if kright && rightCheck == 0  {
		array_insert(horzMovementPriority, 0, 1)
	}
	
	if kup && upCheck == 0 {
		array_insert(vertMovementPriority, 0, -1)
	}
	if kdown && downCheck == 0  {
		array_insert(vertMovementPriority, 0, 1)
	}
	
	for (var i = 0; i < array_length(horzMovementPriority); i++) {

		if !kleft && leftCheck == 1 && horzMovementPriority[i] == -1 {
			array_delete(horzMovementPriority, i, 1)
		}
		if !kright && rightCheck == 1 && horzMovementPriority[i] == 1 {
			array_delete(horzMovementPriority, i, 1)
		}
	}
	for (var i = 0; i < array_length(vertMovementPriority); i++) {

		if !kup && upCheck == 1 && vertMovementPriority[i] == -1 {
			array_delete(vertMovementPriority, i, 1)
		}
		if !kdown && downCheck == 1 && vertMovementPriority[i] == 1 {
			array_delete(vertMovementPriority, i, 1)
		}
	}
}


#endregion

func_grazeFlavorText = function(_text, _x = x, _y = y) {
	var _dist = point_distance(x, y, _x, _y);
	
	var _nX = ((_x - x) / _dist) * 32;
	var _nY = ((_y - y) / _dist) * 32;
	
	_x = clamp(x + _nX, 16, WIDTH - 16);
	_y = clamp(y + _nY, 16, HEIGHT - 16);
	
	var _inst = instance_create_depth(_x, _y, depth, obj_flavorText)
	with _inst {
		_inst.accel_y = 0.1;
		_inst.x_vel = sign(_nX) * 0.4;
		_inst.y_vel = -1.3;
			
		_inst.life = 15;
			
		_inst.text = string(_text)
	}
}

#region states

state = new State("idle");
state.add("idle", {
	step : function(){
		var hkey = 0;
		var vkey = 0;

		if array_length(horzMovementPriority) > 0 {
			hkey = horzMovementPriority[0]
		}
		if array_length(vertMovementPriority) > 0 {
			vkey = vertMovementPriority[0]
		}

		//var _spd = inputSystem.check("sneak") ? slowMoveSpeed : moveSpeed;
		//var keydir = point_direction(0,0,hkey,vkey)
		//if hkey == 0 && vkey == 0 {
		//	_spd = 0
		//}
		
		var directionFix = (hkey != 0 && vkey != 0 ? 0.71 : 1)
    
	    var targetTopSpeed = (input.check("sneak") ? slowMoveSpeed : (input.check("shoot") ? moveSpeed : fastMoveSpeed))
	    var targetAccel = (input.check("sneak") ? slowAccel : accel)
    
	    //x_vel = approach(x_vel, (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix), 1 * global.delta_multi);
	    //y_vel = approach(y_vel, (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix), 1 * global.delta_multi);
		
		x_vel = (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix);
	    y_vel = (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix);
		
		var _lastX = x;
		
		if hook_ing {
			var _dir = point_direction(x, y, hook_x, hook_y);
			x += lengthdir_x(14 * global.delta_multi, _dir);
			y += lengthdir_y(14 * global.delta_multi, _dir);
			if point_distance(x, y, hook_x, hook_y) < 64 {
				hook_ing = false;
				hook_target = noone
			}
			if hook_x < 0 || hook_x > WIDTH || hook_y < 0 || hook_y > HEIGHT {
				hook_ing = false;
				hook_target = noone
			}
		} else {
			x += x_vel * global.delta_multi;
			y += y_vel * global.delta_multi;
		}

		x = clamp(x, 4, WIDTH-4);
		y = clamp(y, 4, HEIGHT-4);
		
		with obj_collectable {
			if	other.y < other.collectPoint || 
				(sprite_index == spr_collectable_bulletBonus && other.collectAllBullets) 
				latch = true;
		}

		#region Bullet Collision
		var _grazedBulletsList = ds_list_create()
		collision_circle_list(x, y, grazeRadius - (hook_ing ? 16 : 0), obj_bullet, 0, 1, _grazedBulletsList, true)
		if ds_list_size(_grazedBulletsList) > 0 {
			if iFrames <= 0 && !hook_ing && place_meeting(x, y, obj_bullet) {
				if lifeCharge < 1 {
					lifeCharge = min(lifeCharge + 0.5, 1);
					
					game_pause(16, true);
					screenShake_set(4);
					iFrames = 40;
					
					var test = instance_create_layer(x, y, layer, obj_bulletDestroyer)
					test.targetSize = WIDTH * 2;
					test.sizeSpeed = 40;
				
					var test = render.shockwave_create(x, y)
					test.mode = 1
					test.scaleTarget = WIDTH * 4
					test.scaleSpeed = 32
					
					particle.burst(x, y, "playerDeath")
	
					livesLeft--
					
					hook_target = noone;
					hook_ing = false;
					
					grazeComboQueue = 0;
					grazeCombo = 0;
					func_grazeFlavorText("0")
			
					state.change("respawn")
				} else {
					lifeCharge = 0;
					
					game_pause(6, false);
					screenShake_set(4);
					iFrames = 20;
					
					var test = instance_create_layer(x, y, layer, obj_bulletDestroyer)
					test.targetSize = 120;
					test.sizeSpeed = 40;
				
					var test = render.shockwave_create(x, y)
					test.mode = 1
					test.scaleTarget = 256
					test.scaleSpeed = 32
					
					//particle.burst(x, y, "playerDeath")
	
					//livesLeft--
					
					grazeComboQueue = 0;
					grazeCombo = 0;
					func_grazeFlavorText("0")
			
					//state.change("respawn")
				}
			} else {
				var _grazeTotal = 0;
				for (var i = 0; i < ds_list_size(_grazedBulletsList); i++) {
					var _b = _grazedBulletsList[| i]
					if grazeBulletList[$ _b] == undefined {
						grazeBulletList[$ _b] = _b.object_index == obj_bullet ? grazeBulletListClearTime : grazeBulletListClearTimeLaser ;
						_b.pop = 1;
						if grazeReflectChance > 0 && random(1) < grazeReflectChance {
							var _vdX = lengthdir_x(_b.spd, _b.dir) + _b.x_vel + _b.autoX;
							var _vdY = lengthdir_y(_b.spd, _b.dir) + _b.y_vel + _b.autoY;
							
							var _dirCheck = point_direction(_b.x, _b.y, x, y);
							
							if angle_difference(_dirCheck, point_direction(0, 0, _vdX, _vdY)) < 80 {
								var _dist = point_distance(x, y, _b.x, _b.y);
								var _vnX = (_b.x - x) / _dist;
								var _vnY = (_b.y - y) / _dist;
							
								var _vrX = _vdX - 2 * dot_product(_vdX, _vdY, _vnX, _vnY) * _vnX;
								var _vrY = _vdY - 2 * dot_product(_vdX, _vdY, _vnX, _vnY) * _vnY;
								
								_b.spd = point_distance(0, 0, _vdX, _vdY);
								if _b.spd_target _b.spd_target = abs(_b.spd_target)
								_b.x_vel = 0;
								_b.y_vel = 0;
								_b.dir = point_direction(0, 0, _vrX, _vrY);
								_b.disconnect = 1;
							}
						}
						
						
						grazeCombo += 1;
						grazeComboQueue += 1;
						grazeComboTimer = tGrazeComboTimer;
						lifeCharge = min(lifeCharge + lifeChargeGraze, 1);
						
						_grazeTotal++;
						
						grazeComboQueueLastX = _b.x;
						grazeComboQueueLastY = _b.y;
		
						ignore global.score += round(power(grazeCombo + 1, 0.463)-1)*10+10;
						
		
						grazeHitboxGraphicShow = 1;
						
						if hook_ing /*&& random(1) < 1 - (point_distance(x, y, hook_x, hook_y)-64)/100*/ {
							instance_destroy(_b);
						}
		
						//func_grazeFlavorText(string(grazeCombo))
					}
				}
				if _grazeTotal
					with instance_create_layer(x, y, "Instances", obj_collectable) {
						sprite_index = spr_collectable_graze;
						var _scale = random_range(0.4, 1);
						image_xscale = _scale;
						image_yscale = _scale;
						image_alpha = 0.6;
						
						scoreGive = _grazeTotal * 10;
						x_vel = random_range(-2, 2);
						y_vel = random_range(-3, 2);
						latchTimer = 30;
						accel = 0.4;
					}
			}
			
		}
		ds_list_destroy(_grazedBulletsList)
		#endregion
		
		grazeComboQueueTimer -= global.delta_multi
		if grazeComboQueue != 0 && grazeComboQueueTimer <= 0{
			grazeComboQueueTimer = tGrazeComboQueueTimer
			grazeComboQueue = max(grazeComboQueue - ceil(lerp(grazeCombo - grazeComboQueue, grazeCombo, 0.5) - (grazeCombo - grazeComboQueue)), 0)
			func_grazeFlavorText(string(grazeCombo - grazeComboQueue), grazeComboQueueLastX, grazeComboQueueLastY)
			
		}
		

		lifeCharge = min(lifeCharge + lifeChargeSpeed * global.delta_multi, 1);

		// TODO: rebalance bulletcharge
		bulletCharge = approach(bulletCharge, (vkey == -1 ? bulletChargeTarget : 0), (vkey == -1 ? bulletChargeSpeed : bulletChargeSpeedSlow) * global.delta_multi)
		var _newReloadTime = ( tReloadTime + 1 - power(min(grazeCombo * grazeComboBulletMult + 1, 100), grazeComboBulletExp) ) - bulletCharge
		var _newReloadHomingTime = ( tReloadHomingTime + 1 - power(min(grazeCombo * grazeComboBulletMult + 1, 100), grazeComboBulletExp) ) - bulletCharge
		var _newReloadRoundTime = ( tReloadRoundTime + 1 - power(min(grazeCombo * grazeComboBulletMult + 1, 100), grazeComboBulletExp) ) - bulletCharge
		var _newReloadWavyTime = ( tReloadWavyTime + 1 - power(min(grazeCombo * grazeComboBulletMult + 1, 100), grazeComboBulletExp) ) - bulletCharge * 2
		
		reloadTime -= global.delta_multi
		reloadHomingTime -= global.delta_multi
		reloadRoundTime -= global.delta_multi
		reloadWavyTime -= global.delta_multi
		
		canShoot = instance_number(obj_textbox) == 0 && instance_number(obj_roomTransition) == 0;
		
		isShooting = input.check("shoot") && canShoot
		
		hook_charge = min(hook_charge + 0.004 * global.delta_multi, 1);
		
		hook_buffer--;
		if hook_buffer > 0 && input.check_pressed("bomb") && canShoot {
			var _inst = instance_nearest(x, y, obj_enemy)
			if ((_inst != noone && point_distance(x, y, _inst.x, _inst.y) < 100) || point_distance(x, y, hook_x, hook_y) < 100) {
				instance_create_layer(x, y, layer, obj_playerPop);
				game_pause(8)
				var test = render.shockwave_create(x, y)
					test.mode = 1
					test.scaleTarget = WIDTH * 4
					test.scaleSpeed = 64
				iFrames = 6;
			} else {
				//instance_create_layer(x, y, layer, obj_playerPop);
			}
		}
		if !instance_exists(hook_target) && !hook_ing  && hook_charge == 1 && canShoot {
			
			var _enemyList = ds_list_create()
			collision_rectangle_list(x-30, y, x+30, y - 10000, obj_enemy, false, true, _enemyList, true);
			hook_testTarget = noone;
			if ds_list_size(_enemyList) {
				hook_testTarget = _enemyList[| ds_list_size(_enemyList) - 1];
			}
			ds_list_destroy(_enemyList);
			
			if hook_testTarget != noone && canShoot {
				hook_maybeTarget = true;
				hook_x = hook_testTarget.x;
				hook_y = hook_testTarget.y;
				if input.check_pressed("bomb") {
					game_pause(4);
					hook_ing = true;
					hook_target = hook_testTarget;
					hook_x = hook_target.x;
					hook_y = hook_target.y;
					
					hook_charge = 0;
					hook_maybeTarget = false;
					iFrames = 10;
				}
				
			} else {
				hook_maybeTarget = false;
			}
			
			
		}
		if hook_ing && instance_exists(hook_target) {
			hook_x = hook_target.x;
			hook_y = hook_target.y;
		} else {
			
		}
		if hook_ing {
			hook_buffer = 12;
		}

		
		
		#region shoot
		if isShooting {
			if reloadTime <= 0 {
				reloadTime = _newReloadTime
				var _spreadTemp = input.check("sneak") ? bulletSpreadSlow : bulletSpread
				var _spreadAngleTemp = input.check("sneak") ? bulletSpreadAngleSlow : bulletSpreadAngle
			
				bullet_preset_plate(x, y, bulletAmount, _spreadTemp, _spreadAngleTemp, 2, 90, function(_x, _y, _dir){
					var _inst = instance_create_depth(_x, _y, depth, obj_bullet_player)
		
					with _inst {
						fade = 1
						fadeTime = 1
						_inst.x_vel = lengthdir_x(other.bulletSpeed, _dir);
						_inst.y_vel = lengthdir_y(other.bulletSpeed, _dir);
						damage = other.bulletDamage
					}
				})
			}
			if reloadHomingTime <= 0 {
				reloadHomingTime = _newReloadHomingTime
				var _spreadAngleTemp = input.check("sneak") ? bulletHomingSpreadAngleSlow : bulletHomingSpreadAngle
			
				bullet_preset_plate(x, y, bulletHomingAmount, 4, _spreadAngleTemp, 1, 90, function(_x, _y, _dir){
					var _inst = instance_create_depth(_x, _y, depth, obj_bullet_player)
		
					with _inst {
						fade = 1
						fadeTime = 1
						dir = _dir;
						spd = other.bulletHomingSpeed;
						
						step = function(){
							var _target = instance_nearest(x, y, obj_enemy);
							if _target != noone
								dir_target = point_direction(x, y, _target.x, _target.y);
						}
						dir_target = dir;
						dir_accel = input.check("sneak") ? 1 : 2;
						
						damage = other.bulletHomingDamage
						
						sprite_index = spr_bullet_homingplayerTest
						
						command_timer(60, function(){
							step = undefined;
						})
					}
				})
			}
			if reloadRoundTime <= 0 {
				reloadRoundTime = _newReloadRoundTime
			
				bullet_preset_ring(x, y, bulletRoundAmount, 4, random_range(0, 360), function(_x, _y, _dir){
					var _inst = instance_create_depth(_x, _y, depth, obj_bullet_player)
		
					with _inst {
						fade = 1
						fadeTime = 1
						dir = _dir;
						spd = other.bulletRoundSpeed;
						
						dir_target = 90;
						dir_accel = input.check("sneak") ? 9 : 6;
						
						damage = other.bulletRoundDamage
						
						sprite_index = spr_player_round;

					}
				})
			}
			if reloadWavyTime <= 0 {
				reloadWavyTime = _newReloadWavyTime
				var _spreadAngleTemp = input.check("sneak") ? bulletWavySpreadAngleSlow : bulletWavySpreadAngle;
				var _spreadTemp = input.check("sneak") ? bulletWavySpreadSlow : bulletWavySpread;
				
				bullet_preset_plate(x, y + 32, bulletWavyAmount, _spreadTemp, _spreadAngleTemp, 0, 90, function(_x, _y, _dir){
					var _inst = instance_create_depth(_x, _y, depth, obj_bullet_player)
		
					with _inst {
						fade = 1
						fadeTime = 1
						dir = _dir;
						spd = other.bulletWavySpeed;
						
						b_off = random(4)
						
						static _wavyStepFunction = function(){ // TODO: redo
							x += wave(-2, 2, 1, b_off) * global.delta_multi;
							mask_index = sprite_index;
							if place_meeting(x, y, obj_enemy) {
								b_kill = true
								instance_destroy()
							}
								
							mask_index = spr_nothing;
						}
						step = _wavyStepFunction;
						static _wavyDeathFunction = function(){
							if b_kill
							bullet_preset_ring(x, y, b_amount, 8, random(360), function(_x, _y, _dir){
								var _inst = instance_create_depth(_x, _y, depth, obj_bullet_player)
								with _inst {
									fade = 1
									fadeTime = 1
									dir = _dir;
									spd = other.b_speed;
						
									damage = other.b_damage;
							
									image_alpha = 0.5;
									sprite_index = spr_player_round;
								}
							});
						}
						death = _wavyDeathFunction;
						
						damage = other.bulletWavyDamage;
						
						b_damage = other.bulletWavySplashDamage
						b_amount = other.bulletWavySplashAmount
						b_speed = other.bulletWavySplashSpeed
						b_kill = false;
						
						sprite_index = spr_player_wavy;
						mask_index = spr_nothing;
					}
				})
			}
		}
		if isShooting && input.check("sneak") {
			bullet_preset_plate(0, 0 - 16, array_length(bulletLaserList), bulletLaserSpreadSlow, bulletLaserSpreadAngleSlow, 4, 90, function(_x, _y, _dir, _i) {
				var _inst = bulletLaserList[_i];
				_inst.xOff = lerp(_inst.xOff, _x, 1 - power(1 - 0.99999, global.delta_milli * 2));
				_inst.yOff = lerp(_inst.yOff, _y, 1 - power(1 - 0.99999, global.delta_milli * 2));
				_inst.angle_target = _dir;
				_inst.damage = bulletLaserDamage;
			})
		} else {
			bullet_preset_plate(0, 0 - 16, array_length(bulletLaserList), bulletLaserSpread, bulletLaserSpreadAngle, 16, 90, function(_x, _y, _dir, _i) {
				var _inst = bulletLaserList[_i];
				_inst.xOff = lerp(_inst.xOff, _x, 1 - power(1 - 0.99999, global.delta_milli * 2));
				_inst.yOff = lerp(_inst.yOff, _y, 1 - power(1 - 0.99999, global.delta_milli * 2));
				_inst.angle_target = _dir;
				_inst.damage = bulletLaserDamage;
			})
		}
		if isShooting {
			for (var i = 0; i < array_length(bulletHelperList); i++) {
				var _damage = bulletHelperDamage;
				with bulletHelperList[i] {
					tReloadTime = other.bulletHelperReload - i;
					
					reloadTime -= global.delta_multi;
					if reloadTime <= 0 {
						reloadTime = tReloadTime;
						var _inst = instance_create_depth(x, y, depth, obj_bullet_player)
		
						with _inst {
							fade = 1
							fadeTime = 1
							dir = 90;
							spd = 14;
							damage = _damage;
							sprite_index = spr_player_helper
						}
					}
				}
			}
			for (var i = 0; i < array_length(bulletEvilList); i++) {
				var _damage = bulletEvilDamage;
				with bulletEvilList[i] {
					tReloadTime = other.bulletEvilReload - i;
					
					reloadTime -= global.delta_multi;
					if reloadTime <= 0 {
						reloadTime = tReloadTime;
						var _inst = instance_create_layer(x, y, "Instances", obj_bullet_player)
		
						with _inst {
							fade = 1
							fadeTime = 1
							dir = 90;
							spd = 14;
							//show_debug_message(_damage)
							damage = _damage;
							sprite_index = spr_player_helper
						}
					}
				}
			}
		}
		#endregion
	}
})
state.add("respawn", {
	enter : function(){
		respawnAnim.percent = 0
		respawnAnim.add("x", x, 256)
		respawnAnim.add("y", y, HEIGHT - 32)
	},
	step : function(){
		x = respawnAnim.evaluate("x")
		y = respawnAnim.evaluate("y")
		respawnAnim.percent += 0.05 * global.delta_multi;
		if respawnAnim.percent >= 1 {
			state.change("idle")
		}
	}
})

#endregion



respawnAnim = new AnimCurve("back");

var _Point = function() constructor {
	x = 0;
	y = 0;
	x_vel = 0;
	y_vel = 0;
	damp = 1;
	dir = 0;
	len = 12;
}

tails = [];
for (var i = 0; i < 2; i++) {
	var tail = [];
	for (var j = 0; j < 10; j++) { // 10
		var p = new _Point();
	
		p.len = min(power(max(j - 4, 0) , 1.16) + 5, 11)
		p.damp = 0.9
	
		array_push(tail, p);
	}
	array_push(tails, tail);
}



hitboxAnim = new Sod().setAccuracy();
hitboxSize = 0;

dir_graphic = 1;
dir_anim = 0;

surf = -1;

iFrames = 0;

