if global.gameActive && keyboard_check_pressed(vk_escape) {
	if array_length(menuList) == 0
		func_open(menu_pause);
	else
		func_close();
}
if keyboard_check_pressed(ord("X"))
	&& !(!global.gameActive && array_length(menuList) == 1)
	func_pop();

camX = lerp(camX, (array_length(menuList)-1) * 96, 0.4)

if array_length(menuList) {
	global.pause = 2;
	var _cM = menuList[array_length(menuList) - 1];
	_cM.scroll(keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up))
	_cM.change(keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left))
	if keyboard_check_pressed(ord("Z")) {
		_cM.click()
	}
}