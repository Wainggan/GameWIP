if global.gameActive && input.check_pressed("pause") {
	if array_length(menuList) == 0
		func_open(menu_pause);
	else
		func_close();
}
if input.check_pressed("bomb") && array_length(menuList) > 0
	&& !(!global.gameActive && array_length(menuList) == 1)
	func_pop();

camX = lerp(camX, (array_length(menuList)-1) * 96, 1 - power(1 - 0.9999999, global.delta_milli * 2))

if array_length(menuList) {
	global.pause = 2;
	var _cM = menuList[array_length(menuList) - 1];
	_cM.scroll(input.check_stutter("down", 12, 4) - input.check_stutter("up", 12, 4))
	_cM.change(input.check_stutter("right", 12, 3) - input.check_stutter("left", 12, 3))
	if input.check_pressed("shoot") {
		_cM.click()
	}
}