menuList = []

enum MENUBUTTON {
	UP,
	DOWN,
	SELECT,
	BACK
}

ui_Menu = function() constructor {
	menuOptions = [];
	
	parent = noone

	selectedOption = 0;
	priority = 0;
	destroyMe = false;
	
	x = 96;
	y = 64;

	func_addOption = function(_name, _func) {
		array_push(menuOptions, [_name, _func])
	}
	func_addSubmenu = function(_submenu) {
		_submenu.priority = priority + 1;
		_submenu.parent = parent;
		_submenu.x = x + 224
		_submenu.y = y + 8
		array_push(parent.menuList, _submenu);
	}
	
	func_drawOptions = function(){
		draw_set_font(ft_ui);
		for (var i = 0; i < array_length(menuOptions); i++) {
			draw_set_color(selectedOption == i ? c_red : c_white)
				draw_text(x, y + i * 24, menuOptions[i][0])
		
		}
		draw_set_font(ft_debug);
		draw_set_color(c_white)
	}

	func_update = function(_input) {
		if _input == MENUBUTTON.UP {
			selectedOption = wrap(selectedOption-1, 0, array_length(menuOptions))
		}
		if _input == MENUBUTTON.DOWN {
			selectedOption = wrap(selectedOption+1, 0, array_length(menuOptions))
		}
		if _input == MENUBUTTON.SELECT {
			if menuOptions[selectedOption][1] != -1 {
				menuOptions[selectedOption][1]()
			}
		}
		if _input == MENUBUTTON.BACK {
			destroyMe = true;
		}
	}
}

func_addSubmenu = function(_submenu) {
	_submenu.parent = id;
	array_push(menuList, _submenu);
}



func_menuTest = function(){
	if !array_length(menuList) {
		var _menu = new ui_Menu()
		with _menu {
			
			func_addOption("test", -1)
			func_addOption("test", -1)
			
			func_addOption("submenu", function(){
				
				var _menu = new parent.ui_Menu()
				with _menu {
					
					func_addOption("test", -1)
					
					func_addOption("submenu", function(){
						
						var _menu = new parent.ui_Menu()
						with _menu {
							func_addOption("test", -1)
						}
						func_addSubmenu(_menu)
						
					})
					
					func_addOption("test", -1)
					func_addOption("test", -1)
					func_addOption("test", -1)
					
				}
				func_addSubmenu(_menu)
				
			})
			
		}
		func_addSubmenu(_menu)
	} else {
		menuList = [];
	}
}