if bgm != -1 {
	var _pos = audio_sound_get_track_position(bgm);
	if _pos > totalLength {
		audio_sound_set_track_position(bgm, _pos - loopLength);
	}
	if game.musicPause && game.musicPause != lastPause {
		lastPausePos = _pos;
		audio_sound_gain(bgm, 0, 10);
	} else if !game.musicPause && game.musicPause != lastPause {
		audio_sound_set_track_position(bgm, lastPausePos);
		audio_sound_gain(bgm, volume, 10);
	}
}

if playing != lastPlaying {
	lastPlaying = playing
}

lastPause = game.musicPause;