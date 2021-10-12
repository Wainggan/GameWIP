//global.delta_target = keyboard_check(vk_shift) ? 1/30 : 1/60

var actualDelta = 1/60//delta_time / 1000000

global.delta_multi = actualDelta / global.delta_target

//show_debug_message(global.delta_multi)