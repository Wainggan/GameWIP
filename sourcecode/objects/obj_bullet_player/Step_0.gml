event_inherited();

image_alpha += 0.14 * global.delta_multi

var _inst = instance_nearest(x, y, obj_enemy);
if !locked && _inst != noone && point_distance(x, y, _inst.x, _inst.y) < sprite_width * (2 + (_inst.bossFlag * 3)) {
	locked = true;
	x_vel = 0;
	y_vel = 0;
	dir = point_direction(x, y, _inst.x, _inst.y);
	spd = 12;
}
