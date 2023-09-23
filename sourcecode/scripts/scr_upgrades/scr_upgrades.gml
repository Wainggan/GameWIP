
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
	
	upgrades = [
		new Upgrade_WeaponDefault(),
		new Upgrade_WeaponHoming(),
		new Upgrade_WeaponLazer(),
		new Upgrade_WeaponRound(),
		new Upgrade_WeaponHelper(),
		new Upgrade_WeaponCharge(),
		
		new Upgrade_Speed(),
		new Upgrade_Reflect(),
		new Upgrade_Shield(),
		new Upgrade_Clean(),
		
		new Upgrade_ItemPoint(),
		new Upgrade_ItemRadius(),
		
		new Upgrade_HookChargeUp(),
		new Upgrade_HookChargeAmount(),
		new Upgrade_GrazeChargeRetention(),
	]
	
}

function player_calculate_upgrade() {
	
	var _copy = variable_clone(obj_player.config.defaults, 0);
	
	for (var i = 0; i < array_length(obj_player.config.upgrades); i++) {
		obj_player.config.upgrades[i].apply(_copy);
	}
	
	return _copy;
	
}

function player_setup_upgrade(_player) {
	
	_player.upgrades = []
	
	for (var i = 0; i < array_length(global.upgrades); i++) {
		array_push(_player.upgrades, new global.upgrades[i]())
	}
	
}


function Upgrade() constructor {

	level = 0
	
	static apply = function(_config){}
	
}


global.upgrades = []

function upgrade_register(_type) {
	array_push(global.upgrades, _type)
}

// kill me
function Upgrade_WeaponDefault() : Upgrade() constructor {
	static apply = function(_config) {
		_config.bullet_default += level
	}
}
function Upgrade_WeaponHoming() : Upgrade() constructor {
	static apply = function(_config) {
		_config.bullet_homing += level
	}
}
function Upgrade_WeaponLazer() : Upgrade() constructor {
	static apply = function(_config) {
		_config.bullet_lazer += level
	}
}
function Upgrade_WeaponRound() : Upgrade() constructor {
	static apply = function(_config) {
		_config.bullet_round += level
	}
}
function Upgrade_WeaponHelper() : Upgrade() constructor {
	static apply = function(_config) {
		_config.bullet_helper += level
	}
}
function Upgrade_WeaponCharge() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}

function Upgrade_Speed() : Upgrade() constructor {
	static apply = function(_config){
		_config.moveSpeed_fast += 2 * level;
	}
}

function Upgrade_Reflect() : Upgrade() constructor {
	static apply = function(_config){
		_config.graze_reflectChance = min(_config.graze_reflectChance + 0.05 * level, 0.8);
	}
}

function Upgrade_Shield() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
function Upgrade_Clean() : Upgrade() constructor { // adds object that spins around player and destroys bullets sometimes
	static apply = function(_config){
		
	}
}

function Upgrade_ItemRadius() : Upgrade() constructor {
	static apply = function(_config){
		_config.collectRadius += 16 * level;
	}
}
function Upgrade_ItemPoint() : Upgrade() constructor {
	static apply = function(_config){
		_config.collectPoint += 96 * level;
	}
}

function Upgrade_HookChargeUp() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
function Upgrade_HookChargeAmount() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
function Upgrade_GrazeChargeRetention() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}

