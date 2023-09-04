var _list = ds_list_create();
var _num = instance_place_list(x, y, obj_enemy, _list, true);

if _num != 0 && !_list[| 0].invinsible {
	_list[| 0].hp -= damage * global.delta_multi
	damageTimer += damage * global.delta_multi
	
	if damageTimer >= 0.1 {
		text_damage_random(
			_list[| 0].x, _list[| 0].y, angle, 
			floor(damageTimer * 10), 16, 2, 4
		);
		damageTimer = 0
	}
	
	_list[| 0].hitAnim = 0.6;
	_list[| 0].onHit(self);
	image_xscale = point_distance(x, y, _list[| 0].x, _list[| 0].y) / 32 - 1;
}

ds_list_destroy(_list);