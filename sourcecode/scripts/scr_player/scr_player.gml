
function PlayerWeapon() constructor {
	
	amount = 0
	
	reloadTime = 0
	reload = 4
	
	static calculateReload = function() {
		var _reload = power(min(obj_player.grazeCombo * obj_player.grazeComboBulletMult + 1, 100), obj_player.grazeComboBulletExp)
		_reload = ( reload + 1 - _reload ) - obj_player.bulletCharge
		return _reload
	}
	
	static upgrade = function(_upgrades){}
	
	static update = function() {
		b = 2 + a;
	}
	static run = function(_shooting) {
		reloadTime -= global.delta_multi
		shot(_shooting && reloadTime <= 0)
		if reloadTime <= 0 {
			reloadTime = calculateReload()
		}
	}
	static shot = function(_shooting){}
	static unrun = function(){}

}

function PlayerWeapon_Default() : PlayerWeapon() constructor {
	
	amount = 3;
	reload = 7;
	damage = 1;
	
	spread = 6;
	spreadAngle = 18;
	spread_slow = 6
	spreadAngle_slow = 1
	
	speed = 14;
	
	static shot = function(_shooting) {
		if !_shooting return;
		
		var _spreadTemp = input.check("sneak") ? spread_slow : spread
		var _spreadAngleTemp = input.check("sneak") ? spreadAngle_slow : spreadAngle
		
		bullet_preset_plate(obj_player.x, obj_player.y, amount, _spreadTemp, _spreadAngleTemp, 2, 90, function(_x, _y, _dir){
			particle_burst(_x, _y - 24, ps_player_shoot)
			
			with player_create_bullet(_x, _y) {
				x_vel = lengthdir_x(other.speed, _dir);
				y_vel = lengthdir_y(other.speed, _dir);
				damage = other.damage
				fakedamage = 1
			}
			
		})
	}
	
}

function PlayerWeapon_Homing() : PlayerWeapon() constructor {
	
	amount = 0;
	reload = 12;
	damage = 0.2;

	spreadAngle = 90;
	spreadAngle_slow = 45;
	
	speed = 8;
	
	static shot = function(_shooting) {
		if !_shooting return;
		
		var _spreadAngleTemp = input.check("sneak") ? spreadAngle_slow : spreadAngle
		
		bullet_preset_plate(obj_player.x, obj_player.y, amount, 4, _spreadAngleTemp, 1, 90, function(_x, _y, _dir){
			with player_create_bullet(_x, _y) {
				dir = _dir;
				spd = other.speed;
						
				step = function(){
					var _target = instance_nearest(x, y, obj_enemy);
					if _target != noone
						dir_target = point_direction(x, y, _target.x, _target.y);
				}
				dir_target = dir;
				dir_accel = input.check("sneak") ? 1 : 2;
						
				damage = other.damage
				fakedamage = 0.2
						
				sprite_index = spr_bullet_homingplayerTest
						
				command_timer(60, function(){
					step = undefined;
				})
			}
		})
		
	}
	
}

function PlayerWeapon_Lazer() : PlayerWeapon() constructor {
	
	amount = 0;
	reload = 0;
	damage = 0.02;
	
	spread = 16;
	spread_slow = 32;
	spreadAngle = 24;
	spreadAngle_slow = -18;
	
	lazers = []
	
	static add = function() {
		with instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_laser_player) {
			xOff = 0;
			yOff = 0;
			angle = 90;
			angle_target = 90;
			angle_accel = 5;
			array_push(other.lazers, self);
		}
	}
	
	static remove = function() {
		instance_destroy(lazers[array_length(lazers) - 1])
		array_pop(lazers)
	}
	
	static shot = function(_shooting) {
		
		while array_length(lazers) < amount {
			add()
		}
		while array_length(lazers) > amount {
			remove()
		}

		var _spreadTemp = input.check("sneak") ? spread_slow : spread
		var _spreadAngleTemp = input.check("sneak") ? spreadAngle_slow : spreadAngle
		
		// gml bullshit
		self._shooting = _shooting
		
		bullet_preset_plate(0, 0 - 16, array_length(lazers), _spreadTemp, _spreadAngleTemp, 4, 90, function(_x, _y, _dir, _i) {
			var _inst = lazers[_i];
			_inst.xOff = lerp(_inst.xOff, _x, 1 - power(1 - 0.99999, global.delta_milliP * 2));
			_inst.yOff = lerp(_inst.yOff, _y, 1 - power(1 - 0.99999, global.delta_milliP * 2));
			_inst.x = obj_player.x + _inst.xOff
			_inst.y = obj_player.y + _inst.yOff
			_inst.active = _shooting;
			_inst.angle_target = _dir;
			_inst.damage = damage;
		})
		
	}
	
}

function PlayerWeapon_Round() : PlayerWeapon() constructor {
	
	amount = 0;
	reload = 4;
	damage = 0.2;

	speed = 12;
	
	static shot = function(_shooting) {
		if !_shooting return;
		
		var _angle = irandom_range(0, 360)
		
		bullet_preset_ring(obj_player.x, obj_player.y, amount, 4, _angle, function(_x, _y, _dir){
			with player_create_bullet(_x, _y) {
				
				dir = _dir;
				spd = other.speed;
						
				dir_target = 90;
				dir_accel = input.check("sneak") ? 9 : 6;
						
				damage = other.damage
				fakedamage = 0.2
						
				sprite_index = spr_player_round;

			}
			
		})
	}
	
}

function PlayerWeapon_Lad() : PlayerWeapon() constructor {
	
	amount = 0;
	reload = 0;
	damage = 0.4;
	
	treload = 12;
	
	speed = 14;
	
	lads = []
	
	static add = function() {
		with instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_helper) {
			array_push(other.lads, self);
		}
	}
	
	static remove = function() {
		instance_destroy(lads[array_length(lads) - 1])
		array_pop(lads)
	}
	
	static shot = function(_shooting) {
		if keyboard_check_pressed(ord("4")) amount++
		
		while array_length(lads) < amount {
			add()
		}
		while array_length(lads) > amount {
			remove()
		}
		
		var _ox = obj_player.x - 8;
		var _oy = obj_player.y - 64;
		
		var _dist = power((input.check("sneak") ? 4 : 6) * array_length(lads), 1.05)
		var _angle = wave(-360, 360, 6) + 90
		var _anglediff = 360 / array_length(lads)
		
		for (var i = 0; i < array_length(lads); i++) {
			var _other = self;
			
			with lads[i] {
				tReloadTime = _other.treload + i * 0.5;
				reloadTime -= global.delta_multi;
				
				x_target = _ox + lengthdir_x(_dist, _angle + _anglediff * i)
				y_target = _oy + lengthdir_y(_dist * (input.check("sneak") ? 0.5 : 0.7), _angle + _anglediff * i)
			}
		}
		
		if !_shooting return;
		
		for (var i = 0; i < array_length(lads); i++) {
			var _other = self;
			
			with lads[i] {
				if reloadTime <= 0 {
					reloadTime = tReloadTime;
		
					with player_create_bullet(x, y) {
						dir = 90;
						spd = _other.speed;
						damage = _other.damage;
						fakedamage = 0.4
						
						sprite_index = spr_player_helper
					}
				}
				
			}
		}
	}
	
}


function player_create_bullet(_x, _y) {
	var _inst = instance_create_depth(_x, _y, obj_player.depth, obj_bullet_player)
	with _inst {
		fade = 1
		fadeTime = 1
	}
	return _inst
}


function player_calculate_upgrade() {
	
	return {}
	
}

