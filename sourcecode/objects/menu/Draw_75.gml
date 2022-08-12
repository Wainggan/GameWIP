var winWidth = window_get_width();
var winHeight = window_get_height();

for (var i = 0; i < array_length(menuList); i++) {
	
	if i = array_length(menuList)-1 {
		draw_set_color(c_black)
		draw_set_alpha(0.6)
			draw_rectangle(0, 0, winWidth, winHeight, 0)
		draw_set_alpha(1)
		draw_set_color(c_white)
	}
	
	draw_set_font(ft_ui)
	menuList[i].draw(64 + i * (128 + 64), 64)
	
}