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

if iFrames <= 0 && place_meeting(x, y, obj_bullet) {
	global.pause = 8;
	iFrames = 20;
}


x += lengthdir_x(spd, keydir) * global.delta_multi;
y += lengthdir_y(spd, keydir) * global.delta_multi;

x = clamp(x, 0, WIDTH)
y = clamp(y, 0, HEIGHT)




if keyboard_check(ord("Z")) && reloadTime <= 0 {
	reloadTime = tReloadTime
	var spreadTemp = keyboard_check(vk_shift) ? bulletSpreadSlow : bulletSpread
	for (var i = 0; i < bulletAmount; i++) {
		var dir = (90 + spreadTemp/2) - (spreadTemp/(bulletAmount-1) * i)
		
		var _inst = instance_create_depth(x, y, depth, obj_bullet_player)
		with _inst {
			_inst.x_vel = lengthdir_x(8, dir);
			_inst.y_vel = lengthdir_y(8, dir);
		}
	}
	
}

iFrames -= global.delta_multi
reloadTime -= global.delta_multi