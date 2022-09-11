if wait {
	time -= global.delta_multi;
	if time <= 0 {
		fade -= global.delta_multi;
		if fade <= 0 {
			fade = 0;
			wait -= global.delta_multi;
		}
	}
} else {
	fade += global.delta_multi;
	if fade > fadeTime instance_destroy()
}