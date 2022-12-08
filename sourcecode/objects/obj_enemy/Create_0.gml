active = false

x_vel = 0;
y_vel = 0;

onGround = false;

hp = 2;
maxhp = hp
scoreGive = 1000;
pointGive = 1;

hpModArray = undefined;
currentHpMod = 0;
hpMod = function(_arr){
	hpModArray = _arr;
	currentHpMod = 0;
}


hitAnim = 0;

invinsible = false;
important = false;
canDie = true;
destroyAll = false

time = function(_time = -1, _mt = timerMin){
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
	timerMin = _mt;
}

timer = -1; // TODO: implement boss timer
ftime = -1;
timerMod = undefined;
currentTimerMod = 0;
timerMin = 0;

deathRadius = 16

xOff = 0;
yOff = 0;

parent = noone;

func_nextAttack = function(){
	
	static _func = function() {
		if hpModArray != undefined && currentHpMod < array_length(hpModArray) {
			hpModArray[currentHpMod++]();
			screenShake_set(2, 0.2);
			global.pause = 2;
			return;
		}
		func_nextAttack();
		if !canDie {
			screenShake_set(5, 0.2);
			global.pause = 4;
		} else {
			screenShake_set(6, 0.1);
			//instance_create_layer(0, 0, "Instances", obj_koSplash);
			global.pause = 26;
			audio_play_sound(snd_explosion1, 20, false);
			__onDeath();
		}
		game_focus_set(false);
	};
	if onDeath != undefined && onDeath != _func __onDeath = onDeath;
	else __onDeath = function(){};
	onDeath = _func;
	command_reset();
	movement_stop();
	if currentAttack < array_length(attacks) {
		hp = 1;
		invinsible = true;
		destroyAll = true;
		command_timer(timerMin + 30, function(){
			invinsible = false;
			attacks[currentAttack]();
			maxhp = hp;
			currentAttack++;
		});
		time(, 0)
	} else {
		canDie = true;
	}
}
currentAttack = 0;
attacks = []

test = random_range(0, 1000)

directionToMove = sign(WIDTH/2 - x);

step = function(){}

onLoad = function(){}
onHit = function(){}
onDeath = function(){}
