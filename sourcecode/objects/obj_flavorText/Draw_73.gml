draw_set_alpha(min(life / 10, 1))
draw_set_font(ft_ui)
draw_set_halign(fa_center)
	draw_text(round(x), round(y), text)
draw_set_halign(fa_left)
draw_set_font(ft_debug)
draw_set_alpha(1)