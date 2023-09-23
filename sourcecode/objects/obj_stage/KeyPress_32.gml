if !DEBUG exit

var _out = true;
with obj_enemy if !canDie _out = false
if _out {
	global.stage_time += timeLeft / 60
	audio_sound_set_track_position(music.bgm, audio_sound_get_track_position(music.bgm) + timeLeft / 60)
	timeLeft = 0;
	enemyBuffer = [];
}
