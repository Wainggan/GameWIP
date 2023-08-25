playing = -1;
bgm = -1
lastPause = 0;
lastPausePos = 0;
lastPlaying = playing

volume = 0;

introLength = 4;
loopLength = (60 + 4) - introLength;
totalLength = introLength + loopLength;

bpm = 150;
lastBeat = 0;
beatTotal = 0;
hasBeat = false;


meta = {
	mus_stage1test: method(self, function(){
		introLength = 3.07;
		loopLength = (60 + 41.53) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_stage1: method(self, function(){
		bpm = 154
		introLength = beat_to_time(8 * 4, bpm);
		print(beat_to_time(68 * 4, bpm))
		loopLength =  beat_to_time(68 * 4, bpm) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_boss1: method(self, function(){
		bpm = 148
		introLength = beat_to_time(6 * 4, bpm);
		loopLength =  beat_to_time(46 * 4, bpm) - introLength;
		print(beat_to_time(46 * 4, bpm))
		totalLength = introLength + loopLength;
	}),
	mus_stage2test: method(self, function(){
		introLength = 19.45;
		loopLength = (60 * 3 + 37.29) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_boss2: method(self, function(){
		introLength = 25.60;
		loopLength = (60 * 3 + 10.01) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_stage3: method(self, function(){
		introLength = 14.01;
		loopLength = (60 * 3 + 2.19) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_boss3: method(self, function(){
		introLength = 33.41;
		loopLength = (60 * 2 + 53.16);
		totalLength = introLength + loopLength;
		
		bpm = 158;
	}),
}

news_subscribe("music_change", function(_s) {
	playing = _s;
	
	audio_stop_sound(bgm);
	bgm = -1;
	if playing != -1 {
		bgm = audio_play_sound(playing, 0, true, volume);
		if meta[$ audio_get_name(playing)]
			meta[$ audio_get_name(playing)]()
		show_debug_message("{0}, {1}", introLength, loopLength)
		audio_sound_loop_start(bgm, introLength)
		audio_sound_loop_end(bgm, totalLength)
	}
});

news_subscribe("volume_change", function(_v) {
	volume = _v
	show_debug_message(_v)
	if bgm != -1
		audio_sound_gain(bgm, volume, 10)
});

news_push("volume_change", [ // TODO: clean
	global.file.settings.sound.globalVolume * 
	global.file.settings.sound.musicVolume
]);

/*
// stage 3
introLength = 19.72;
loopLength = (60 + 51.78) - introLength;
totalLength = introLength + loopLength;