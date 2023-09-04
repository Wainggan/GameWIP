x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;
x_vel = approach(x_vel, 0, 0.05 * global.delta_multi)
y_vel = approach(y_vel, 0, 0.05 * global.delta_multi)
life -= global.delta_multi
if life < 0 instance_destroy()