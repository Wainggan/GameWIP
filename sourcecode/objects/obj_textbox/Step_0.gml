delay -= global.delta_multi
if keyboard_check_pressed(ord("Z")) {
	if textProgress >= string_length(text) {
		with obj_textboxQueued { ticket--; event_user(0) }
		instance_destroy()
	} else {
		textProgress = string_length(text)
		delay = 0
		anim.percent = 1
	}
}

if delay > 0 exit

lastTextProgress = textProgress
textProgressPause -= global.delta_multi


if textProgressPause <= 0 textProgress += textSpeed * global.delta_multi

if anim.percent < 1 
	anim.percent += 0.06 * global.delta_multi; if anim.percent >= 1 anim.percent = 1

if instance_exists(obj_player) {
	obj_player.reloadTime = obj_player.tReloadTime
}