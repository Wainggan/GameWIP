var hkey = keyboard_check(vk_right) - keyboard_check(vk_left);
var vkey = keyboard_check(vk_down) - keyboard_check(vk_up);

var spd = keyboard_check(vk_shift) ? slowMoveSpeed : moveSpeed;
var keydir = point_direction(0,0,hkey,vkey)
if hkey == 0 && vkey == 0 {
	spd = 0
}


x += lengthdir_x(spd, keydir) * global.delta_multi;
y += lengthdir_y(spd, keydir) * global.delta_multi;