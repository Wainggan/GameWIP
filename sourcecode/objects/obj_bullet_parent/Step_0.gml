x_vel += x_accel * global.delta_multi;
y_vel += y_accel * global.delta_multi;

spd += spd_accel * global.delta_multi;
dir += dir_vel * global.delta_multi;

x += (x_vel + lengthdir_x(spd, dir)) * global.delta_multi;
y += (y_vel + lengthdir_y(spd, dir)) * global.delta_multi;

step()
