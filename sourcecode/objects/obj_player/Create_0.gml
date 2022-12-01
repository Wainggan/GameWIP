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

tReloadHomingTime = 12;
reloadHomingTime = tReloadHomingTime;


bulletSpread = 6;
bulletSpreadAngle = 20;
bulletSpreadSlow = 8
bulletSpreadAngleSlow = 1
bulletAmount = 3;
bulletSpeed = 14;
bulletDamage = 1;

bulletHomingSpreadAngle = 90;
bulletHomingSpreadAngleSlow = 45;
bulletHomingAmount = 0;
bulletHomingSpeed = 8;
bulletHomingDamage = 0.4;

bulletLaserList = [];
bulletLaserDamage = 0.02;

func_addLaser = function(){ // TODO: make them react to sneaking somehow(dont make it *too* stupid)
	with instance_create_layer(x, y, "Instances", obj_laser_player) {
		xOff = 0;
		yOff = 0;
		angle = 90;
		angle_target = 90;
		angle_accel = 2;
		damage = other.bulletLaserDamage
		array_push(other.bulletLaserList, self);
	}
	bullet_preset_plate(0, 0 - 16, array_length(bulletLaserList), 16, 16, 8, 90, function(_x, _y, _dir, _i) {
		bulletLaserList[_i].xOff = _x;
		bulletLaserList[_i].yOff = _y;
		bulletLaserList[_i].angle_target = _dir;
		bulletLaserList[_i].damage = bulletLaserDamage;
	})
}

func_addLaser()
func_addLaser()
func_addLaser()


ignore {
	bulletSpread = 6;
	bulletSpreadAngle = 32
	bulletSpreadSlow = 2
	bulletSpreadAngleSlow = 1
	bulletAmount = 32;
	bulletSpeed = 14;
}

livesLeft = 3;
bombsLeft = 3;

lifeCharge = 0.5;
lifeChargeSpeed = 0.0001;
lifeChargeGraze = 0.0001;
lifeChargeGraphicX = x;
lifeChargeGraphicY = y;

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
		
		x += x_vel * global.delta_multi;
		y += y_vel * global.delta_multi;
		

		x = clamp(x, 4, WIDTH-4);
		y = clamp(y, 4, HEIGHT-4);
		
		if y < collectPoint {
			with obj_collectable {
				latch = true;
			}
		}


		var _grazedBulletsList = ds_list_create()
		collision_circle_list(x, y, grazeRadius, obj_bullet, 0, 1, _grazedBulletsList, true)
		if ds_list_size(_grazedBulletsList) > 0 {
			if iFrames <= 0 && place_meeting(x, y, obj_bullet) {
				if lifeCharge < 1 {
					lifeCharge = min(lifeCharge + 0.5, 1);
					
					global.pause = 12;
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
					
					grazeComboQueue = 0;
					grazeCombo = 0;
					func_grazeFlavorText("0")
			
					state.change("respawn")
				} else {
					lifeCharge = 0;
					
					global.pause = 6;
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
					var _out = 0;
					if grazeBulletList[$ _grazedBulletsList[| i]] != undefined {
						//_grazedBulletsList[| i].highlight = true
						_out = 1;
					}
					if _out == 0 {
						grazeBulletList[$ _grazedBulletsList[| i]] = _grazedBulletsList[| i].object_index == obj_bullet ? grazeBulletListClearTime : grazeBulletListClearTimeLaser ;
						_grazedBulletsList[| i].pop = 1;
						
						grazeCombo += 1;
						grazeComboQueue += 1;
						grazeComboTimer = tGrazeComboTimer;
						lifeCharge = min(lifeCharge + lifeChargeGraze, 1);
						
						_grazeTotal++;
						
						grazeComboQueueLastX = _grazedBulletsList[| i].x;
						grazeComboQueueLastY = _grazedBulletsList[| i].y;
		
						ignore global.score += round(power(grazeCombo + 1, 0.463)-1)*10+10;
						
		
						grazeHitboxGraphicShow = 1;
		
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
			
			if input.check_pressed("bomb") && true {
				//var test = instance_create_layer(x, y, layer, obj_bulletDestroyer)
				//test.targetSize = 128;
				//test.sizeSpeed = 64;
			}
			
		}
		ds_list_destroy(_grazedBulletsList)
		
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
		
		isShooting = input.check("shoot") && instance_number(obj_textbox) == 0 && instance_number(obj_roomTransition) == 0;
		
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



hitboxAnim = new TweenManager()
hitboxSize = 0;

dir_graphic = 1;
dir_anim = 0;

surf = -1;

iFrames = 0;

