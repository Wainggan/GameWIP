if delay > 0 exit

draw_set_font(ft_text)
var _y = HEIGHT - 100 * anim.evaluate();

gpu_set_blendmode_ext(bm_dest_colour, bm_zero)
draw_sprite_stretched(sprite_index, 0, x, _y, WIDTH, 100)
gpu_set_blendmode(bm_normal)

draw_sprite_stretched(sprite_index, 1, x, _y, WIDTH, 100)



var out = draw_parsedText(x+16, _y + 12, textParsed, 448, textProgress, lastTextProgress)
if out[$ "pause"] != undefined {
	textProgressPause = out[$ "pause"]
	textProgress += textSpeed
}
if out.finished {
	textProgress = string_length(text)
}
//draw_text_ext(32, 352, string_copy(text, 1, floor(textProgress)), -1, 448)


if textProgress >= string_length(text) {
	draw_sprite(sprite_index, 2, x + WIDTH * anim.evaluate()-52 + wave(-2, 1, 2), y+100-52)
}