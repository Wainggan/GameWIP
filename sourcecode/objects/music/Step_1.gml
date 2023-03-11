if bgm != -1 {
	var _pos = audio_sound_get_track_position(bgm);
	//if _pos > totalLength {
		//audio_sound_set_track_position(bgm, _pos - loopLength);
	//}
	if game.musicPause && game.musicPause != lastPause {
		lastPausePos = _pos;
		audio_sound_gain(bgm, 0, 10);
	} else if !game.musicPause && game.musicPause != lastPause {
		audio_sound_set_track_position(bgm, lastPausePos);
		audio_sound_gain(bgm, volume, 10);
	}
}

hasBeat = false;
lastBeat -= global.delta_milliP;
if lastBeat <= 0 {
	//show_debug_message(current_time)
	//show_debug_message(bpm)
	//show_debug_message(60 / bpm)
	//show_debug_message(60 / bpm / 8)
	//show_debug_message(global.delta_milliP)
	
	lastBeat += 60 / bpm / 8;
	beatTotal++;
	if beatTotal % 1 == 0 news_push("8th"); //
	if beatTotal % 2 == 0 news_push("4th");
	if beatTotal % 3 == 0 news_push("3rd");
	if beatTotal % 4 == 0 news_push("2nd");
	if beatTotal % 6 == 0 news_push("1.5th");
	if beatTotal % 8 == 0 news_push("quarter");
	if beatTotal % 16 == 0 news_push("half");
	if beatTotal % 32 == 0 news_push("whole");
	hasBeat = true;
}

if playing != lastPlaying {
	lastPlaying = playing
}

lastPause = game.musicPause;