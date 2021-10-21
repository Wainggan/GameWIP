if keyboard_check_pressed(vk_escape) {
	func_menuTest()
}

array_sort(menuList, function(inst1, inst2){
	return inst1.priority - inst2.priority
})

var deleteList = []
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
		
		if menuList[i].destroyMe {
			array_push(deleteList, i)
		}
	}
}
for (var i = array_length(menuList)-1; 0 <= i; i--) {
	var out = false
	for (var j = 0; j < array_length(deleteList); j++) {
		if deleteList[j] = i {
			out = true
		}
	}
	
	if out == true {
		array_delete(menuList, i, 1)
	}
}


if array_length(menuList) {
	global.pause = 2
}
