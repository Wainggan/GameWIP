function Menu() constructor {
	position = 0;
	elements = [];
	
	camY = 0;
	
	hoveringTime = 0;
	hoveringAnim = new Sod(5, 0.8, 1);
	hoveringTextAnim = new Sod(5, 1, 2);
	hoveringLastText = undefined;
	
	scroll = function(_direction, _wrap = true) {
		position += _direction;
		if _direction != 0
			hoveringTime = 0;
		if _wrap {
			position = position - floor(position / array_length(elements)) * array_length(elements);
		} else {
			position = clamp(position, 0, array_length(elements) - 1)
		}
	}
	change = function(_amount) {
		if _amount != 0 {
			elements[position].change(_amount);
			elements[position].onChange(elements[position].value);
		}
	}
	click = function() {
		elements[position].onClick();
	}
	
	add_button = function(_text, _onClick = function(){}, _tooltip) {
		array_push(elements, new MenuButton(_text, _onClick, _tooltip));
		return self;
	}
	add_slider = function(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onValueChange = function(){}, _tooltip) {
		array_push(elements, new MenuSlider(_text, _minimum, _maximum, _interval, _start, _width, _onValueChange, _tooltip));
		return self;
	}
	add_radio = function(_text = "", _options = [], _start = 0, _onValueChange = function(){}, _tooltip) {
		array_push(elements, new MenuRadio(_text, _options, _start, _onValueChange, _tooltip));
		return self;
	}
	
	draw = function(_x, _y, _padding = string_height("M") + 8) {
		var _lh = draw_get_halign()
		var _lv = draw_get_valign()
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		for (var i = 0; i < array_length(elements); i++) {
			elements[i].draw(_x, _y + _padding * i, i == position);
		}
		draw_set_halign(_lh);
		draw_set_valign(_lv);
    }
	tooltip = function(_x, _y, _width, _height, _active) {
		hoveringAnim.update(global.delta_milli, (hoveringTime >= 20 && _active && elements[position].tooltip != undefined) * _height);
		hoveringTextAnim.update(global.delta_milli, hoveringTime >= 20 && _active);;
		if !_active {
			hoveringTime = 0;
			return;
		}
		hoveringTime += global.delta_milli * 60;
		if hoveringLastText == undefined && elements[position].tooltip != undefined hoveringLastText = elements[position].tooltip;
		if hoveringAnim.value >= 1 && hoveringLastText != undefined {
			draw_set_color(c_black);
			draw_set_alpha(0.6);
			draw_roundrect_ext(_x, _y, _x + _width, _y + hoveringAnim.value, 4, 4, false);
			draw_set_alpha(1);
			draw_set_color(c_white);
			draw_roundrect_ext(_x, _y, _x + _width, _y + hoveringAnim.value, 4, 4, true);
			
			draw_set_alpha(hoveringTextAnim.value)
			draw_text_ext(_x + 10, _y + 8, hoveringLastText, -1, _width - 24)
			draw_set_alpha(1)
		} else {
			hoveringLastText = undefined;
		}
	}
}

function MenuElement(_onClick = function(){}, _onChange = function(){}, _tooltip = undefined) constructor {
	onClick = _onClick;
	
	value = 0;
	tooltip = _tooltip;
	change = function(){}
	onChange = _onChange
	draw = function(){}
}

function MenuButton(_text = "", _onClick, _tooltip) : MenuElement(_onClick, , _tooltip) constructor {
	text = _text;
	
	anim = new Sod(2, 0.5, 0.5);
	
	draw = function(_x, _y, _selected) {
		anim.update(global.delta_milli, _selected);
		draw_set_color(_selected ? #fc7484 : c_white)
		draw_text_outline(_x + anim.value * 16, _y, text)
	}
}

function MenuSlider(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onChange = function(){}, _tooltip) : MenuElement(undefined, _onChange, _tooltip) constructor {
	text = _text + " : ";
	
	minimum = _minimum;
	maximum = _maximum;
	interval = _interval;
	
	value = _start;
	
	animMove = new Sod(3, 0.8, 2).setValue((value - minimum) / (maximum - minimum));
	animActive = new Sod(2, 0.8, 1);
	width = 120;
	
	change = function(_amount) {
		value = clamp(value + _amount * interval, minimum, maximum);
	}
	onChange = _onChange;
	
	draw = function(_x, _y, _selected) {
		static padding = 16;
		animActive.update(global.delta_milli, _selected)
		
		draw_set_color(_selected ? #fc7484 : c_white);
		draw_text_outline(_x, _y, text);
		
		_x += string_width(text) + padding;
		
		draw_roundrect_ext(_x, _y - 4, _x + width, _y + 4, 2, 2, false)
		draw_set_color(c_black);
		draw_roundrect_ext(_x, _y - 4, _x + width, _y + 4, 2, 2, true)
		
		draw_set_color(_selected ? #fc7484 : c_white);
		draw_text_outline(_x + width + padding + animActive.value * 16, _y, value)
		
		//draw_line(_x, _y, _x + width, _y);
		
		animMove.update(global.delta_milli, (value - minimum) / (maximum - minimum));
		var pos = lerp(_x, _x + width, animMove.value);
		
		//draw_line(pos, _y - 10, pos, _y + 10);
		draw_set_color(_selected ? c_white : c_black);
		draw_roundrect_ext(pos - 4, _y - 8, pos + 4, _y + 8, 1, 1, false)
		draw_set_color(c_white);
		draw_roundrect_ext(pos - 4, _y - 8, pos + 4, _y + 8, 1, 1, true)
		
	}
}

function MenuRadio(_text = "", _options = [], _start = 0, _onChange, _tooltip) : MenuElement(undefined, _onChange, _tooltip) constructor {
	text = _text + " : ";
	options = _options;
	value = _start;
	
	anim = new Sod(3, 0.56, 1);
	
	change = function(_amount) {
		value = clamp(value + _amount, 0, array_length(options) - 1);
	}
	onChange = _onChange;
	
	draw = function(_x, _y, _selected) {
		static padding = 24;
		
		draw_set_color(_selected ? #fc7484 : c_white);
		draw_text_outline(_x, _y, text);
		
		_x += string_width(text) + padding;
		
		for (var i = 0; i < array_length(options); i++) {
			var str = options[i];
			draw_set_color(_selected ? #fc7484 : c_white);
			draw_text_outline(_x, _y, str);
			
			if (i == value) {
				anim.update(global.delta_milli, _x - 20 + _selected * 4);
				draw_set_color(c_white);
				draw_text_outline(anim.value, _y, ">");
			}
			
			_x += string_width(str) + padding;
		}
	}
}