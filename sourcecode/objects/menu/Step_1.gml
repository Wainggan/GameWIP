if global.gameActive && keyboard_check_pressed(vk_escape) {
	func_menuTest()
}

array_sort(menuList, function(inst1, inst2){
	return inst1.priority - inst2.priority
})

// creating a submenu places it at the end of the array
// if during the update loop there, a option creates a submenu, since check_pressed(SELECT) is still true, 
// it will activate the first option on the new menu
var inputFix = [
	keyboard_check_pressed(vk_down),
	keyboard_check_pressed(vk_up),
	keyboard_check_pressed(ord("Z")),
	keyboard_check_pressed(ord("X"))
]

var deleteList = []
for (var i = 0; i < array_length(menuList); i++) {
	if i == array_length(menuList)-1 {
		var input = -1;
		if inputFix[0] {
			input = MENUBUTTON.DOWN;
			inputFix[0] = 0;
		} else if inputFix[1] {
			input = MENUBUTTON.UP;
			inputFix[1] = 0;
		} else if inputFix[2] {
			input = MENUBUTTON.SELECT;
			inputFix[2] = 0;
		} else if inputFix[3] {
			input = MENUBUTTON.BACK;
			inputFix[3] = 0;
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
