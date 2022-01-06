function textbox_create(_message, _delay = 0) {
	var obj = instance_exists(obj_textbox) ? obj_textboxQueued : obj_textbox
	with instance_create_layer(0, 0, "GUI", obj) {
		text = _message
		textParsed = string_parse(text)
		delay = _delay
		originInst = instance_exists(other) ? other.id : originInst = noone
	}
}

var scene = [
	["text"],
	["text with potential arguments, for say a character portrait", 10, 20]
]

function textbox_scene_create(_scene) {
	for (var i = 0; i < array_length(_scene); i++) {
		script_execute_ext(textbox_create, _scene[i])
	}
}