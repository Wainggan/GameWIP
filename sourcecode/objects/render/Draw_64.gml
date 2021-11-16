var winWidth = window_get_width();
var winHeight = window_get_height();

var gameSurfaceX = (winWidth/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16

// game ui

if global.gameActive {

	draw_rectangle(gameSurfaceX-1, gameSurfaceY-1, gameSurfaceX+WIDTH, gameSurfaceY+HEIGHT, 1)

	draw_set_halign(fa_right)
	
		draw_set_font(ft_ui)
			draw_text(gameSurfaceX - 8, gameSurfaceY + 2, "Score")
		draw_set_font(ft_score)
			draw_text(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 1, string(global.score))
		draw_set_font(ft_ui)
			draw_text_transformed(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 2.25, string(global.highscore), 0.75, 0.75, 0)
		
		draw_set_font(ft_debug)

	draw_set_halign(fa_left)


	with obj_enemy {
		var dist = 999;
		if y < 0 {
			dist = 0 - y;
		
			draw_sprite_ext(spr_warning, 0, gameSurfaceX+x, gameSurfaceY+0, 1, 1, 0, c_white, 1 - dist/96)
		} else {
			if x < 0 {
				dist = 0 - x;
				draw_sprite_ext(spr_warning, 0, gameSurfaceX+0, gameSurfaceY+y, 1, 1, 0, c_white, 1 - dist/96)
			}
			if x > WIDTH {
				dist = WIDTH - x;
				draw_sprite_ext(spr_warning, 0, gameSurfaceX+WIDTH, gameSurfaceY+y, 1, 1, 0, c_white, 1 - dist/96)
			}
		}
		
		if important > 0 {
			if 0 < x && x < WIDTH {
				draw_sprite(spr_enemyIndicator, 0, gameSurfaceX+x, gameSurfaceY+HEIGHT)
			}
		}
	}

} else {
	if array_length(menu.menuList) <= 1 {
		var _lb = global.file.save.leaderboard;
	
		for (var i = 0; i < array_length(_lb); i++) {
			draw_text(500, 64 + 32 * i*2, string(_lb[i].name))
			draw_text(500, 64 + 32 * i*2 + 24, string(_lb[i].score))
		}
	}
}