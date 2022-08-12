function Menu() constructor {
	position = 0;
	elements = [];
	
	scroll = function(_direction, _wrap = true) {
		position += _direction;
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
	
	add_button = function(_text, _onClick = function(){}) {
		array_push(elements, new MenuButton(_text, _onClick));
		return self;
	}
	add_slider = function(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onValueChange = function(){}) {
		array_push(elements, new MenuSlider(_text, _minimum, _maximum, _interval, _start, _width, _onValueChange));
		return self;
	}
	add_radio = function(_text = "", _options = [], _start = 0, _onValueChange = function(){}) {
		array_push(elements, new MenuRadio(_text, _options, _start, _onValueChange));
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
}

function MenuElement(_onClick = function(){}, _onChange = function(){}) constructor {
	onClick = _onClick;
	
	value = 0;
	change = function(){}
	onChange = _onChange
	draw = function(){}
}

function MenuButton(_text = "", _onClick) : MenuElement(_onClick) constructor {
	text = _text;
	
	draw = function(_x, _y, _selected) {
		draw_set_color(_selected ? #fc7484 : c_white)
		draw_text_outline(_x, _y, text)
	}
}

function MenuSlider(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onChange = function(){}) : MenuElement(undefined, _onChange) constructor {
	text = _text + ":";
	
	minimum = _minimum;
	maximum = _maximum;
	interval = _interval;
	
	value = _start;
	
	width = 120;
	
	change = function(_amount) {
		value = clamp(value + _amount * interval, minimum, maximum);
	}
	onChange = _onChange;
	
	draw = function(_x, _y, _selected) {
		static padding = 10;
		
		draw_set_color(_selected ? #fc7484 : c_white);
		draw_text_outline(_x, _y, text);
		
		_x += string_width(text) + padding;
		
		draw_set_color(c_black);
		draw_roundrect(_x, _y - 4, _x + width, _y + 4, false)
		draw_set_color(c_white);
		draw_roundrect(_x, _y - 4, _x + width, _y + 4, true)
		
		draw_text_outline(_x + width + 14, _y, value)
		
		//draw_line(_x, _y, _x + width, _y);
		
		var pos = lerp(_x, _x + width, (value - minimum) / (maximum - minimum));
		//draw_line(pos, _y - 10, pos, _y + 10);
		draw_set_color(c_black);
		draw_roundrect(pos - 4, _y - 8, pos + 4, _y + 8, false)
		draw_set_color(c_white);
		draw_roundrect(pos - 4, _y - 8, pos + 4, _y + 8, true)
		
	}
}

function MenuRadio(_text = "", _options = [], _start = 0, _onChange) : MenuElement(undefined, _onChange) constructor {
	text = _text + ":";
	options = _options;
	value = _start;
	
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
			draw_text_outline(_x, _y, str);
			
			if (i == value) draw_text_outline(_x - 10, _y, ">");
			
			_x += string_width(str) + padding;
		}
	}
}