var winWidth = window_get_width();
var winHeight = window_get_height();

for (var i = 0; i < array_length(menuList); i++) {
	
	if i = array_length(menuList)-1 {
		draw_set_color(c_black)
		draw_set_alpha(0.5)
			draw_rectangle(0, 0, winWidth, winHeight, 0)
		draw_set_alpha(1)
		draw_set_color(c_white)
	}

	menuList[i].func_drawOptions()
	
}