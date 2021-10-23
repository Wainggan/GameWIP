func_inputUpdate(keyboard_check(vk_left),
				keyboard_check(vk_right),
				keyboard_check(vk_up),
				keyboard_check(vk_down))

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

var spd = keyboard_check(vk_shift) ? slowMoveSpeed : moveSpeed;
var keydir = point_direction(0,0,hkey,vkey)
if hkey == 0 && vkey == 0 {
	spd = 0
}



var _bulletHit = place_meeting(x, y, obj_bullet)
if iFrames <= 0 && _bulletHit {
	global.pause = 8;
	iFrames = 20;
	
	grazeCombo = 0;
	func_grazeFlavorText("0")
}



var _grazeBulletHit = instance_place(x, y, obj_bullet)
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
		
		grazeHitboxGraphicShow = 1;
		
		func_grazeFlavorText(string(grazeCombo))
	}
	
	
}


x += lengthdir_x(spd, keydir) * global.delta_multi;
y += lengthdir_y(spd, keydir) * global.delta_multi;

x = clamp(x, 0, WIDTH)
y = clamp(y, 0, HEIGHT)


bulletCharge = approach(bulletCharge, vkey == -1 ? bulletChargeTarget : 0, 
			vkey == -1 ? bulletChargeSpeed : bulletChargeSpeedSlow)
var newReloadTime = max( ( tReloadTime - (sqrt(grazeCombo) / 4) ) - bulletCharge, 3)

if keyboard_check(ord("Z")) && reloadTime <= 0 {
	reloadTime = newReloadTime
	var spreadTemp = keyboard_check(vk_shift) ? bulletSpreadSlow : bulletSpread
	for (var i = 0; i < bulletAmount; i++) {
		var dir = (90 + spreadTemp/2) - (spreadTemp/(bulletAmount-1) * i)
		
		var _inst = instance_create_depth(x, y, depth, obj_bullet_player)
		with _inst {
			_inst.x_vel = lengthdir_x(other.bulletSpeed, dir);
			_inst.y_vel = lengthdir_y(other.bulletSpeed, dir);
		}
	}
	
}

iFrames -= global.delta_multi
reloadTime -= global.delta_multi
grazeComboTimer -= global.delta_multi
if grazeComboTimer <= 0 {
	grazeCombo = 0;
}

for (var i = 0; i < array_length(grazeBulletList); i++) {
	grazeBulletList[i][1] -= global.delta_multi;
	if grazeBulletList[i][1] <= 0 {
		array_delete(grazeBulletList, i, 1);
		i--
	}
}

grazeHitboxGraphicShow = max(grazeHitboxGraphicShow-grazeHitboxGraphicShowSpeed * global.delta_multi, 0)