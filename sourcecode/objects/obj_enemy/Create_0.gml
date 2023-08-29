active = false

x_vel = 0;
y_vel = 0;

onGround = false;

hp = 2;
maxhp = hp
scoreGive = 1000;
pointGive = 1;

setHp = function(_hp) {
	hp = _hp;
	maxhp = _hp;
}

setPoints = function(_direct, _item) {
	scoreGive = _direct;
	pointGive = _item
}

setSprite = function(_sprite) {
	sprite_index = _sprite;
}

hpModArray = undefined;
currentHpMod = 0;
hpMod = function(_arr){
	hpModArray = _arr;
	currentHpMod = 0;
}

shakeAmount = 0;
shakeFix = undefined;

hitAnim = 0;

invinsible = false;
important = false;
importantAnim = new Sod(3, 1, -1);
ignoreSlap = false;
alarm[0] = 1;
canDie = true;
destroyAll = false
bossFlag = false;

command_setup()

time = function(_time = -1, _mt = timerMin, _tma = undefined){
	if is_array(_time) {
		timerMod = _time;
		currentTimerMod = 0;
		timer = -1;
		ftime = -1;
	} else {
		timer = _time == -1 ? -1 : 0;
		ftime = _time;
		timerMod = undefined;
	}
	if _mt > 0
		_tma = true;
	else _tma = false;
	timerMin = _mt;
	timerMinActive = _tma;
}

timer = -1; // TODO: implement boss timer
ftime = -1;
timerMod = undefined;
currentTimerMod = 0;
timerMin = 0;
timerMinActive = false;

deathRadius = 32

xOff = 0;
yOff = 0;

parent = noone;

func_nextAttack = function(){
	
	static _func = function() {
		if hpModArray != undefined && currentHpMod < array_length(hpModArray) {
			hpModArray[currentHpMod++]();
			screenShake_set(2, 0.2);
			game_pause(2)
			return;
		}
		func_nextAttack();
		with instance_create_layer(x, y, layer, obj_bulletDestroyer) { // bad idea
			targetSize = 128
			sizeSpeed = 32;
			bulletBonus = false;
			destroy = true;
		}
		if !canDie {
			screenShake_set(4, 0.2);
			game_pause(8)
			shakeAmount = 8;
		} else {
			screenShake_set(5, 0.2);
			//instance_create_layer(0, 0, "Instances", obj_koSplash);
			game_pause(26)
			shakeAmount = 26
			audio_play_sound(snd_explosion1, 20, false);
			__onDeath();
		}
	};
	if onDeath != undefined && onDeath != _func __onDeath = onDeath;
	else __onDeath = function(){};
	onDeath = _func;
	command_timer_reset()
	command_reset();
	movement_stop();
	if currentAttack < array_length(attacks) {
		hp = 1;
		invinsible = true;
		destroyAll = true;
		command_timer((timerMin ? timerMin : 0) + 30, function(){
			invinsible = false;
			attacks[currentAttack]();
			maxhp = hp;
			currentAttack++;
		});
		time(, 0, false)
	} else {
		canDie = true;
	}
}
currentAttack = 0;
attacks = []


currentPattern = -1
patterns = []

currentPhase = -1;
phases = []

phaseTimer = 0
phaseStartTimer = -1;

phaseActive = false

setPatterns = function(_patterns) {
	patterns = _patterns
	currentPattern = 0
}

nextPattern = function() {
	phaseActive = true
	currentPattern++
	if currentPattern >= array_length(phases[currentPhase].patterns)
		currentPattern = 0
	startPattern()
}

setPhases = function(_phases) {
	phases = _phases
	currentPhase = 0
}

// multiplied by timer in seconds to get hp
#macro MAGIC_HEALTH_MULTIPLIER 28

startPhase = function(_index = currentPhase, _compensation = 0) {
	
	var _phase = phases[_index]
	
	// if prev phase ended early, pause
	// if prev phase ended late, shorten this phase via hp
	var _shorten = clamp(_compensation, 0, 4)
	var _pause = abs(clamp(_compensation, -3, 0))
	
	var _hp = (_phase.time - _shorten) * MAGIC_HEALTH_MULTIPLIER
	
	setHp(_hp)
	
	show_debug_message($"prev pause {phaseStartTimer}, time {phaseTimer}")
	show_debug_message($"comp {_compensation}:: short {_shorten}, pause {_pause}, {hp}")
	
	phaseTimer = 0
	
	currentPattern = _phase.force
	
	_phase.run()
	
	phaseStartTimer = _pause

}

nextPhase = function () {
	stopPattern()
	currentPhase++
	if currentPhase < array_length(phases) {
		startPhase(, phaseTimer - phases[currentPhase - 1].time)
		return true
	}
	return false
}

startPattern = function(_index = currentPattern) {
	// uuhhh i ummmm
	patterns[phases[currentPhase].patterns[_index]].run(self)
}
stopPattern = function(_index = currentPattern) {
	patterns[phases[currentPhase].patterns[_index]].stop()
}


setBoss = function() {
	bossFlag = true
	ignoreSlap = true
	important = true
	destroyAll = true
	deathRadius = WIDTH * 2;
}

setInvincible = function(_b) {
	invinsible = _b
}




// magic animation offset number
test = random_range(0, 1000)

directionToMove = sign(WIDTH/2 - x);

step = function(){}

onLoad = function(){}
onHit = function(){}
onDeath = function(){}

