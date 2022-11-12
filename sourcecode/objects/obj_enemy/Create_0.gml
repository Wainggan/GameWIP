active = false

x_vel = 0;
y_vel = 0;

onGround = false;

hp = 2;
maxhp = hp
scoreGive = 1000;
pointGive = 1;

hpMod = undefined;

hitAnim = 0;

invinsible = false;
important = false;
canDie = true;
destroyAll = false

deathRadius = 16

xOff = 0;
yOff = 0;

parent = noone;

func_nextAttack = function(){
	
	static _func = function() {
		if hpMod != undefined {
			hpMod[0]();
			array_delete(hpMod, 0, 1);
			if array_length(hpMod) == 0 hpMod = undefined;
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
		command_timer(50, function(){
			invinsible = false;
			attacks[currentAttack]();
			maxhp = hp;
			currentAttack++;
		});
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
onDeath = function(){}
