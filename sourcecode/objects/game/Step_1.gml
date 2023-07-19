

global.slowdownTime -= global.delta_multi;

targetFrame = approach(targetFrame, global.slowdownTime > 0 ? 30 : 60, 2)

global.delta_target = 1 / targetFrame

var actualDelta = 1/60//delta_time / 1000000


global.delta_multi = actualDelta / global.delta_target
global.delta_multiNP = actualDelta / global.delta_target
global.delta_milli = global.delta_multi / 60;
global.delta_milliP = global.delta_multi / 60;

var h = global.delta_multi
if global.pause || pause {
	global.delta_multi = 0;
	global.delta_milliP = 0;
}
global.lastTime = global.time
global.time += global.delta_multi;

global.screenShake = approach(global.screenShake, 0, global.screenShakeDamp * global.delta_multi)

global.pause = max(global.pause - h, 0)
pause = max(pause - h, 0)
if pause <= 0 musicPause = false;


if global.score > global.highscore {
	global.highscore = global.score;
}

global.shotSound = false;
//show_debug_message(global.delta_multi)