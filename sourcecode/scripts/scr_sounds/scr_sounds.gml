function sound_bullet() {
	if !global.shotSound 
		audio_play_sound(snd_bulletShot, 0, 0)
	global.shotSound = true;
}