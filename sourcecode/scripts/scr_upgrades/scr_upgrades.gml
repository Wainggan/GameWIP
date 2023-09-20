
function PlayerConfig(_player) constructor {
	
	// player defaults, before any upgrades are applied
	defaults = {
		
		player: _player,
		
		moveSpeed: 5,
		moveSpeed_fast: 5, // when not shooting and not shifting
		moveSpeed_slow: 2, // when shifting
		
		accel: 5,
		slowAccel: 2, // when shifting
		
		collectRadius: 64, // item collection radius
		collectPoint: 0, // touhou-style point of collection
		
		grazeRadius: 38,
		
		grazeReflectChance: 0, // % chance of relfecting grazed bullets
		
		bullet_default: 3,
		bullet_homing: 0,
		bullet_lazer: 0,
		bullet_round: 0,
		bullet_helper: 0,
		
	};
	
}

function player_calculate_upgrade() {
	
	return {}
	
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
		bullet_default += level
	}
}
upgrade_register(Upgrade_WeaponDefault)
function Upgrade_WeaponHoming() : Upgrade() constructor {
	static apply = function(_config) {
		bullet_homing += level
	}
}
upgrade_register(Upgrade_WeaponHoming)
function Upgrade_WeaponLazer() : Upgrade() constructor {
	static apply = function(_config) {
		bullet_lazer += level
	}
}
upgrade_register(Upgrade_WeaponLazer)
function Upgrade_WeaponRound() : Upgrade() constructor {
	static apply = function(_config) {
		bullet_round += level
	}
}
upgrade_register(Upgrade_WeaponRound)
function Upgrade_WeaponHelper() : Upgrade() constructor {
	static apply = function(_config) {
		bullet_helper += level
	}
}
upgrade_register(Upgrade_WeaponHelper)
function Upgrade_WeaponCharge() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_WeaponCharge)

function Upgrade_Speed() : Upgrade() constructor {
	static apply = function(_config){
		_config.fastMoveSpeed += 2 * level;
	}
}
upgrade_register(Upgrade_Speed)

function Upgrade_Reflect() : Upgrade() constructor {
	static apply = function(_config){
		_config.grazeReflectChance = min(_config.grazeReflectChance + 0.05 * level, 0.8);
	}
}
upgrade_register(Upgrade_Reflect)
function Upgrade_Shield() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_Shield)
function Upgrade_Clean() : Upgrade() constructor { // adds object that spins around player and destroys bullets sometimes
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_Clean)


function Upgrade_ItemRadius() : Upgrade() constructor {
	static apply = function(_config){
		_config.collectRadius += 16 * level;
	}
}
upgrade_register(Upgrade_ItemRadius)
function Upgrade_ItemPoint() : Upgrade() constructor {
	static apply = function(_config){
		_config.collectPoint += 96 * level;
	}
}
upgrade_register(Upgrade_ItemRadius)

function Upgrade_HookChargeUp() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_HookChargeUp)
function Upgrade_HookChargeAmount() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_HookChargeAmount)
function Upgrade_GrazeChargeRetention() : Upgrade() constructor {
	static apply = function(_config){
		
	}
}
upgrade_register(Upgrade_GrazeChargeRetention)

