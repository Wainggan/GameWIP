
function PlayerConfig(_player) constructor {
	
	// player defaults, before any upgrades are applied
	defaults = {
		
		player: _player,
		
		moveSpeed: 5,
		moveSpeed_fast: 5, // when not shooting and not shifting
		moveSpeed_slow: 2, // when shifting
		
		accel: 4,
		accel_slow: 2, // when shifting
		
		collectRadius: 64, // item collection radius
		collectPoint: 0, // touhou-style point of collection
		
		graze_radius: 38,
		
		graze_reflectChance: 0, // % chance of relfecting grazed bullets
		
		graze_charge_gain: 0.06,
		graze_charge_loss: 0.03,
		graze_charge_retention: 50,
		
		hook_charge_ambient: 0.001,
		hook_charge_grazeMultiplier: 0.003,
		
		bullet_default: 0,
		bullet_homing: 0,
		bullet_lazer: 0,
		bullet_round: 0,
		bullet_helper: 0,
		
	};
	
	upgrades = {};
	
	struct_foreach(global.upgrades, function(k, v){
		upgrades[$ k] = v.create();
	})
	
	static get = function(_name) {
		return upgrades[$ _name];
	}
	
}

function player_calculate_upgrade() {
	
	var _copy = variable_clone(obj_player.config.defaults, 1);

	var _a = variable_struct_get_names(obj_player.config.upgrades);
	
	for (var i = 0; i < array_length(_a); i++) {
		obj_player.config.upgrades[$ _a[i]].apply(_copy);
	}
	
	return _copy;
	
}


function Upgrade(_apply, _index = 0) constructor {

	apply = _apply;
	
	index = _index;
	
	static create = function() {
		var _upgrade = {
			level: 0,
			apply: undefined,
		};
		_upgrade.apply = method(_upgrade, apply);
		return _upgrade;
	};
	
}

global.upgrades = {
	WeaponDefault: new Upgrade(function(_config){
		_config.bullet_default += level
	}, 0),
	WeaponHoming: new Upgrade(function(_config){
		_config.bullet_homing += level
	}, 1),
	WeaponLazer: new Upgrade(function(_config){
		_config.bullet_lazer += level
	}, 2),
	WeaponRound: new Upgrade(function(_config){
		_config.bullet_round += level
	}, 3),
	WeaponHelper: new Upgrade(function(_config){
		_config.bullet_helper += level
	}, 4),
	WeaponHelper2: new Upgrade(function(_config){
		_config.bullet_helper += level * 2
	}, 5),
	WeaponCharge: new Upgrade(function(_config){
		
	}),
	
	Speed: new Upgrade(function(_config){
		_config.moveSpeed_fast += 2 * level;
	}, 6),
	Reflect: new Upgrade(function(_config){
		_config.graze_reflectChance = min(_config.graze_reflectChance + 0.06 * level, 0.8);
	}, 7),
	Sheild: new Upgrade(function(_config){
		
	}),
	Clean: new Upgrade(function(_config){
		
	}),
	
	ItemPoint: new Upgrade(function(_config){
		_config.collectPoint += 96 * level;
	}, 10),
	ItemRadius: new Upgrade(function(_config){
		_config.collectRadius += 16 * level;
	}, 9),
	
	HookChargeUp: new Upgrade(function(_config){
		_config.hook_charge_ambient += 0.0005 * level;
	}, 8),
	HookChargeAmount: new Upgrade(function(_config){
		
	}),
	GrazeChargeRetention: new Upgrade(function(_config){
		_config.graze_charge_loss = max(0.005, _config.graze_charge_loss - 0.003 * level)
		_config.graze_charge_retention += 10 * level
	}),
};

