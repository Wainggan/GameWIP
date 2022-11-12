var _out = true;
with obj_enemy if !canDie _out = false
if _out {
	audio_sound_set_track_position(music.bgm, audio_sound_get_track_position(music.bgm) + time / 60)
	time = 0;
	enemyBuffer = [];
}
