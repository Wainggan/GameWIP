if array_length(stage) > 0
	if time == -1 {
		if instance_number(obj_enemy) == 0 {
			stageIndex++
			if stageIndex >= array_length(stage) {
				instance_destroy();
			} else {
				time = 60 * 4;
				stage[stageIndex]();
			}
			exit;
		}
	} else {
		if time <= 0 {
			stageIndex++
			if stageIndex >= array_length(stage) {
				instance_destroy();
			} else {
				time = 60 * 4;
				stage[stageIndex]();
			}
			exit;
		} else time--;
	}