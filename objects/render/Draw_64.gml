var winWidth = window_get_width();
var winHeight = window_get_height();

var gameSurfaceX = (winWidth/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16

draw_rectangle(gameSurfaceX-1, gameSurfaceY-1, gameSurfaceX+WIDTH, gameSurfaceY+HEIGHT, 1)

draw_set_halign(fa_right)
	
	draw_set_font(ft_ui)
		draw_text(gameSurfaceX - 8, gameSurfaceY + 2, "Score")
	draw_set_font(ft_score)
		draw_text(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 1, "69420")
	draw_set_font(ft_ui)
		draw_text_transformed(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 2.25, "99999999", 0.75, 0.75, 0)
		
	draw_set_font(ft_debug)

draw_set_halign(fa_left)