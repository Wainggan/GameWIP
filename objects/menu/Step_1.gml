if keyboard_check_pressed(vk_escape) {
	func_menuTest()
}

var updateList = []
with obj_menu {
	array_push(updateList, id)
}
menuList = updateList;
array_sort(menuList, function(inst1, inst2){
	return inst1.priority - inst2.priority
})


for (var i = 0; i < array_length(menuList); i++) {
	if i == array_length(menuList)-1 {
		var input = -1;
		if keyboard_check_pressed(vk_down) {
			input = MENUBUTTON.DOWN
		} else if keyboard_check_pressed(vk_up) {
			input = MENUBUTTON.UP
		} else if keyboard_check_pressed(ord("Z")) {
			input = MENUBUTTON.SELECT
		} else if keyboard_check_pressed(ord("X")) {
			input = MENUBUTTON.BACK
		}
		
		menuList[i].func_update(input);
	}
}
if array_length(menuList) {
	global.pause = 2
}
