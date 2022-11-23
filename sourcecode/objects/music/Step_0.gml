if bgm != -1 {
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
}

if playing != lastPlaying {
	audio_stop_sound(bgm);
	bgm = -1;
	if playing != -1 {
		bgm = audio_play_sound(playing, 0, false);
		meta[$ audio_get_name(playing)]()
	}
	lastPlaying = playing
}

lastPause = global.pause;