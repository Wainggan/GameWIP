var _pos = audio_sound_get_track_position(bgm);
if _pos > totalLength {
	audio_sound_set_track_position(bgm, _pos - loopLength);
}

if global.pause > lastPause {
	//audio_pause_sound(bgm);
}
if global.pause <= 0 {
	//audio_resume_sound(bgm);
}

lastPause = global.pause;