if delay > 0 exit

draw_set_font(ft_text)
draw_sprite_stretched(sprite_index, 0, x, y, 480 * anim.evaluate(), 104)

var out = draw_parsedText(32, 352, textParsed, 448, textProgress, lastTextProgress)
if out[$ "pause"] != undefined {
	textProgressPause = out[$ "pause"]
	textProgress += textSpeed
}
if out.finished {
	textProgress = string_length(text)
}
//draw_text_ext(32, 352, string_copy(text, 1, floor(textProgress)), -1, 448)


if textProgress >= string_length(text) {
	draw_sprite(sprite_index, 1, x+480 * anim.evaluate()-48 + wave(-2, 1, 2), y+104-48)
}