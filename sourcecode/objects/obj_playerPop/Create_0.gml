size = 96

var _enemyList = ds_list_create()
collision_circle_list(x, y, size, obj_enemy, true, true, _enemyList, false);

for (var i = 0; i < ds_list_size(_enemyList); i++) {
	with _enemyList[| i] {
		if invinsible continue;
		hp -= maxhp * (other.percentDamage * (ignoreSlap ? 0.33 : 1));
		hp -= other.damage;
		hitAnim = 1
	}
}

ds_list_destroy(_enemyList);

screenShake_set(4, 0.2);
