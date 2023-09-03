func_inputUpdate(input.check("left"),
				input.check("right"),
				input.check("up"),
				input.check("down"))

var _lastX = x;
var _lastY = y;

canShoot = instance_number(obj_textbox) == 0 && instance_number(obj_roomTransition) == 0;

mask_index = spr_player_hitbox

state.run()

for (var i = 0; i < array_length(bulletLaserList); i++) {
	var _bl = bulletLaserList[i];
	_bl.x = x + _bl.xOff
	_bl.y = y + _bl.yOff
	_bl.active = isShooting;
}

shakeAmount -= global.delta_multiNP

iFrames -= global.delta_multi


grazeComboTimer -= instance_number(obj_bullet) ? global.delta_multi : 0
if grazeComboTimer <= 0 {
	grazeCombo = 0;
}


var _grazeArray = variable_struct_get_names(grazeBulletList);
for (var i = 0; i < min(array_length(_grazeArray), 200); i++) {
	grazeBulletList[$ _grazeArray[i]] -= global.delta_multi;
	if grazeBulletList[$ _grazeArray[i]] <= 0 {
		variable_struct_remove(grazeBulletList, _grazeArray[i]);
	}
}

if keyboard_check_pressed(ord("T")) bullet_laser(x, y + 64, 90, 20, 60)

if !game_pause() dir_graphic = (x - _lastX) / global.delta_multi;

grazeHitboxGraphicShow = max(grazeHitboxGraphicShow-grazeHitboxGraphicShowSpeed * global.delta_multi, 0)

if !game_pause()
for (var i = 0; i < array_length(tails); i++) {
	tails[i][0].x = round(x) - 1;
	tails[i][0].y = round(y) + 7;
	
	var _lastX = tails[i][0].x;
	var _lastY = tails[i][0].y;
	var _lastDir = undefined;
	
	
	for (var j = 1; j < array_length(tails[i]); j++) {
		var p = tails[i][j];
		
		var _dir = sin(global.time / 60 / 1 + j * 0.4 + i * 3.14) * 2;
		var _spreadAngle = wave(50, 70, 24);
		var _tailDir = (wave(-4, 4, 20) - 90 + -_spreadAngle/2) - (-_spreadAngle/max(array_length(tails)-1, 1) * i);
		var _force = power(max(1 - j / 8, 0), 8)
		var _waveMag = 0.2, _uMag = 0.1 * _force
		//var _force = power(max(1 - j / array_length(tails[i]), 0), 8)
		
		
		p.x_vel = lengthdir_x(_waveMag, p.dir + _dir) + lengthdir_x(_uMag, _tailDir);
		p.y_vel = lengthdir_y(_waveMag, p.dir + _dir) + lengthdir_y(_uMag, _tailDir) + _force;
	
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
