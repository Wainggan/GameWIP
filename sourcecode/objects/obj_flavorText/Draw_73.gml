exit

draw_set_alpha(min(life / 10, 0.7))
draw_set_color(#aaaaaa)
draw_set_font(ft_combo)
draw_set_halign(fa_center)
	draw_text_transformed(round(x), round(y), text, scale, scale, 0)
draw_set_halign(fa_left)
draw_set_font(ft_debug)
draw_set_alpha(1)
draw_set_color(c_white)

