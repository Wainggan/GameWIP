moveSpeed = 4;
slowMoveSpeed = 2;

x_vel = 0;
y_vel = 0

accel = 2.5;
slowAccel = 1;


grazeRadius = 38;

grazeCombo = 0;
tGrazeComboTimer = 60 * 5;
grazeComboTimer = 0;
grazeComboQueue = 0;
grazeComboQueueTimer = 0;
tGrazeComboQueueTimer = 4;

grazeBulletList = [];
grazeBulletListClearTime = 60 * 4;

grazeHitboxGraphicShow = 0;
grazeHitboxGraphicShowSpeed = 0.05;


parryRadius = 20;


bulletCharge = 0;
bulletChargeSpeed = 0.1;
bulletChargeSpeedSlow = 0.01;
bulletChargeTarget = 1.5;

tReloadTime = 9;
reloadTime = tReloadTime;

bulletSpread = 2;
bulletSpreadAngle = 28
bulletSpreadSlow = 5
bulletSpreadAngleSlow = 2
bulletAmount = 3;
bulletSpeed = 12;

livesLeft = 3;

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

inputSystem = new InputManager(); // vk_up, ord("W")
inputSystem.create_input("up")
	.add_keyboard_key(vk_up)
	.add_keyboard_key(ord("W"))
	.add_gamepad_stick(gp_axislv, -1)
	.add_gamepad_button(gp_padu)
inputSystem.create_input("down")
	.add_keyboard_key(vk_down)
	.add_keyboard_key(ord("S"))
	.add_gamepad_stick(gp_axislv, 1)
	.add_gamepad_button(gp_padd)
inputSystem.create_input("left")
	.add_keyboard_key(vk_left)
	.add_keyboard_key(ord("A"))
	.add_gamepad_stick(gp_axislh, -1)
	.add_gamepad_button(gp_padl)
inputSystem.create_input("right")
	.add_keyboard_key(vk_right)
	.add_keyboard_key(ord("D"))
	.add_gamepad_stick(gp_axislh, 1)
	.add_gamepad_button(gp_padr)

inputSystem.create_input("shoot")
	.add_keyboard_key(ord("Z"))
	.add_keyboard_key(ord("J"))
	.add_gamepad_button(gp_face3)
	.add_gamepad_button(gp_face2)
	.add_gamepad_button(gp_face1)
inputSystem.create_input("sneak")
	.add_keyboard_key(vk_shift)
	.add_keyboard_key(ord("K"))
	.add_gamepad_button(gp_face2)
	.add_gamepad_button(gp_face4)
	.add_gamepad_shoulder(gp_shoulderlb)
	.add_gamepad_shoulder(gp_shoulderrb)
#endregion

