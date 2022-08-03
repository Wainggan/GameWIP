x_vel += x_accel * global.delta_multi;
y_vel += y_accel * global.delta_multi;

if spd_target != undefined spd = approach(spd, spd_target, spd_targetSpd * global.delta_multi)

spd += spd_accel * global.delta_multi;
dir += dir_vel * global.delta_multi;

x += (x_vel + lengthdir_x(spd, dir)) * global.delta_multi;
y += (y_vel + lengthdir_y(spd, dir)) * global.delta_multi;

step()

if showDirection image_angle = point_direction(0, 0, lengthdir_x(spd, dir) + x_vel, lengthdir_y(spd, dir) + y_vel)

if life != undefined life -= global.delta_multi
if life <= 0 { instance_destroy(); death(); particle.burst(x, y, "bulletExplosion", (x_vel + lengthdir_x(spd, dir)), (y_vel + lengthdir_y(spd, dir)))}