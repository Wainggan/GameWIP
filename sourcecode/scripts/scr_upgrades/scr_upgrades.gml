
function PlayerConfig(_player) constructor {
	
	// player defaults, before any upgrades are applied
	defaults = {
		
		player: _player,
		
		moveSpeed: 5,
		moveSpeed_fast: 5, // when not shooting and not shifting
		moveSpeed_slow: 2, // when shifting
		
		accel: 5,
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
		
		bullet_default: 3,
		bullet_homing: 0,
		bullet_lazer: 0,
		bullet_round: 0,
		bullet_helper: 0,
		
	};
	
	upgrades = [];
	
	for (var i = 0; i < array_length(global.upgrades); i++) {
		array_push(upgrades, global.upgrades[i].create());
	}
	
	static get = function(_name) {
		for (var i = 0; i < array_length(upgrades); i++) {
			if upgrades[i].name == _name return upgrades[i];
		}
		return undefined;
	}
	
}

function player_calculate_upgrade() {
	
	var _copy = variable_clone(obj_player.config.defaults, 0);
	
	for (var i = 0; i < array_length(obj_player.config.upgrades); i++) {
		obj_player.config.upgrades[i].apply(_copy);
	}
	
	return _copy;
	
}


function Upgrade(_name, _apply, _index = 0) constructor {

	name = _name;
	apply = _apply;
	
	index = _index;
	
	static create = function() {
		var _upgrade = {
			level: 0,
			name,
			apply: undefined,
		};
		_upgrade.apply = method(_upgrade, apply);
		return _upgrade;
	};
	
}

global.upgrades = [
	new Upgrade("WeaponDefault", function(_config){
		_config.bullet_default += level
	}),
	new Upgrade("WeaponHoming", function(_config){
		_config.bullet_homing += level
	}),
	new Upgrade("WeaponLazer", function(_config){
		_config.bullet_lazer += level
	}),
	new Upgrade("WeaponRound", function(_config){
		_config.bullet_round += level
	}),
	new Upgrade("WeaponHelper", function(_config){
		_config.bullet_helper += level
	}),
	new Upgrade("WeaponCharge", function(_config){
		
	}),
	
	new Upgrade("Speed", function(_config){
		_config.moveSpeed_fast += 2 * level;
	}),
	new Upgrade("Reflect", function(_config){
		_config.graze_reflectChance = min(_config.graze_reflectChance + 0.05 * level, 0.8);
	}),
	new Upgrade("Sheild", function(_config){
		
	}),
	new Upgrade("Clean", function(_config){
		
	}),
	
	new Upgrade("ItemPoint", function(_config){
		_config.collectPoint += 96 * level;
	}),
	new Upgrade("ItemRadius", function(_config){
		_config.collectRadius += 16 * level;
	}),
	
	new Upgrade("HookChargeUp", function(_config){
		
	}),
	new Upgrade("HookChargeAmount", function(_config){
		
	}),
	new Upgrade("HookChargeRetention", function(_config){
		
	}),
];

