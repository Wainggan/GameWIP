
enum CB {
	Upper = 240,
	MidUp = 210,
	Mid = 90,
	Low = 10
}

#macro cb_red make_color_rgb(CB.Upper, CB.Low, CB.Mid)
#macro cb_rust make_color_rgb(CB.Upper, CB.Mid, CB.Low)

#macro cb_blue make_color_rgb(CB.Low, CB.Mid, CB.Upper)
#macro cb_indigo make_color_rgb(CB.Mid, CB.Low, CB.Upper)

#macro cb_green make_color_rgb(CB.Low, CB.Upper, CB.Mid)
#macro cb_lime make_color_rgb(CB.Mid, CB.Upper, CB.Low)

#macro cb_yellow make_color_rgb(CB.Upper, CB.MidUp, CB.Mid)
#macro cb_pink make_color_rgb(CB.MidUp, CB.Mid, CB.Upper)
#macro cb_teal make_color_rgb(CB.Mid, CB.Upper, CB.MidUp)

#macro cb_black make_color_rgb(CB.Low, CB.Low, CB.Low)
#macro cb_grey make_color_rgb(CB.Mid, CB.Mid, CB.Mid)
#macro cb_white make_color_rgb(CB.Upper, CB.Upper, CB.Upper)
