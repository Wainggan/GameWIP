#macro DEFAULT_DRAW_LINE draw_line
#macro draw_line draw_line_sprite

#macro DEFAULT_DRAW_RECTANGLE draw_rectangle
#macro draw_rectangle draw_rectangle_sprite

log("idiot energy")

///@func draw_line_sprite(x1, y1, x2, y2, [width = 1], [color], [alpha])
function draw_line_sprite(_x1, _y1, _x2, _y2, _width = 1, _color = draw_get_color(), _alpha = draw_get_alpha()) {
	if(_width == 0) return;
	var _dir = point_direction(_x1, _y1, _x2, _y2),
	    _len = point_distance(_x1, _y1, _x2, _y2) / sprite_get_width(spr_pixel);

	draw_sprite_ext(spr_pixel, 0, 
	                _x1+lengthdir_x(_width/2,_dir+90), 
	                _y1+lengthdir_y(_width/2,_dir+90), 
	                _len, _width, _dir, _color, _alpha);
}

///@func draw_rectangle_sprite(x1, y1, x2, y2, [outline = false(>=1 for thick)], [color], [alpha])
function draw_rectangle_sprite(_x1, _y1, _x2, _y2, _outline = false, _color = draw_get_color(), _alpha = draw_get_alpha()) {
	if (_outline != 0) {
		draw_line_sprite(_x1, _y1, _x1, _y2, _outline, _color, _alpha)
		draw_line_sprite(_x1, _y2, _x2, _y2, _outline, _color, _alpha)
		draw_line_sprite(_x2, _y2, _x2, _y1, _outline, _color, _alpha)
		draw_line_sprite(_x2, _y1, _x1, _y1, _outline, _color, _alpha)
	} else {
		draw_sprite_stretched_ext(spr_pixel, 0, _x1, _y1, _x2 - _x1, _y2 - _y1, _color, _alpha)
	}
}

function draw_circle_sprite(_x, _y, _r, _outline = false, _color = draw_get_color(), _alpha = draw_get_alpha()) {
	if _outline {
		draw_sprite_ext(spr_circleoutline, 0, _x, _y, _r, _r, 0, _color, _alpha)
	}
}

function draw_outline(_x, _y, _func = function(_x, _y){}, _thickness = 1, _res = 9) {
	for (var i = 0; i < 1; i+= _res / 360) {
		_func(_x + lengthdir_x(_thickness, 360 * i), _y + lengthdir_y(_thickness, 360 * i))
	}
}

function draw_text_outline(_x, _y, _string) {
	var _e = draw_get_color();
	draw_set_color(c_black);
	draw_outline(_x, _y, method({s:_string}, function(_x, _y){
		draw_text(_x, _y, s);
	}))
	draw_set_color(_e);
	draw_text(_x, _y, _string);
}