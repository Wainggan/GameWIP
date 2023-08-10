x_vel += accel_x * global.delta_multi;
y_vel += accel_y * global.delta_multi;

x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;

scale = approach(scale, scale_target, scale_vel * global.delta_multi)

life -= global.delta_multi;
if life <= 0 {
	instance_destroy()
}