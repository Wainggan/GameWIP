//global.delta_target = keyboard_check(vk_shift) ? 1/30 : 1/60

var actualDelta = 1/60//delta_time / 1000000

global.delta_multi = actualDelta / global.delta_target


var h = global.delta_multi
if global.pause {
	global.delta_multi = 0;
}
global.pause = max(global.pause - h, 0)


if global.score > global.file.save.highscore {
	global.file.save.highscore = global.score;
}

//show_debug_message(global.delta_multi)