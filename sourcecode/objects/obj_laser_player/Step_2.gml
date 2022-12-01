var _list = ds_list_create();
var _num = instance_place_list(x, y, obj_enemy, _list, true);

show_debug_message(_num)

if _num != 0 && !_list[| 0].invinsible {
	_list[| 0].hp -= damage * global.delta_multi
	_list[| 0].hitAnim = 0.6;
	image_xscale = point_distance(x, y, _list[| 0].x, _list[| 0].y) / 32 - 1;
}

ds_list_destroy(_list);