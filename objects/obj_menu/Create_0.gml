menuOptions = [];

selectedOption = 0;
priority = 0;

func_addOption = function(_name, _func) {
	array_push(menuOptions, [_name, _func])
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
		instance_destroy()
	}
}



