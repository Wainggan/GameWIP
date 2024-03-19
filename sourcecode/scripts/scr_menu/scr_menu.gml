
function PageController() constructor {
	
	current = undefined;
	__steps = undefined
	
	static steps = function(_steps) {
		__steps = _steps;
		next();
	}
	static next = function(_page){
		if _page == undefined _page = __steps.run()
		current = _page;
		_page.controller = self;
	}
	static back = function(){
		if current == undefined {
			throw "no page loaded";
		}
		if current.__previous == undefined return;
		current = current.__previous;
	}
	
	static get_active = function(){
		return current;
	}
	static close = function(){
		current = undefined;
	}
	
	static step = function(){
		if current current.step();
	}
	
	static draw = function(){
		if current current.draw(0, 0);
	}
	
}



function Page() constructor {
	
	__previous = undefined;
	__next = undefined;
	
	// assigned by controller
	controller = noone;
	
	static previous = function(_page = undefined) {
		__previous = _page;
		return self;
	}
	static next = function(_page = undefined) {
		__next = _page;
		return self;
	}
	static get_next = function(){ return __next; }
	
	static step = function(){}
	static draw = function(){}
	
}

function Page_Menu() : Page() constructor {
	
	position = 0;
	elements = [];
	
	camY = 0;
	
	static scroll = function(_direction, _wrap = true) {
		position += _direction;
		if _wrap {
			position = position - floor(position / array_length(elements)) * array_length(elements);
		} else {
			position = clamp(position, 0, array_length(elements) - 1);
		}
	}
	static change = function(_amount) {
		if _amount != 0 {
			elements[position].change(_amount);
			elements[position].onChange(elements[position].value);
		}
	}
	static click = function() {
		elements[position].onClick();
	}
	
	static add_button = function(_text, _onClick = function(){}, _tooltip) {
		array_push(elements, new MenuButton(_text, _onClick, _tooltip));
		return self;
	}
	static add_slider = function(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onValueChange = function(){}, _tooltip) {
		array_push(elements, new MenuSlider(_text, _minimum, _maximum, _interval, _start, _width, _onValueChange, _tooltip));
		return self;
	}
	static add_radio = function(_text = "", _options = [], _start = 0, _onValueChange = function(){}, _tooltip) {
		array_push(elements, new MenuRadio(_text, _options, _start, _onValueChange, _tooltip));
		return self;
	}
	
	static step = function(){
		//if global.gameActive && input.check_pressed("pause") {
		//	if array_length(menuList) == 0
		//		func_open(menu_pause);
		//	else
		//		func_close();
		//}
		if input.check_pressed("bomb") {
			controller.next()
		}

		game_pause(2, true);
		scroll(input.check_stutter("down", 12, 4) - input.check_stutter("up", 12, 4))
		change(input.check_stutter("right", 12, 3) - input.check_stutter("left", 12, 3))
		if input.check_pressed("shoot") {
			click()
		}
	}
	
	static draw = function(_x, _y, _padding = string_height("M") + 8) {
		
		var _winHeight = window_get_height();
		camY = lerp(camY, 
			max(position * (string_height("M") + 8) - (_winHeight / 2 - 128 + 32), 0)
			, 1 - power(1 - 0.99999, global.delta_milli * 2)
		);
		
		_x += 64
		_y += 64 - camY
		var _lh = draw_get_halign();
		var _lv = draw_get_valign();
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		for (var i = 0; i < array_length(elements); i++) {
			elements[i].draw(_x, _y + _padding * i, i == position);
		}
		draw_set_halign(_lh);
		draw_set_valign(_lv);
    }
	
}


