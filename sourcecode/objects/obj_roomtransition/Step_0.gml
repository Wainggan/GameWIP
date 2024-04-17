if wait {
	animCurve.percent += 1/32 * global.delta_multi;
	if animCurve.percent >= 1 {
		animCurve.percent = 1;
		wait -= global.delta_multi;
	}
} else {
	if !hasSwitched {
		hasSwitched = true;
		
		with obj_player event_user(0)
		
		obj_player.alarm[0] = 1;
		
		// bad dumb idea
		render.look_default();
		render.background_reset();
		room_goto(roomTarget);
		
	} else 
		animCurve.percent -= 1/12 * global.delta_multi;
	if animCurve.percent < 0 instance_destroy();
}

scoreAnimWait -= global.delta_multi
if !scoreAnimWait {
	
	
	if array_length(scoreAnim) > 1 {
		scoreAnimCurve.percent = clamp(scoreAnimCurve.percent + 1/4 * global.delta_multi, 0, 1);
		var _p = scoreAnim[array_length(scoreAnim) - 1];
		with _p {
			if wait {
				wait -= global.delta_multi;
			} else {
				animCurve.percent += 1/4 * global.delta_multi;
				if animCurve.percent > 1 {
					modifier();
					array_pop(other.scoreAnim);
				}
			}
		}
	} else {
		if scoreAnim[0].wait {
			scoreAnim[0].wait -= global.delta_multi;
			if !scoreAnim[0].wait scoreAnim[0].modifier()
		}
		else
			scoreAnimCurve.percent = clamp(scoreAnimCurve.percent - 1/8 * global.delta_multi, 0, 1);
	}
}

