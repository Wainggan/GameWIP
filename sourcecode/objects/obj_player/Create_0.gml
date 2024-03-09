if instance_number(obj_player) > 1 {
	instance_destroy();
	exit;
}

moveSpeed = 5;
fastMoveSpeed = 5;
slowMoveSpeed = 2;

x_vel = 0;
y_vel = 0

accel = 0.1//2.5;
slowAccel = 1;

moveAnim = new Sod(6)

isShooting = false;

upgrades = {}
config = new PlayerConfig(self)


collectDist = 64;
collectPoint = 0;
collectAllBullets = true;


grazeRadius = 38;

grazeCombo = 0;
tGrazeComboTimer = 60 * 10;
grazeComboTimer = 0;

grazeComboQueue = 0;
grazeComboQueueTimer = 0;
tGrazeComboQueueTimer = 2;
grazeComboQueueLastX = 0;
grazeComboQueueLastY = 0;

graze_charge = 0;
graze_charge_timer = 0;

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
grazeComboBulletExp = 0.15;

shakeAmount = 0;
shakeDamp = 1;
offX = 0;
offY = 0;

#region bullet upgrade defines

weapons = []

bullet_default = new PlayerWeapon_Default()
array_push(weapons, bullet_default)

bullet_homing = new PlayerWeapon_Homing()
array_push(weapons, bullet_homing)

bullet_lazer = new PlayerWeapon_Lazer()
array_push(weapons, bullet_lazer)

bullet_round = new PlayerWeapon_Round()
array_push(weapons, bullet_round)

bullet_helper = new PlayerWeapon_Lad()
array_push(weapons, bullet_helper)

#endregion

livesLeft = 3;
bombsLeft = 3;

lifeCharge = 0.0;
lifeChargeSpeed = 0.0000;
lifeChargeGraze = 0.0000;
lifeChargeGraphicX = x;
lifeChargeGraphicY = y;


hook_icon_xAnim = new Sod(4, 1, 0);
hook_icon_showAnim = new Sod(2, 1, 0);
hook_icon_rotate = 0;
hook_ind_xAnim = new Sod(4, 0.7, 0);
hook_ind_yAnim = new Sod(4, 0.7, 0);
hook_ind_showAnim = new Sod(4, 1, 0);
hook_line_showAnim = new Sod(5, 1, 0);
hook_x = 0;
hook_y = 0;
hook_x_vel = 0;
hook_y_vel = 0;
hook_ing = false;
hook_target = noone;
hook_maybeTarget = noone;
hook_buffer = 0;
hook_extrabuffer = 0;
hook_iframe = 0;
hook_radius = 0;
hook_radius_collectLimit = 0;
hook_charge = 0;

hook_focus_charge = 0;
hook_focus_chargeAnim = new Sod(4, 0.6, 0);
hook_focus_limit = 4;
hook_focus_active = false;
hook_focus_contactList = [];

debug_invincible = false


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
	var _dir = point_direction(x, y, _x, _y);
	
	var _nX = ((_x - x) / _dist) * 72;
	var _nY = ((_y - y) / _dist) * 72;
	
	_x = clamp(x + _nX, 16, WIDTH - 16);
	_y = clamp(y + _nY, 16, HEIGHT - 16);
	
	var _inst = instance_create_depth(_x, _y, depth, obj_flavorText)
	with _inst {
		_inst.accel_y = 0.1;
		_inst.x_vel = -sign(_nX) * 0.4;
		_inst.y_vel = -1.3;
			
		_inst.life = 15;
		
		_inst.scale = 0.6
		_inst.scale_vel = 0.08
		_inst.scale_target = 3
			
		_inst.text = string(_text)
	}
}

