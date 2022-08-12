testSlowDown = keyboard_check_pressed(ord("Q")) ? !testSlowDown : testSlowDown
global.delta_target = testSlowDown ? 1/20 : 1/60

var actualDelta = 1/60//delta_time / 1000000


global.delta_multi = actualDelta / global.delta_target

global.time += global.delta_multi;

var h = global.delta_multi
if global.pause {
	global.delta_multi = 0;
}
particleUpdateBuffer += global.delta_multi
if (particleUpdateBuffer >= 1) {
	repeat floor(particleUpdateBuffer) {
		part_system_update(particle.particleSystem)
		particleUpdateBuffer -= 1
	}
}

global.screenShake = approach(global.screenShake, 0, global.screenShakeDamp)

global.pause = max(global.pause - h, 0)


if global.score > global.highscore {
	global.highscore = global.score;
}

//show_debug_message(global.delta_multi)