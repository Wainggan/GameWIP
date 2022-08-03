command_update();
movement_update();

fade = max(fade - 1, 0);

x_vel = x_target != undefined ? approach(x_vel, x_target, x_accel) : x_vel + x_accel;
y_vel = x_target != undefined ? approach(y_vel, y_target, y_accel) : y_vel + y_accel;

spd = spd_target != undefined ? approach(spd, spd_target, spd_accel) : spd + spd_accel;

dir += dir_vel;

x += x_vel + lengthdir_x(spd, dir);
y += y_vel + lengthdir_y(spd, dir);



step()

if showDirection image_angle = point_direction(0, 0, lengthdir_x(spd, dir) + x_vel, lengthdir_y(spd, dir) + y_vel)

if life != undefined life -= global.delta_multi
if life <= 0 { instance_destroy(); death(); particle.burst(x, y, "bulletExplosion", (x_vel + lengthdir_x(spd, dir)), (y_vel + lengthdir_y(spd, dir)))}