y -= y_vel * global.delta_multi;
y_vel = max(0, y_vel - 0.05 * global.delta_multi)
life -= global.delta_multi
if life < 0 instance_destroy()