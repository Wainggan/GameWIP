if global.gameActive && keyboard_check_pressed(vk_escape) {
	func_open()
}

if array_length(menuList) {
	var _cM = menuList[array_length(menuList) - 1];
	_cM.scroll(keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up))
	_cM.change(keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left))
	if keyboard_check_pressed(ord("Z")) {
		_cM.click()
	}
}