var winWidth = window_get_width();
var winHeight = window_get_height();

var gameSurfaceX = x;
var gameSurfaceY = y;

// game ui

if global.gameActive {
	
	draw_set_color(c_white)

	draw_rectangle(gameSurfaceX-1, gameSurfaceY-1, gameSurfaceX+WIDTH + 2, gameSurfaceY+HEIGHT + 2, 1)

	draw_set_halign(fa_right)
	
		draw_set_font(ft_ui)
			draw_text(gameSurfaceX - 8, gameSurfaceY + 2, "Score")
		draw_set_font(ft_score)
			draw_text(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 1, string(round(scoreAnim)))//string(global.score))
		draw_set_font(ft_ui)
			draw_text_transformed(gameSurfaceX - 8, gameSurfaceY + 2 + 24 * 2.25, string(global.highscore), 0.75, 0.75, 0)
		
		draw_set_font(ft_debug)

	draw_set_halign(fa_left)
	
	if (instance_exists(obj_player)) {
		for (var i = 0; i < obj_player.livesLeft; i++) {
			draw_sprite(spr_playericon, 0, gameSurfaceX-24, gameSurfaceY + HEIGHT - i*18 - 18)
		}
	}


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
				dist = x - WIDTH;
				draw_sprite_ext(spr_warning, 0, gameSurfaceX+WIDTH, gameSurfaceY+y, 1, 1, 0, c_white, 1 - dist/96)
			}
		}
		var xP = importantAnim.value;
		if important == 1 {
			
			if 0 < xP && xP < WIDTH {
				if instance_exists(obj_player) {
					draw_line(gameSurfaceX+obj_player.x, gameSurfaceY+HEIGHT + 16, gameSurfaceX+xP, gameSurfaceY+HEIGHT + 16)
				}
				
				var _timeVal = 0;
				if timer != -1 {
					_timeVal = timer/ftime;
					if timerMod != undefined {
						_timeVal = timer/timerMod[array_length(timerMod) - 1];
					} else {
						_timeVal = timer/ftime;
					}
				}
				
				
				draw_sprite_ext(spr_enemyIndicatorBack, 0, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, 1, 1, 0, c_white, 1);
				if _timeVal != 0
				draw_sprite_ext(spr_enemyIndicator, 1, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, _timeVal, _timeVal, 0, c_white, 1);
				
				draw_sprite_ext(spr_enemyIndicator, 0, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, 1-hp/maxhp, 1-hp / maxhp, 0, c_white, 1);
				if _timeVal != 0
				draw_sprite_ext(spr_enemyIndicator, 0, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, min(_timeVal, 1-hp/maxhp), min(_timeVal, 1-hp / maxhp), 0, merge_color(c_black, c_fuchsia, 0.2), 0.7);
			}
		} else if important == 2 {
			if 0 < xP && xP < WIDTH {
				draw_sprite_ext(spr_importantIndicator, 0, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, 1, 1, 0, c_white, 1)
				draw_sprite_ext(spr_importantIndicator, 0, round(gameSurfaceX+xP), gameSurfaceY+HEIGHT + 16, 1-hp/maxhp, 1-hp / maxhp, 0, merge_color(c_black, c_fuchsia, 0.2), 0.7)
			}
		}
	}
	with obj_player
		draw_sprite_ext(spr_playerTargetIcon, 0, round(gameSurfaceX+hook_icon_xAnim.value), gameSurfaceY + HEIGHT + 16, hook_icon_showAnim.value, hook_icon_showAnim.value, hook_icon_rotate, c_white, 1);

} else {
	
	
	if array_length(menu.menuList) <= 1 {
		var _lb = global.file.save.leaderboard;
		draw_set_font(ft_ui)
		for (var i = 0; i < array_length(_lb); i++) {
			draw_set_alpha(0.1)
			draw_set_color(c_black)
				draw_text_outline(500, 48 + 32 * i*2, string(_lb[i].name))
			draw_set_alpha(1)
			draw_set_color(c_white)
				draw_text(500, 48 + 32 * i*2, string(_lb[i].name))
				
			draw_set_alpha(0.1)
			draw_set_color(c_black)
				draw_text_outline(500, 48 + 32 * i*2 + 24, string(_lb[i].score))
				draw_set_alpha(1)
			draw_set_color(c_white)
				draw_text(500, 48 + 32 * i*2 + 24, string(_lb[i].score))
		}
	}
	
	
}

draw_set_halign(fa_right);

draw_set_font(ft_ui)
draw_set_color(c_grey)
var i = 0;
draw_text(winWidth - 8, winHeight - 32 - 24 * i++, "FPS: " + string(fps))
draw_text(winWidth - 8, winHeight - 32 - 24 * i++, "Count: " + string(instance_number(obj_bullet)))
with obj_enemy {
	if bossFlag {
		draw_text(winWidth - 8, winHeight - 32 - 24 * i++, "---");
		draw_text(winWidth - 8, winHeight - 32 - 24 * i++, $"HP: {hp}");
		draw_text(winWidth - 8, winHeight - 32 - 24 * i++, $"phase timer: {phaseTimer}");
		draw_text(winWidth - 8, winHeight - 32 - 24 * i++, $"phase stimer: {phaseStartTimer}");
		draw_text(winWidth - 8, winHeight - 32 - 24 * i++, $"target time: {phases[currentPhase].time}");
	}
}
draw_set_color(c_white)

draw_set_halign(fa_left);
