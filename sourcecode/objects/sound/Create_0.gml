
var _Sound = function(_buffer, _priority, _enable = true) constructor {
	timer = 0
	buffer = _buffer
	priority = _priority
	enable = _enable
}

meta = {
	snd_collectItem: new _Sound(1, 4),
	snd_enemydeath: new _Sound(4, 6),
	snd_bulletshoot: new _Sound(2, 4),
	snd_bulletshoot: new _Sound(4, 5),
}

play = function(_sound){
	var _sesound = audio_get_name(_sound)
	
	if meta[$ _sesound] == undefined {
		print("oops")
		audio_play_sound(_sound, 10, false)
		return
	}
	
	if meta[$ _sesound].timer > 0 return;
	
	meta[$ _sesound].timer = meta[$ _sesound].buffer
	audio_play_sound(_sound, meta[$ _sesound].priority, false)
	
}
