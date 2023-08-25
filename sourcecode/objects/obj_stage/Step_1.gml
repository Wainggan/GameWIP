if array_length(stage) > 0 {
	minimumTime -= global.delta_multi;
	if waitUntilDone {
		if instance_number(obj_enemy) == 0 && instance_number(obj_collectable_upgrade) == 0 && array_length(enemyBuffer) == 0 {
			waitUntilDone = false;
		}
	} else {
		if timeLeft <= 0 && minimumTime <= 0 {
			
			
			var _item = stage[stageIndex++]
			if is_method(_item) {
				time(60)
				_item();
				print("stage: method")
			} else {
				if is_instanceof(_item, __Stage) {
					time(0)
					_item.func()
					print("stage: __Stage")
				} else if is_instanceof(_item, __Pause) {
					time(_item.length, _item.wait, _item.minimumLength)
					print("stage: __Pause")
				}
			}
			
			if stageIndex + 1 > array_length(stage) {
				instance_destroy();
				print("end of stage")
			}
			
			exit;
		} else timeLeft -= global.delta_multi;
	}
}

for (var i = 0; i < array_length(enemyBuffer); i++) {
	enemyBuffer[i][3] -= global.delta_multi;
	if enemyBuffer[i][3] <= 0 {
		var _func = array_pop(enemyBuffer[i])
		array_delete(enemyBuffer[i], 3, 1);
		var inst = script_execute_ext(method_get_index(enemy), enemyBuffer[i]);
		method(inst, _func)();
		array_delete(enemyBuffer, i, 1);
	}
}