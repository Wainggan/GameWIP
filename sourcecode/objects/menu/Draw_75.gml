var winWidth = window_get_width();
var winHeight = window_get_height();

// TODO: fix

for (var i = 0; i < array_length(menuList); i++) {
	var _cM = menuList[i];
	
	draw_set_font(ft_ui)
	
	if i = array_length(menuList)-1 {
		draw_set_color(c_black)
		draw_set_alpha(0.6)
			draw_rectangle(0, 0, winWidth, winHeight, 0)
		draw_set_alpha(1)
		draw_set_color(c_white)
	}
	_cM.tooltip(winWidth - 200, -1, 204, winHeight+1, i = array_length(menuList)-1);
	
	_cM.camY = lerp(_cM.camY, 
		max(_cM.position * (string_height("M") + 8) - (winHeight / 2 - 128 + 32), 0)
		, 1 - power(1 - 0.99999, global.delta_milli * 2)
	);
	
	_cM.draw(64 + i * (128 + 64) - camX, 64 - _cM.camY);
}

