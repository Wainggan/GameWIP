func_inputUpdate(input.check("left"),
				input.check("right"),
				input.check("up"),
				input.check("down"))

var _lastX = x;
var _lastY = y;

state.run()

iFrames -= global.delta_multi
reloadTime -= global.delta_multi
grazeComboTimer -= instance_number(obj_bullet) ? global.delta_multi : 0
if grazeComboTimer <= 0 {
	grazeCombo = 0;
}


var _grazeArray = variable_struct_get_names(grazeBulletList);
for (var i = 0; i < array_length(_grazeArray); i++) {
	grazeBulletList[$ _grazeArray[i]] -= global.delta_multi;
	if grazeBulletList[$ _grazeArray[i]] <= 0 {
		variable_struct_remove(grazeBulletList, _grazeArray[i]);
	}
}

if !global.pause dir_graphic = (x - _lastX) / global.delta_multi;

grazeHitboxGraphicShow = max(grazeHitboxGraphicShow-grazeHitboxGraphicShowSpeed * global.delta_multi, 0)

if !global.pause
for (var i = 0; i < array_length(tails); i++) {
	tails[i][0].x = round(x) - 1;
	tails[i][0].y = round(y) + 7;
	
	var _lastX = tails[i][0].x;
	var _lastY = tails[i][0].y;
	var _lastDir = undefined;
	
	
	for (var j = 1; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		
		var _dir = sin(global.time / 60 / 1 + j * 0.4 + i * 3.14) * 2;
		var _spreadAngle = wave(30, 50, 24);
		var _tailDir = (wave(-4, 4, 20) - 90 + -_spreadAngle/2) - (-_spreadAngle/(array_length(tails)-1) * i);
		p.x_vel = lengthdir_x(1, p.dir + _dir) + lengthdir_x(0.01, _tailDir);
		p.y_vel = lengthdir_y(1, p.dir + _dir) + lengthdir_y(0.01, _tailDir) + 0.04;
	
		var _angle = point_direction(p.x + p.x_vel * global.delta_multi, p.y + p.y_vel * global.delta_multi, _lastX, _lastY);
		if _lastDir == undefined _lastDir = _angle;
	
		var _diff = (((_angle - _lastDir) + 180) % 360 + 360) % 360 - 180;
		_diff *= p.damp;
	
		p.dir = _lastDir + _diff;
		p.x = _lastX - lengthdir_x(p.len, p.dir);
		p.y = _lastY - lengthdir_y(p.len, p.dir);
	
		_lastX = p.x;
		_lastY = p.y;
		_lastDir = p.dir;
	}
	
}
