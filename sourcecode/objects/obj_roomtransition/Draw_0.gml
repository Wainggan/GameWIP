draw_sprite_stretched_ext(spr_pixel, 0, 0, hasSwitched ? HEIGHT * (1 - animCurve.evaluate()) : 0, WIDTH, !hasSwitched ? HEIGHT * animCurve.evaluate() : HEIGHT, c_black, 1);

var _x = 128;
var _y = 128;

draw_set_alpha(scoreAnimCurve.evaluate())

draw_set_font(ft_score)
draw_set_valign(fa_top)
draw_text(_x, _y, "Stage Complete")

draw_set_font(ft_ui)
for (var i = 0; i < array_length(scoreAnim); i++) {
	draw_set_halign(fa_right);
	draw_text_ext_transformed((_x - 4) * (1 - scoreAnim[i].animCurve.evaluate()), _y + 2 + 32 + i * 16, scoreAnim[i].text(), -1, -1, 0.75, 0.75, 0);
	draw_set_halign(fa_left);
	draw_text(_x, _y + 32 + i * 16 - scoreAnim[i].animCurve.evaluate() * 16, scoreAnim[i].show());
}

draw_set_alpha(1);