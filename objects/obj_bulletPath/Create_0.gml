/*
[deltaX, deltaY, speed]
*/
defaultPattern = [
	[64, 0, 1],
	[64, 23, 2]
]

bPToShoot = bP_aimPlayerDirect;
bPReload = 16;
reloadTime = bPReload;

parent = noone;

bulletPattern = defaultPattern;
bulletPatternTimeline = -1;

targetX = 0;
targetY = 0;