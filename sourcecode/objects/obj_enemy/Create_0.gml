active = false

x_vel = 0;
y_vel = 0;

hp = 2;
maxhp = hp
scoreGive = 1000;

hitAnim = 0;

invinsible = false;
important = false;
canDie = true;

deathRadius = 16

xOff = 0;
yOff = 0;

parent = noone;

func_nextAttack = function(){
	onDeath = func_nextAttack;
	command_reset();
	movement_stop();
	if currentAttack < array_length(attacks) {
		hp = 1;
		invinsible = true;
		command_timer(30, function(){
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
