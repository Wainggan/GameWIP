
function textbox_create(_message, _portrait = undefined, _onEnd = function(){}, _delay = 0) {
	var obj = instance_exists(obj_textbox) ? obj_textboxQueued : obj_textbox
	with instance_create_layer(0, 0, "GUI", obj) {
		text = _message
		textParsed = string_parse(text);
		portrait = _portrait;
		delay = _delay
		onEnd = _onEnd;
		originInst = instance_exists(other) ? other.id : originInst = noone
	}
}

function textbox_scene_create(_scene) {
	for (var i = 0; i < array_length(_scene); i++) {
		script_execute_ext(textbox_create, _scene[i])
	}
}