func_grazeFlavorText = function(_text) {
	var _inst = instance_create_depth(x+16, y-16, depth, obj_flavorText)
	with _inst {
		_inst.accel_y = 0.1;
		_inst.x_vel = 0.3;
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
    
	    var targetTopSpeed = (inputSystem.check("sneak") ? slowMoveSpeed : moveSpeed)
	    var targetAccel = (inputSystem.check("sneak") ? slowAccel : accel)
    
	    //x_vel = approach(x_vel, (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix), targetAccel * global.delta_multi);
	    //y_vel = approach(y_vel, (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix), targetAccel * global.delta_multi);
	    x_vel = (hkey == 0 ? 0 : hkey * targetTopSpeed * directionFix);
	    y_vel = (vkey == 0 ? 0 : vkey * targetTopSpeed * directionFix);

		x += x_vel * global.delta_multi;
		y += y_vel * global.delta_multi;


		x = clamp(x, 4, WIDTH-4)
		y = clamp(y, 10, HEIGHT-2)


		

		var _grazedBulletsList = ds_list_create()
		collision_circle_list(x, y, grazeRadius, obj_bullet, 0, 1, _grazedBulletsList, true)
		if ds_list_size(_grazedBulletsList) > 0 {
			var _out = 0;
			for (var i = 0; i < ds_list_size(_grazedBulletsList); i++) {
				if place_meeting(x, y, _grazedBulletsList[| i]) {
					_out = 1;
					break;
				}
			}
			if iFrames <= 0 && _out {
				global.pause = 8;
				iFrames = 20;
	
				var test = instance_create_layer(x, y, layer, obj_bulletDestroyer)
				test.targetSize = WIDTH;
				test.sizeSpeed = 28;
			
				var test = render.shockwave_create(x, y)
				test.mode = 1
				test.scaleTarget = WIDTH * 4
				test.scaleSpeed = 32
	
				livesLeft--
	
				grazeComboQueue = 0;
				grazeCombo = 0;
				func_grazeFlavorText("0")
			
				state.change("respawn")
			} else {
				for (var i = 0; i < ds_list_size(_grazedBulletsList); i++) {
					var _out = 0;
					for (var j = 0; j < array_length(grazeBulletList); j++) {
						if grazeBulletList[j][0] == _grazedBulletsList[| i] {
							_grazedBulletsList[| i].highlight = true
							_out = 1;
							//break;
						}
					}
					if _out == 0 {
						array_push(grazeBulletList, [_grazedBulletsList[| i], grazeBulletListClearTime])
						grazeCombo += 1;
						grazeComboQueue += 1;
						grazeComboTimer = tGrazeComboTimer;
		
						global.score += 100;
		
						grazeHitboxGraphicShow = 1;
		
						//func_grazeFlavorText(string(grazeCombo))
					}
				}
			}
			
			
		}
		ds_list_destroy(_grazedBulletsList)
		
		grazeComboQueueTimer -= global.delta_multi
		if grazeComboQueue != 0 && grazeComboQueueTimer <= 0{
			grazeComboQueueTimer = tGrazeComboQueueTimer
			grazeComboQueue = max(grazeComboQueue - ceil(lerp(grazeCombo - grazeComboQueue, grazeCombo, 0.5) - (grazeCombo - grazeComboQueue)), 0)
			func_grazeFlavorText(string(grazeCombo - grazeComboQueue))
			
		}


		// TODO: rebalance bulletcharge
		bulletCharge = approach(bulletCharge, (vkey == -1 ? bulletChargeTarget : 0), (vkey == -1 ? bulletChargeSpeed : bulletChargeSpeedSlow) * global.delta_multi)
		var _newReloadTime = ( tReloadTime + 1 - power(min(grazeCombo + 1, 100), 0.2) ) - bulletCharge

		if inputSystem.check("shoot") && reloadTime <= 0 && instance_number(obj_textbox) == 0 {
			reloadTime = _newReloadTime
			var _spreadTemp = inputSystem.check("sneak") ? bulletSpreadSlow : bulletSpread
			var _spreadAngleTemp = inputSystem.check("sneak") ? bulletSpreadAngleSlow : bulletSpreadAngle
	
			for (var i = 0; i < bulletAmount; i+= 1) {
				var _dir = (90 + -_spreadAngleTemp/2) - (-_spreadAngleTemp/(bulletAmount-1) * i)
				var _offset = _spreadTemp * (bulletAmount - 1 - (i * 2))
		
				var _inst = instance_create_depth(x + _offset, y, depth, obj_bullet_player)
		
				with _inst {
					_inst.x_vel = lengthdir_x(other.bulletSpeed, _dir);
					_inst.y_vel = lengthdir_y(other.bulletSpeed, _dir);
				}
			}
	
		}
	}
})
state.add("respawn", {
	enter : function(){
		respawnAnim.percent = 0
		respawnAnim.add("x", x, 256)
		respawnAnim.add("y", y, 400)
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

tailLength = 16;
tails = [];
for (var i = 0; i < 3; i++) {
	var tail = new RopeManager()
	tail.createRope(x, y, tailLength) // 28
	tail.points_applyFunc(function(p){
		p.x_drag = 0.7//0.2
		p.y_drag = 0.7//0.2
		p.soft = false
	})
	tail.sticks_applyFunc(function(p, j){
		p.length = power(j , 0.4) + 2
	})
	tail.iterations = 6
	tail.points[0].locked = true
	
	array_push(tails, tail)
}


hitboxAnim = new TweenManager()
hitboxSize = 0;

iFrames = 0;