func_hookPop = function(){
	
	with instance_create_layer(x, y, layer, obj_playerPop) {
		size = other.hook_radius
	}
	screenShake_set(4, 0.2);
	game_pause(8)
	var test = render.shockwave_create(x, y)
		test.mode = 1
		test.scaleTarget = WIDTH * 4
		test.scaleSpeed = 64
					
	var inst = instance_create_layer(x, y, layer, obj_bulletDestroyer)
	inst.targetSize = hook_radius
	inst.sizeSpeed = 64;
	inst.bulletBonus = true;
	inst.destroy = true;
	inst.bulletCharge = true
	
	particle_burst(x, y, ps_player_hookPop)
	
	hook_radius += 16
				
	repeat 25
		text_splash_random(x, y, "1000", 128, 20);
	global.score += 1000 * 25;
				
	iFrames = 9;
	hook_iframe = 6;
	
	if hook_extrabuffer < 0 {
		if hook_focus_active {
			hook_focus_charge += 2;
		} else {
			//hook_focus_charge += 1;
		}
		hook_focus_charge = min(hook_focus_charge, hook_focus_limit)
	}
				
	if hook_extrabuffer < 0 
		hook_extrabuffer = 6;
	else
		hook_extrabuffer = -1;
	hook_buffer = 0
	
	hook_radius_collectLimit = 24
	
}

func_handleFocus = function() {
	
	if hook_focus_charge == hook_focus_limit && input.check_pressed("focus") {
		hook_focus_active = true;
		game_pause(3)
		screenShake_set(2, 0.1)
	}
	
	if hook_focus_active {
		game_focus_set(true)
		if !global.pause {
			global.slowdownTime = 4;
		}
			
		hook_focus_charge -= 0.04 * global.delta_multi;
		if hook_focus_charge <= 0 {
			hook_focus_charge = 0;
			hook_focus_active = false;
			game_pause(6)
			screenShake_set(5, 0.2)
			game_focus_set(false)
				
			for (var i = 0; i < array_length(hook_focus_contactList); i++) {
				with hook_focus_contactList[i] {
					var _d
					if !instance_exists(obj_enemy) {
						_d = irandom(360);
					} else {
						_d = instance_find(obj_enemy, irandom_range(0, instance_number(obj_enemy) - 1))
						_d = point_direction(x, y, _d.x, _d.y);
					}
					
					particle_burst(x, y, ps_bulletFocusPop)
					
					with instance_create_depth(x, y, depth, obj_bullet_player) {
						fade = 1
						fadeTime = 1
						x_vel = 0;
						y_vel = 0;
						spd = 12;
						dir = _d;
						damage = 5
						fakedamage = 5
						
						s_captured = true
								
						image_alpha = 1;
						sprite_index = other.sprite_index;
						image_index = 2;
						image_blend = merge_color(other.glow, c_white, 0.5);
						if other.showDirection image_angle = other.dir;
								
					}
						
					instance_destroy()
						
				}
			}
		}
	}
	
}

func_handleCollectable = function(_inst){
	
	if _inst.s_charge {
		hook_radius_collectLimit -= 1
		if hook_radius_collectLimit >= 0 {
			hook_focus_charge += 0.06
		}
	}
	
}

#region states

