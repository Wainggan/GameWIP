delay -= global.delta_multi
if input.check_stutter("shoot", 16, 3) {
	if textProgress >= string_length(text) {
		with obj_textboxQueued { ticket--; event_user(0) }
		instance_destroy();
	} else {
		textProgress = string_length(text)
		delay = 0
		anim.percent = 1
	}
}

if delay > 0 exit;

if portrait != undefined {
	var _out = noone;
	with obj_portrait {
		if sprite == other.portrait[0] {
			_out = self;
			break;
		}
	}
	if _out == noone
		with instance_create_depth(0, 0, depth + 1, obj_portrait) {
			sprite = other.portrait[0];
			subsprite = other.portrait[1];
			side = other.portrait[2];
			owner = other;
			
			if other.anim.percent < 1 delay = 10
		}
	else
		with _out {
			subsprite = other.portrait[1];
			side = other.portrait[2];
			owner = other;
		}
	portrait = undefined;
}



lastTextProgress = textProgress
textProgressPause -= global.delta_multi


if textProgressPause <= 0 && anim.percent > 0.8 textProgress += textSpeed * global.delta_multi

anim.percent = min(anim.percent + 0.1 * global.delta_multi, 1)
