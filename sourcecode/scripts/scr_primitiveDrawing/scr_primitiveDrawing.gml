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

function draw_circle_outline_part(x, y, radius, thickness, percentage, startAngle, anticlockwise) {
	// How precise? (big number = smoother but takes longer to draw)
	static precision = 64;
	static interval = 360 / precision;
	
	anticlockwise = anticlockwise ? -1 : 1
	
	var color = draw_get_color();
	var alpha = draw_get_alpha();
	
	var hthick = thickness / 2;
    
	// trianglestrip gives us a solid, connected outline
	draw_primitive_begin(pr_trianglestrip);
    
	// repeat as much as the circle is filled
	for (var i = 0; i <= percentage * precision; i++) {
        
		// Find the angle from the center that the current vertices are at
		var angle = startAngle + interval * i * anticlockwise;
		var dir_x = dcos(angle);
		var dir_y = -dsin(angle);
        
		// Draw outer vertex
		draw_vertex_color(x + (radius + hthick) * dir_x, y + (radius + hthick) * dir_y, color, alpha);
        
		// Draw inner vertex
		draw_vertex_color(x + (radius - hthick) * dir_x, y + (radius - hthick) * dir_y, color, alpha);
	}
	draw_primitive_end();
}

function draw_circle_outline(x, y, radius, thickness) {
	draw_circle_outline_part(x, y, radius, thickness, 1, 0, false)
}

function draw_rectangle_cd() {
	/// draw_rectangle_cd(x1, y1, x2, y2, value, texture)
	var v, x1, y1, x2, y2, xm, ym, vd, vx, vy, vl;
	v = argument4
	if (v <= 0) return 0 // nothing to be drawn
	x1 = argument0; y1 = argument1; // top-left corner
	x2 = argument2; y2 = argument3; // bottom-right corner
	if (v >= 1) return draw_rectangle(x1, y1, x2, y2, false) // entirely filled
	xm = (x1 + x2) / 2; ym = (y1 + y2) / 2; // middle point
	draw_primitive_begin_texture(pr_trianglefan, argument5)
	draw_vertex_texture(xm, ym, 0.5, 0.5); draw_vertex_texture(xm, y1, 0.5, 0)
	// draw corners:
	if (v >= 0.125) draw_vertex_texture(x2, y1, 1, 0)
	if (v >= 0.375) draw_vertex_texture(x2, y2, 1, 1)
	if (v >= 0.625) draw_vertex_texture(x1, y2, 0, 1)
	if (v >= 0.875) draw_vertex_texture(x1, y1, 0, 0)
	// calculate angle & vector from value:
	vd = pi * (v * 2 - 0.5)
	vx = cos(vd)
	vy = sin(vd)
	// normalize the vector, so it hits -1\+1 at either side:
	vl = max(abs(vx), abs(vy))
	if (vl < 1) {
		vx /= vl
		vy /= vl
	}
	draw_vertex_texture(xm + vx * (x2 - x1) / 2, ym + vy * (y2 - y1) / 2, 0.5 + vx * 0.5, 0.5 + vy * 0.5)
	draw_primitive_end()
}