state = new State("idle");
state.add("idle", {
step : function(){
	var _ = player_calculate_upgrade()
	
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
    
	var targetTopSpeed = (input.check("sneak") ? _.moveSpeed_slow : (input.check("shoot") ? _.moveSpeed : _.moveSpeed_fast))
	var targetAccel = (input.check("sneak") ? _.accel_slow : _.accel)
	
	// adjust for slow-mo
	// making the game harder to change, one shitty line at a time
	var _slowmoAdjust = (60 * (1 / game.targetFrame)) * global.delta_multi;
    
	x_vel = approach(x_vel, (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix), targetAccel * _slowmoAdjust);
	y_vel = approach(y_vel, (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix), targetAccel * _slowmoAdjust);
		
	//x_vel = (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix)
	//y_vel = (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix)
	
	x += x_vel * _slowmoAdjust;
	y += y_vel * _slowmoAdjust;
		
	var _lastX = x;

	x = clamp(x, 4, WIDTH-4);
	y = clamp(y, 4, HEIGHT-4);
		
	with obj_collectable {
		if		other.y < _.collectPoint || 
				sprite_index == spr_collectable_bulletBonus
			latch = true;
	}
	
	hook_focus_charge = min(hook_focus_charge, hook_focus_limit)
	
	if DEBUG if keyboard_check_pressed(ord("Y")) {
		hook_focus_charge = 4;
	}

	#region Bullet Collision
	var _grazedBulletsList = ds_list_create()
	collision_circle_list(x, y, grazeRadius - 0, obj_bullet, 0, 1, _grazedBulletsList, true);
	if ds_list_size(_grazedBulletsList) > 0 {
		var _inst = instance_place(x, y, obj_bullet)
		if iFrames <= 0 && !hook_ing && _inst != noone && _inst.fade == 0 {
			if lifeCharge < 1 {
				//lifeCharge = min(lifeCharge + 0.5, 1);
					
				game_pause(10, true);
				screenShake_set(4);
				shakeAmount = 20;
				shakeDamp = 2;
				iFrames = 60;
					
				var test = instance_create_layer(x, y, layer, obj_bulletDestroyer)
				test.targetSize = WIDTH * 2;
				test.sizeSpeed = 40;
				
				var test = render.shockwave_create(x, y)
				test.mode = 1
				test.scaleTarget = WIDTH * 4
				test.scaleSpeed = 32
					
				//particle.burst(x, y, "playerDeath")
	
				livesLeft--
					
				hook_target = noone;
				hook_ing = false;
					
				grazeComboQueue = 0;
				grazeCombo = 0;
				func_grazeFlavorText("0")
				
				instance_create_layer(x, y, layer, obj_effect_hit)
				
				if livesLeft <= 0
					state.change("dying");
				else
					state.change("respawn")
			} else {
				lifeCharge = 0;
					
				game_pause(6, false);
				shakeAmount = 6;
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
					
					// reflect bullets
					if _.graze_reflectChance > 0 && random(1) < _.graze_reflectChance {
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
					
					graze_charge += _.graze_charge_gain;
					graze_charge_timer = _.graze_charge_retention;
					
					//lifeCharge = min(lifeCharge + lifeChargeGraze, 1);
						
					_grazeTotal++;
						
					grazeComboQueueLastX = _b.x;
					grazeComboQueueLastY = _b.y;
						
					//text_splash_random(x, y, string(max(grazeComboQueue - ceil(lerp(grazeCombo - grazeComboQueue, grazeCombo, 0.5) - (grazeCombo - grazeComboQueue)), 0) * 10), 32, 6)
		
					ignore global.score += round(power(grazeCombo + 1, 0.463)-1)*10+10;
						
		
					grazeHitboxGraphicShow = 1;
						
					if hook_focus_active && _b.object_index != obj_laser {
						_b.innerGlow = #ddddff
						_b.spd /= 4;
						_b.x_vel /= 4;
						_b.y_vel /= 4;
						if _b.spd_target _b.spd_target /= 4;
						if _b.x_target _b.x_target /= 4;
						if _b.y_target _b.y_target /= 4;
						array_push(hook_focus_contactList, _b)
					}
		
					//func_grazeFlavorText(string(grazeCombo))
				}
				if hook_ing || hook_iframe {
					instance_destroy(_b)
					text_splash_random(x, y, "100", 32, 20);
					global.score += 100;
				}
			}
			if _grazeTotal {
				repeat 1 + hook_focus_active * 1 {
					var _x = random_range(-2, 2);
					var _y = random_range(-3, 2);
					var _dir = point_direction(0, 0, _x, _y)
					with instance_create_layer(x + lengthdir_x(8, _dir), y + lengthdir_y(8, _dir), "Instances", obj_collectable) {
						sprite_index = spr_collectable_graze;
						var _scale = random_range(0.4, 1);
						image_xscale = _scale;
						image_yscale = _scale;
						image_alpha = 0.6;
						
						scoreGive = _grazeTotal * 10;
						x_vel = _x
						y_vel = _y
						latchTimer = 30;
						accel = 0.4;
					}
				}
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
	
	graze_charge_timer -= global.delta_multi
	if graze_charge_timer <= 0 {
		graze_charge -= _.graze_charge_loss * global.delta_multi
	}
	graze_charge = clamp(graze_charge, 0, 1)
	

	//lifeCharge = min(lifeCharge + lifeChargeSpeed * global.delta_multi, 1);

	// TODO: rebalance bulletcharge
	bulletCharge = approach(bulletCharge, (vkey == -1 ? bulletChargeTarget : 0), (vkey == -1 ? bulletChargeSpeed : bulletChargeSpeedSlow) * global.delta_multi)
		
	isShooting = input.check("shoot") && canShoot
		
	hook_charge = min(hook_charge + _.hook_charge_ambient * global.delta_multi, 1);
	hook_charge = min(hook_charge + graze_charge * _.hook_charge_grazeMultiplier * global.delta_multi, 1);
	func_handleFocus()
		
	hook_buffer -= global.delta_multi;
	hook_extrabuffer -= global.delta_multi;
	hook_iframe -= global.delta_multi;
	if (hook_buffer > 0 || (hook_extrabuffer > 0 && hook_extrabuffer <= 3)) && input.check_pressed("bomb") && canShoot {
		func_hookPop()
	}
	
	var _testTarget = noone
	
	// check if upgrade is in range
	_testTarget = collision_rectangle(x-48, y-48, x+48, y - HEIGHT, obj_collectable_upgrade, false, true);
	
	// move into hook state
	if !hook_ing  && (hook_charge == 1 || _testTarget != noone) && canShoot {
		
		if _testTarget == noone {
			// check if valid enemy above player exists
			var _enemyList = ds_list_create()
			collision_rectangle_list(x-24, y-48, x+24, y - HEIGHT, obj_enemy, false, true, _enemyList, true);
			if ds_list_size(_enemyList) {
				_testTarget = _enemyList[| ds_list_size(_enemyList) - 1];
			}
			collision_rectangle_list(x-48, y-48, x+48, y - HEIGHT, obj_enemy, false, true, _enemyList, true);
			if ds_list_size(_enemyList) {
				_testTarget = _enemyList[| ds_list_size(_enemyList) - 1];
			}
		
			ds_list_destroy(_enemyList);
		}
		
		
		// if enemy does exist, record its existence so the indicator can animate
		if _testTarget != noone && canShoot {
			hook_maybeTarget = _testTarget;
			hook_x = _testTarget.x;
			hook_y = _testTarget.y;
			
			// if player presses bomb, start hooking
			if input.check_pressed("bomb") {
				game_pause(4);
				hook_target = _testTarget;
					
				hook_charge = 0;
				hook_maybeTarget = noone;
				iFrames = 10;
				
				state.change("hook")
			}
				
		} else {
			hook_maybeTarget = noone;
			hook_target = noone;
			hook_x = x;
			hook_y = y;
		}
	} else {
		hook_maybeTarget = noone;
		hook_target = noone;
		hook_x = x;
		hook_y = y;
	}
	
	
	for (var i = 0; i < array_length(weapons); i++) {
		weapons[i].run(isShooting, _)
	}
}
})
state.add("respawn", {
enter : function(){
	respawnAnim.percent = 0
	respawnAnim.add("x", x, 256)
	respawnAnim.add("y", y, HEIGHT - 32)
},
step : function(){
	var _ = player_calculate_upgrade()
	
	x = respawnAnim.evaluate("x")
	y = respawnAnim.evaluate("y")
	
	isShooting = false
	for (var i = 0; i < array_length(weapons); i++) {
		weapons[i].run(false, _)
	}
	
	respawnAnim.percent += 0.05 * global.delta_multi;
	if respawnAnim.percent >= 1 {
		state.change("idle")
	}
}
})

state.add("hook", {
enter: function(){
	hook_ing = true;
	hook_x_vel = 0;
	hook_y_vel = 0;
	hook_radius_vel = 0;
	hook_radius = 48;
},
step: function(){
	var _ = player_calculate_upgrade()
	
	if instance_exists(hook_target) && 
		(hook_target.x > 0 || hook_target.x < WIDTH || hook_target.y > 0 || hook_target.y < HEIGHT)
	{
		hook_x = hook_target.x;
		hook_y = hook_target.y;
	} else {
		
	}
	
	hook_radius_vel = approach(hook_radius_vel, 14, 0.4 * global.delta_multi)
	hook_radius = approach(hook_radius, 84, hook_radius_vel * global.delta_multi)
	
	var _dir = point_direction(x, y, hook_x, hook_y);
	
	hook_x_vel = approach(hook_x_vel, lengthdir_x(14 * global.delta_multi, _dir), 3);
	hook_y_vel = approach(hook_y_vel, lengthdir_y(14 * global.delta_multi, _dir), 2);
	x += hook_x_vel;
	y += hook_y_vel;
	
	isShooting = false
	for (var i = 0; i < array_length(weapons); i++) {
		weapons[i].run(false, _)
	}
	
	func_handleFocus()
	
	
	if instance_exists(hook_target) && hook_target.object_index == obj_collectable_upgrade {
		if point_distance(x, y, hook_x, hook_y) < hook_radius - 8 {
			// automatically explode if hooking an upgrade
			func_hookPop()
		
			hook_buffer = 0;
			state.change("idle")
		}
	} else {
		if input.check_pressed("bomb") && canShoot {
			func_hookPop()
			hook_buffer = 0;
			state.change("idle")
		}
		else if point_distance(x, y, hook_x, hook_y) < 64 {
			hook_buffer = 12;
			iFrames = 14;
			state.change("idle")
		}
	}
	ignore if hook_x < 0 || hook_x > WIDTH || hook_y < 0 || hook_y > HEIGHT {
		hook_buffer = 12;
		state.change("idle")
	}
	
	if schedule(2) particle_burst(x, y + 16, ps_player_hookTrail)
	
},

leave: function(){
	hook_ing = false;
	hook_target = noone
}
})


state.add("dying", {
	enter: function(){
		deadTimer = 1
	},
	step: function(){
		deadTimer -= global.delta_multi;
		if deadTimer <= 0
			state.change("dead")
	}
})
state.add("dead", {
	enter: function(){
		deadTimer = 60
	},
	step: function(){
		deadTimer -= global.delta_multi;
		if deadTimer <= 0 {
			game_pause(4, false)
			game_menu_steps(
				new Steps()
				.next(function(){ 
					room_goto(rm_mainmenu)
					game_music(-1)
					return menu.leaderboardType 
				})
				.next(function(){
					game_leaderboard_add(global.enteredName, global.score)
					return menu.leaderboard
				})
				.next(function(){ return menu.menu_main })
			);
			state.change("nothing")
		}
	}
})

state.add("nothing", {})

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

//tails = [];
//for (var i = 0; i < 2; i++) {
//	var tail = [];
//	for (var j = 0; j < 10; j++) { // 10
//		var p = new _Point();
		
//		p.len = min(power(max(j - 4, 0) , 1.16) + 5, 11)
		
//		//p.len = min(power(max(j - 6, 0) , 0.7) + 5, 11)
//		p.damp = 0.92
//		p.x = x
//		p.y = y + j * 6
		
//		p.size = max(parabola_mid(2, 8, 7, j) + 4, 6)
	
//		array_push(tail, p);
//	}
//	array_push(tails, tail);
//}

tails = [];
for (var i = 0; i < 2; i++) {
	var tail = yarn_create(10, function(_p, i){
		
		_p.len = min(power(max(i - 4, 0) , 1.16) + 5, 11)
		
		//p.len = min(power(max(j - 6, 0) , 0.7) + 5, 11)
		_p.damp = 0.92
		_p.x = x
		_p.y = y + i * 6
		
		_p.size = max(parabola_mid(2, 8, 7, i) + 3, 6)
		
	});
	array_push(tails, tail);
}

hairTuft = yarn_create(2, function(_p) {
	_p.sprite = spr_car
	
	_p.len = 30
	
	_p.x = x
	_p.y = y - 20
})


hitboxAnim = new Sod().setAccuracy();
hitboxSize = 0;
hitboxAnimRotate = 0;

dir_graphic = 1;
dir_anim = 0;

surf = -1;

iFrames = 0;

mask_index = spr_player_hitbox
