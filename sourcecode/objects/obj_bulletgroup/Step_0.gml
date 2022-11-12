for (var i = 0; i < array_length(bullets); i++) {
	if !instance_exists(bullets[i])
		array_delete(bullets, i--, 1)
}
if array_length(bullets) == 0 instance_destroy();

command_update();
movement_update();

x_vel = x_target != undefined ? approach(x_vel, x_target, x_accel * global.delta_multi) : x_vel + x_accel * global.delta_multi;
y_vel = y_target != undefined ? approach(y_vel, y_target, y_accel * global.delta_multi) : y_vel + y_accel * global.delta_multi;

spd = spd_target != undefined ? approach(spd, spd_target, spd_accel * global.delta_multi) : spd + spd_accel * global.delta_multi;

dir = dir_target != undefined ? approach(dir, dir_target, dir_accel * global.delta_multi) : dir + dir_accel * global.delta_multi;

translate(
	x_vel * global.delta_multi + lengthdir_x(spd, dir) * global.delta_multi,
	y_vel * global.delta_multi + lengthdir_y(spd, dir) * global.delta_multi
);

if step != undefined step()

if life != undefined life -= global.delta_multi
if life <= 0 { instance_destroy(); if death != undefined death(); particle.burst(x, y, "bulletExplosion", (x_vel + lengthdir_x(spd, dir)), (y_vel + lengthdir_y(spd, dir)))}