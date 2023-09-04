var _enemyList = ds_list_create()
collision_circle_list(x, y, size, obj_enemy, true, true, _enemyList, false);

for (var i = 0; i < ds_list_size(_enemyList); i++) {
	with _enemyList[| i] {
		if invinsible continue;
		var _damage = maxhp * (other.percentDamage * (ignoreSlap ? 0.05 : 1));
		_damage += other.damage
		hp -= _damage
		hitAnim = 1
		
		print(_damage)
		
		with text_damage_random(
			x, y, point_direction(other.x, other.y, x, y), 
			ceil(_damage * 10), 48, 20, 20, 1.2
		) {
			font = ft_bigdamage
		}
	}
}

ds_list_destroy(_enemyList);