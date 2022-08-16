command_update();
movement_update();

fade = max(fade - global.delta_multi, 0);
if fade == 0 mask_index = sprite_index;
else mask_index = spr_nothing;

x_vel = x_target != undefined ? approach(x_vel, x_target, x_accel * global.delta_multi) : x_vel + x_accel * global.delta_multi;
y_vel = y_target != undefined ? approach(y_vel, y_target, y_accel * global.delta_multi) : y_vel + y_accel * global.delta_multi;

spd = spd_target != undefined ? approach(spd, spd_target, spd_accel * global.delta_multi) : spd + spd_accel * global.delta_multi;

dir += dir_vel * global.delta_multi;

x += x_vel * global.delta_multi + lengthdir_x(spd, dir) * global.delta_multi;
y += y_vel * global.delta_multi + lengthdir_y(spd, dir) * global.delta_multi;

if step != undefined step()

if showDirection image_angle = point_direction(0, 0, lengthdir_x(spd, dir) + x_vel, lengthdir_y(spd, dir) + y_vel)

if life != undefined {
	life -= global.delta_multi
	if life <= 0 { 
		instance_destroy(); 
		if death != undefined death(); 
		particle.burst(x, y, "bulletExplosion", (x_vel + lengthdir_x(spd, dir)), (y_vel + lengthdir_y(spd, dir)))
	}
}