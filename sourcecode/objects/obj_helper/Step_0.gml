var _time = global.time * 1 * dir + off
var _deltax = obj_player.x - x;
var _deltay = obj_player.y - 64 - y;
var _intensity = point_distance(0, 0, _deltax, _deltay)


x_vel += (_deltax / (80 + _deltax / _intensity * spdOff) + lengthdir_x(1, _time) * (input.check("sneak") ? 0.5 : 0.7)) * global.delta_multi;
y_vel += (_deltay / (80 + _deltay / _intensity * spdOff) + lengthdir_y(1, _time) * (input.check("sneak") ? 0.2 : 0.3)) * global.delta_multi;

x_vel = lerp(x_vel, 0, 1 - power(1 - 0.8, global.delta_milli * 2));
y_vel = lerp(y_vel, 0, 1 - power(1 - 0.8, global.delta_milli * 2));

x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;
