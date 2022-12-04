command_update()

var _time = global.time * 1 * dir + off;
var _inst = instance_nearest(x,y, obj_enemy);
if _inst != noone {
	var _deltax = _inst.x - x;
	var _deltay = _inst.y + 128 - y;

	x_vel += (_deltax / (120) + lengthdir_x(0.5, _time)) * global.delta_multi;
	y_vel += (_deltay / (120) + lengthdir_y(0.5, _time)) * global.delta_multi;
	
	x_vel = clamp(x_vel, -6, 6)
	y_vel = clamp(y_vel, -6, 6)
}

x_vel = lerp(x_vel, 0, 1 - power(1 - 0.9, global.delta_milli * 2));
y_vel = lerp(y_vel, 0, 1 - power(1 - 0.9, global.delta_milli * 2));

x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;
