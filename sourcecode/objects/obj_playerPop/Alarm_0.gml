var _enemyList = ds_list_create()
collision_circle_list(x, y, size, obj_enemy, true, true, _enemyList, false);

for (var i = 0; i < ds_list_size(_enemyList); i++) {
	with _enemyList[| i] {
		if invinsible continue;
		var _damage;
		switch hookDamageType {
			case 0:
				_damage = maxhp * other.percentDamage;
				break;
			case 1:
				_damage = maxhp;
				break;
			case 2:
				_damage = maxhp * other.percentDamage * 0.3;
				break;
		}
		_damage += other.damage
		
		hp -= _damage
		hitAnim = 1
		
		if hp/maxhp < 0.1 hp = 0;
		
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

var _upgrade = collision_circle(x, y, size, obj_collectable_upgrade, true, true);
with _upgrade {
	hp = 0
}

