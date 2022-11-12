x_vel = 0;
y_vel = 0;

x_accel = 0;
y_accel = 0;

x_target = undefined;
y_target = undefined;

dir = 0;
dir_accel = 0;
dir_target = undefined;

spd = 0;
spd_accel = 0;
spd_target = undefined;

life = undefined;

step = undefined;
death = undefined;

bullets = [];

add = function(_bullets) {
	array_push(bullets, _bullets);
}
translate = function(_xV, _yV) {
	x += _xV;
	y += _yV;
	for (var i = 0; i < array_length(bullets); i++) {
		var b = bullets[i];
		b.x += _xV;
		b.y += _yV;
	}
}
rotate = function(_amount) {
	for (var i = 0; i < array_length(bullets); i++) {
		var b = bullets[i];
		var _dir = point_direction(x, y, b.x, b.y);
		var _dist = point_distance(x, y, b.x, b.y);
		b.x = x + lengthdir_x(_dist, _dir + _amount);
		b.y = y + lengthdir_y(_dist, _dir + _amount);
	}
}
zoom = function(_amount) {
	for (var i = 0; i < array_length(bullets); i++) {
		var b = bullets[i];
		var _dir = point_direction(x, y, b.x, b.y);
		var _dist = point_distance(x, y, b.x, b.y);
		b.x = x + lengthdir_x(_dist + _amount, _dir);
		b.y = y + lengthdir_y(_dist + _amount, _dir);
	}
}
scale = function(_amount) {
	for (var i = 0; i < array_length(bullets); i++) {
		var b = bullets[i];
		var _dir = point_direction(x, y, b.x, b.y);
		var _dist = point_distance(x, y, b.x, b.y);
		b.x = x + lengthdir_x(_dist * _amount, _dir);
		b.y = y + lengthdir_y(_dist * _amount, _dir);
	}
}