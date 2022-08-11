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
lastParent = noone;

test = random_range(0, 1000)

directionToMove = sign(WIDTH/2 - x);

onLoad = function(){}
onDeath = function(){}
