global.wText_changers = {
	color : [
		[["num", c_white]],
		function(_char, _args){
			_char.color = _args[0]
		}
	],
	font : [
		["str"],
		function(_char, _args){
			_char.font = asset_get_index(_args[0])
		}
	],
	alpha : [
		[["num", 1]],
		function(_char, _args){
			_char.alpha = _args[0]
		}
	],
	wave : [
		[["num", 2], ["num", 0.2]],
		function(_char, _args){
			_char.y += sin((global.time/60)*4 + _char.number*_args[1])*_args[0]
		}
	],
	shake : [
		[["num", 1]],
		function(_char, _args) {
			_char.x += random_range(-_args[0], _args[0])
			_char.y += random_range(-_args[0], _args[0])
		}
	],
	
	pause : [
		[["num", 10]],
		function(_args) {
			return _args[0]
		}
	]
}
global.wText_syntax = {
	changerBegin : "[",
	changerEnd : "]",
	changerStop : "/",
	eventBegin : "{",
	eventEnd : "}",
	argumentNameSeperator : ":",
	argumentSeperator : ",",
	defaultArgument : "undefined",
	variableStruct : ".",
	variableInstance : "?",
	variableGlobal : "!",
}

function string_parse(_string) {
	var output = []
	for (var i = 1; i <= string_length(_string); i++) {
		if string_char_at(_string, i) == global.wText_syntax.changerBegin || string_char_at(_string, i) == global.wText_syntax.eventBegin {
			var changerType = string_char_at(_string, i)
			if string_char_at(_string, i+1) == global.wText_syntax.changerStop { // end command
				i += 2
				array_push(output, [global.wText_syntax.changerStop])
			} else { // start command
				var arrayToOut = []
				
				// getting the full command until the :
				var command = ""
				i++
				while string_char_at(_string, i) != global.wText_syntax.argumentNameSeperator {
					command = string_insert(string_char_at(_string, i), command, string_length(command)+1)
					i++
				}
				
				// checking to see if the command exists, then getting the arguments for that command
				var argsType
				argsType = global.wText_changers[$ command][0]
				
				array_push(arrayToOut, command)
				
				array_push(arrayToOut, changerType == global.wText_syntax.changerBegin ? 0 : 1)
				
				// getting all arguments
				var args = ""
				i++
				while !(string_char_at(_string, i) == global.wText_syntax.changerEnd || string_char_at(_string, i) == global.wText_syntax.eventEnd) {
					args = string_insert(string_char_at(_string, i), args, string_length(args)+1)
					i++
				}
				
				// divide the arguments into an array
				var tempA = ""
				var argsArr = []
				for (var j = 1; j <= string_length(args); j++) {
					tempA = string_insert(string_char_at(args, j), tempA, string_length(tempA)+1)
					if string_char_at(args, j+1) == global.wText_syntax.argumentSeperator || j+1 > string_length(args){
						j++
						if (string_char_at(args, j) != global.wText_syntax.argumentSeperator) tempA = string_insert(string_char_at(args, j), tempA, string_length(tempA)+1)
						array_push(argsArr, tempA)
						tempA = ""
						
					}
				}

				
				// some kind of bullshit
				for (var j = 0; j < array_length(argsType); j++) {
					if j >= array_length(argsArr) || (argsArr[j] == global.wText_syntax.defaultArgument && is_array(argsType[j])) {
						argsArr[j] = argsType[j][1]
						continue
					}
					var tempArgType = is_array(argsType[j]) ? argsType[j][0] : argsType[j]
					var varFix = 0
					switch string_char_at(argsArr[j], 1) {
						case global.wText_syntax.variableStruct: varFix = 1; break;
						case global.wText_syntax.variableInstance: varFix = 2; break;
						case global.wText_syntax.variableGlobal: varFix = 3; break;
					}
					if varFix != 0 {
						var s = string_delete(argsArr[j], 1, 1)
						if varFix == 1{
							argsArr[j] = variable_struct_get(self, s)
						} else if varFix == 2 {
							argsArr[j] = variable_instance_get(id, s)
						} else if varFix == 3 {
							argsArr[j] = variable_global_get(s)
						}
					} else {
						switch tempArgType {
							case "num":
								argsArr[j] = real(argsArr[j])
								break;
							case "str": break;
						}
					}
				}
				for (var j = 0; j < array_length(argsArr); j++) {
					array_push(arrayToOut, argsArr[j])
				}
				
				array_push(output, arrayToOut)
			}
			
		} else {
			if array_length(output) < 1 || is_array(output[array_length(output)-1]) {
				array_push(output, "")
			}
			output[array_length(output)-1] = string_insert(string_char_at(_string, i), output[array_length(output)-1], string_length(output[array_length(output)-1])+1)
		}
		
	}
	
	return output
}