function Page_Keyboard() : Page() constructor {
	
	name = ""
	
	location = 0;
	anim_pos_x = new Sod(5, 0.6, 0.5);
	anim_pos_y = new Sod(5, 0.6, 0.5);
	
	static _x_ = undefined;
	
	keys = [
		["a", "b", "c", "d", "e", "f", "g", "7", "8", "9"], 
		["h", "i", "j", "k", "l", "m", "n", "4", "5", "6"], 
		["o", "p", "q", "r", "s", "t", "u", "1", "2", "3"], 
		["v", "w", "x", "y", "z", _x_, ":", " ", "0", _x_],
		["!", "?", "@", _x_, _x_, _x_, _x_, ".", "-", "+"],
	];
	key_pos_x = 0;
	key_pos_y = 0;
	
	buttons = ["accept", "delete", "shift"]
	button_pos = 0;
	button_shift = false;
	
	mode = 0;
	
	
	static step = function(){
		
		var _kx = input.check_pressed("right") - input.check_pressed("left");
		var _ky = input.check_pressed("down") - input.check_pressed("up")
		
		if mode == 0 {
		
			var _sX = key_pos_x, _sY = key_pos_y;
			
			var _stop = 12
			while _stop-- > 0 {
				key_pos_y += _kx;
				key_pos_x += _ky;
			
				if key_pos_x > array_length(keys) - 1 || key_pos_x < 0 {
					mode = 1
					key_pos_x = _sX;
					key_pos_y = _sY;
					break;
				}
		
				key_pos_x = wrap(key_pos_x, 0, array_length(keys));
				key_pos_y = wrap(key_pos_y, 0, array_length(keys[0]));
			
				if keys[key_pos_x][key_pos_y] != _x_ {
					break;
				}
			}
	
			if input.check_pressed("shoot") {
				if string_length(name) < 12 {
					var _str = keys[key_pos_x][key_pos_y];
					if button_shift _str = string_upper(_str)
					name += _str
				}
			}
			
		} else {
			
			if _ky < 0 {
				mode = 0;
			} else if _ky > 0 {
				mode = 0
			} else if _kx != 0 {
				button_pos += _kx;
				button_pos = wrap(button_pos, 0, array_length(buttons))
			}
			
			if input.check_pressed("shoot") {
				switch buttons[button_pos] {
					case "accept": {
						global.enteredName = name;
						controller.next()
						break;
					}
					case "delete": {
						name = string_delete(name, string_length(name), 1);
						break;
					}
					case "shift": {
						button_shift = !button_shift;
						break;
					}
				}
			}
			
		}

	}
	
	static draw = function(){
		
		draw_set_font(ft_ui);
		
		draw_text(20, 20, "enter name!!")
		
		for (var _x = 0; _x < array_length(keys); _x++) {
			for (var _y = 0; _y < array_length(keys[_x]); _y++) {
				if !is_string(keys[_x, _y]) continue;
				var _pX = 90 + _y * 48;
				var _pY = 90 + _x * 32;
				//draw_rectangle_sprite(_pX - 4, _pY - 4, _pX + 24, _pY + 24, true);
				var _str = keys[_x][_y];
				if button_shift _str = string_upper(_str)
				draw_text(_pX, _pY, _str);
			}
		}
		
		for (var i = 0; i < array_length(buttons); i++) {
			draw_text(90 + i * 128, 90 + array_length(keys) * 32 + 16, buttons[i]);
		}
		
		var _tPx = 0, _tPy = 0;
		
		if mode == 0 {
			_tPx = 90 + key_pos_y * 48 - 16;
			_tPy = 90 + key_pos_x * 32;
		} else {
			_tPx = 90 + button_pos * 128 - 16
			_tPy = 90 + array_length(keys) * 32 + 16;
		}
		
		anim_pos_x.update(global.delta_milli, _tPx)
		anim_pos_y.update(global.delta_milli, _tPy)
		
		draw_text(anim_pos_x.value, anim_pos_y.value, ">")
		
		draw_set_font(ft_score)
		
		draw_text(90, 90 + array_length(keys) * 32 + 48, "name: " + name);
		
		draw_set_font(ft_debug)
		
	}
	
}

function Page_Leaderboard() : Page() constructor {
	
	static step = function(){
		
		if input.check_pressed("bomb") {
			controller.next()
		}
		
	}
	
	static draw = function(){
		
		var _lb = global.file.save.leaderboard;
		draw_set_font(ft_ui)
		for (var i = 0; i < array_length(_lb); i++) {
			draw_set_alpha(0.1)
			draw_set_color(c_black)
				draw_text(500, 48 + 32 * i*2, string(_lb[i].name))
				//draw_text_outline(500, 48 + 32 * i*2, string(_lb[i].name))
			draw_set_alpha(1)
			draw_set_color(c_white)
				draw_text(500, 48 + 32 * i*2, string(_lb[i].name))
				
			draw_set_alpha(0.1)
			draw_set_color(c_black)
				draw_text(500, 48 + 32 * i*2 + 24, string(_lb[i].score))
				//draw_text_outline(500, 48 + 32 * i*2 + 24, string(_lb[i].score))
				draw_set_alpha(1)
			draw_set_color(c_white)
				draw_text(500, 48 + 32 * i*2 + 24, string(_lb[i].score))
		}
		
	}
	
	
}



function Menu() constructor {
	position = 0;
	elements = [];
	
	camY = 0;
	
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
	
	anim = new Sod(2, 0.5, 0.5);
	
	draw = function(_x, _y, _selected) {
		anim.update(global.delta_milli, _selected);
		draw_set_color(_selected ? #fc7484 : c_white)
		draw_text(_x + anim.value * 16, _y, text)
		//draw_text_outline(_x + anim.value * 16, _y, text)
	}
}

function MenuSlider(_text = "", _minimum = 0, _maximum = 10, _interval = 1, _start = _minimum, _width = 100, _onChange = function(){}) : MenuElement(undefined, _onChange) constructor {
	text = _text + " : ";
	
	minimum = _minimum;
	maximum = _maximum;
	interval = _interval;
	
	value = _start;
	
	animMove = new Sod(3, 1, 2).setValue((value - minimum) / (maximum - minimum));
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
		draw_text(_x, _y, text);
		//draw_text_outline(_x, _y, text);
		
		_x += string_width(text) + padding;
		
		draw_roundrect_ext(_x, _y - 4, _x + width, _y + 4, 2, 2, false)
		draw_set_color(c_black);
		draw_roundrect_ext(_x, _y - 4, _x + width, _y + 4, 2, 2, true)
		
		draw_set_color(_selected ? #fc7484 : c_white);
		draw_text(_x + width + padding + animActive.value * 16, _y, value)
		//draw_text_outline(_x + width + padding + animActive.value * 16, _y, value)
		
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

function MenuRadio(_text = "", _options = [], _start = 0, _onChange) : MenuElement(undefined, _onChange) constructor {
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
		draw_text(_x, _y, text);
		//draw_text_outline(_x, _y, text);
		
		_x += string_width(text) + padding;
		
		for (var i = 0; i < array_length(options); i++) {
			var str = options[i];
			draw_set_color(_selected ? #fc7484 : c_white);
			draw_text(_x, _y, str);
			//draw_text_outline(_x, _y, str);
			
			if (i == value) {
				anim.update(global.delta_milli, _x - 20 + _selected * 4);
				draw_set_color(c_white);
				draw_text(anim.value, _y, ">");
				//draw_text_outline(anim.value, _y, ">");
			}
			
			_x += string_width(str) + padding;
		}
	}
}