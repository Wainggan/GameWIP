x_vel += accel_x;
y_vel += accel_y;

x += x_vel;
y += y_vel;

life -= global.delta_multi;
if life <= 0 {
	instance_destroy()
}