function draw_parsedText(_x, _y, _script, _lineBreak = -1, _progress = 9999999, _lastProgress = 0) {
	var _lastDrawColor = draw_get_color()
	var _lastDrawAlpha = draw_get_alpha()
	var _lastDrawFont = draw_get_font()
	
	var _return = { finished : false }
	var _eventRan = {}
	
	var charactersDrawn = 0
	var currentX = _x;
	var currentY = _y;
	var funcStack = []
	
	for (var i = 0; i < array_length(_script); i++) {
		if is_string(_script[i]) {
			for (var j = 1; j <= string_length(_script[i]); j++) {
				var char = string_char_at(_script[i], j)
				
				if char == "\n" {
					currentY += string_height(char)
					currentX = _x
					continue
				}
				if char == " " {
					var n = j+1
					var wordLen = ""
					while string_char_at(_script[i], n) != " " && n <= string_length(_script[i]) {
						wordLen = string_insert(string_char_at(_script[i], n), wordLen, string_length(wordLen)+1)
						n+=1
					}
					if currentX + string_width(wordLen) > _x + _lineBreak {
						j += 1
						
						currentY += string_height(char)
						currentX = _x
					}
				}
				
				if charactersDrawn <= _progress {
					char = string_char_at(_script[i], j)
					var charOb = {
						x : currentX, y : currentY, 
						char : char, 
						number : charactersDrawn, 
						color : _lastDrawColor, font : _lastDrawFont, alpha : _lastDrawAlpha
					}
					
					for (var n = 0; n < array_length(funcStack); n++) {
						funcStack[n][1](charOb, funcStack[n][0])
					}
					
					draw_set_color(charOb.color)
					draw_set_font(charOb.font)
					draw_set_alpha(charOb.alpha)
					draw_text(charOb.x, charOb.y, charOb.char)
					
					
					charactersDrawn++
					currentX += string_width(char)
					
					
				} else {
					draw_set_color(_lastDrawColor)
					draw_set_alpha(_lastDrawAlpha)
					draw_set_font(_lastDrawFont)
					return _return
				}
				
				
			}
		} else {
			if _script[i][0] == global.wText_syntax.changerStop {
				array_pop(funcStack)
			} else {
				var _ar = []
				array_copy(_ar, 0, _script[i], 2, array_length(_script[i])-1)
				if _script[i][1] == 0 {
					array_push(funcStack, [_ar, global.wText_changers[$ _script[i][0]][1] ])
				} else {
					if charactersDrawn-1 > floor(_lastProgress) {
						if _eventRan[$ _script[i][0]] == undefined {
							_return[$ _script[i][0]] = global.wText_changers[$ _script[i][0]][1](_ar)
							_eventRan[$ _script[i][0]] = 1
						} else _eventRan[$ _script[i][0]] += 1

					}
				}
				
			}
		}
	}
	
	_return.finished = true
	
	draw_set_color(_lastDrawColor)
	draw_set_alpha(_lastDrawAlpha)
	draw_set_font(_lastDrawFont)
	return _return
}
