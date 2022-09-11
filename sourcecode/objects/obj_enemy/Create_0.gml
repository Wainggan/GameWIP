active = false

x_vel = 0;
y_vel = 0;

hp = 2;
maxhp = hp
scoreGive = 1000;
pointGive = 1;

hitAnim = 0;

invinsible = false;
important = false;
canDie = true;

deathRadius = 16

xOff = 0;
yOff = 0;

parent = noone;

func_nextAttack = function(){
	static _func = function() {
		func_nextAttack();
		if !canDie {
			screenShake_set(5, 0.2);
			global.pause = 4;
		} else {
			screenShake_set(6, 0.1);
			//instance_create_layer(0, 0, "Instances", obj_koSplash);
			global.pause = 26;
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

onLoad = function(){}
onDeath = function(){}
