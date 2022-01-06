moveSpeed = 5;
slowMoveSpeed = 2;

grazeRadius = 38;

grazeCombo = 0;
tGrazeComboTimer = 60 * 5;
grazeComboTimer = 0;

grazeBulletList = [];
grazeBulletListClearTime = 64;

grazeHitboxGraphicShow = 0;
grazeHitboxGraphicShowSpeed = 0.05;


bulletCharge = 0;
bulletChargeSpeed = 0.08;
bulletChargeSpeedSlow = 0.02;
bulletChargeTarget = 2;

tReloadTime = 8;
reloadTime = tReloadTime;

bulletSpread = 2;
bulletSpreadAngle = 28
bulletSpreadSlow = 5
bulletSpreadAngleSlow = 2
bulletAmount = 3;
bulletSpeed = 12;

livesLeft = 3;


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

inputSystem = new Input();
inputSystem.bind("up", [vk_up, ord("W")]);
inputSystem.bind("up", gp_padu, INPUT_MODE_CONTROLLER);
inputSystem.bind("down", [vk_down, ord("S")]);
inputSystem.bind("down", gp_padd, INPUT_MODE_CONTROLLER);
inputSystem.bind("left", [vk_left, ord("A")]);
inputSystem.bind("left", gp_padl, INPUT_MODE_CONTROLLER);
inputSystem.bind("right", [vk_right, ord("D")]);
inputSystem.bind("right", gp_padr, INPUT_MODE_CONTROLLER);

inputSystem.bind("stickhorz", gp_axislh, INPUT_MODE_CONTROLLER_STICKTODIGITAL);
inputSystem.bind("stickvert", gp_axislv, INPUT_MODE_CONTROLLER_STICKTODIGITAL);

inputSystem.bind("shoot", [ord("Z"), ord("J")]);
inputSystem.bind("shoot", [gp_face3, gp_face1, gp_face2], INPUT_MODE_CONTROLLER);
inputSystem.bind("sneak", [vk_shift, ord("K")]);
inputSystem.bind("sneak", gp_face2, INPUT_MODE_CONTROLLER);
inputSystem.bind("sneak", gp_shoulderrb, INPUT_MODE_CONTROLLER_ANALOGBUTTONTODIGITAL);

func_grazeFlavorText = function(_text) {
	var _inst = instance_create_depth(x+16, y-16, depth, obj_flavorText)
	with _inst {
		_inst.accel_y = 0.1;
		_inst.x_vel = 0.3;
		_inst.y_vel = -1.3;
			
		_inst.life = 20;
			
		_inst.text = string(_text)
	}
}

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

		//var hkey = keyboard_check(vk_right) - keyboard_check(vk_left);
		//var vkey = keyboard_check(vk_down) - keyboard_check(vk_up);

		var spd = inputSystem.check("sneak") ? slowMoveSpeed : moveSpeed;
		var keydir = point_direction(0,0,hkey,vkey)
		if hkey == 0 && vkey == 0 {
			spd = 0
		}



		var _bulletHit = place_meeting(x, y, obj_bullet)
		if iFrames <= 0 && _bulletHit {
			global.pause = 8;
			iFrames = 20;
	
			instance_create_layer(x, y, layer, obj_bulletDestroyer).targetSize = WIDTH;
			var test = render.shockwave_create(x, y)
			test.mode = 1
			test.scaleTarget = WIDTH * 4
			test.scaleSpeed = 18
	
			livesLeft--
	
			grazeCombo = 0;
			func_grazeFlavorText("0")
			
			state.change("respawn")
		}



		var _grazeBulletHit = collision_circle(x, y, grazeRadius, obj_bullet, 0, 1) //instance_place(x, y, obj_bullet)
		if _grazeBulletHit && !_bulletHit {
	
			var _out = 0;
			for (var i = 0; i < array_length(grazeBulletList); i++) {
				if grazeBulletList[i][0] == _grazeBulletHit {
					_out = 1;
				}
			}
			if _out == 0 {
				array_push(grazeBulletList, [_grazeBulletHit, grazeBulletListClearTime])
				grazeCombo += 1;
				grazeComboTimer = tGrazeComboTimer;
		
				global.score += 100;
		
				grazeHitboxGraphicShow = 1;
		
				func_grazeFlavorText(string(grazeCombo))
			}
	
	
		}


		x += lengthdir_x(spd, keydir) * global.delta_multi;
		y += lengthdir_y(spd, keydir) * global.delta_multi;

		x = clamp(x, 0, WIDTH)
		y = clamp(y, 0, HEIGHT)


		bulletCharge = approach(bulletCharge, (vkey == -1 ? bulletChargeTarget : 0) * global.delta_multi, 
					(vkey == -1 ? bulletChargeSpeed : bulletChargeSpeedSlow) * global.delta_multi)
		var newReloadTime = max( ( tReloadTime - (sqrt(grazeCombo) / 4) ), 3) - bulletCharge

		if inputSystem.check("shoot") && reloadTime <= 0 && instance_number(obj_textbox) == 0 {
			reloadTime = newReloadTime
			var spreadTemp = inputSystem.check("sneak") ? bulletSpreadSlow : bulletSpread
			var spreadAngleTemp = inputSystem.check("sneak") ? bulletSpreadAngleSlow : bulletSpreadAngle
	
			for (var i = 0; i < bulletAmount; i+= 1) {
				var inormalize = i/bulletAmount;
				var dir = (90 + -spreadAngleTemp/2) - (-spreadAngleTemp/(bulletAmount-1) * i)
				var offset = spreadTemp * (bulletAmount - 1 - (i * 2))
		
				var _inst = instance_create_depth(x + offset, y, depth, obj_bullet_player)
		
				with _inst {
					_inst.x_vel = lengthdir_x(other.bulletSpeed, dir);
					_inst.y_vel = lengthdir_y(other.bulletSpeed, dir);
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

respawnAnim = new AnimCurve("back");



slowHitboxAnim = 0;
slowHitboxAnimSpeed = 0.3;

iFrames = 0;

