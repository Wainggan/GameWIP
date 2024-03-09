func_inputUpdate(input.check("left"),
				input.check("right"),
				input.check("up"),
				input.check("down"))

var _lastX = x;
var _lastY = y;

canShoot = instance_number(obj_textbox) == 0 && instance_number(obj_roomTransition) == 0;

if keyboard_check_pressed(ord("1"))
	debug_invincible = !debug_invincible

if debug_invincible
	mask_index = spr_nothing
else
	mask_index = spr_player_hitbox

state.run()

mask_index = spr_player_hitbox

var _collectables = ds_list_create();
instance_place_list(x, y, obj_collectable, _collectables, false);

for (var i = 0; i < ds_list_size(_collectables); i++) {
	
	with _collectables[| i] {
		global.score += scoreGive;
		if scoreGive > 0 {
			var _dir = random_range(0, 360)
			text_splash_random(
				x + lengthdir_x(64, _dir), 
				y + lengthdir_y(64, _dir), 
				scoreGive, 16, 6, 2
			);
		}
		obj_player.func_handleCollectable(self)
		if func != undefined func();
		if sprite_index != spr_collectable_graze
			sound.play(snd_collectItem)
		instance_destroy();
	}
	
}

ds_list_destroy(_collectables)


shakeAmount -= global.delta_multiNP * shakeDamp

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

if DEBUG if keyboard_check_pressed(ord("T")) bullet_laser(x, y + 64, 90, 20, 60)

if !game_pause() dir_graphic = (x - _lastX) / global.delta_multi;

grazeHitboxGraphicShow = max(grazeHitboxGraphicShow-grazeHitboxGraphicShowSpeed * global.delta_multi, 0)

if !game_pause()
for (var i = 0; i < array_length(tails); i++) {
	//tails[i][0].x = round(x) - 1;
	//tails[i][0].y = round(y) + 7;
	
	//var _lastX = tails[i][0].x;
	//var _lastY = tails[i][0].y;
	//var _lastDir = undefined;
	
	
	//for (var j = 1; j < array_length(tails[i]); j++) {
	//	var p = tails[i][j];
		
	//	var _dir = sin(global.time / 60 / 1 + j * 0.4 + i * 3.14) * 2;
	//	var _spreadAngle = wave(50, 70, 24);
	//	var _tailDir = (wave(-4, 4, 20) - 90 + -_spreadAngle/2) - (-_spreadAngle/max(array_length(tails)-1, 1) * i);
	//	var _force = power(max(1 - j / 8, 0), 8)
	//	var _waveMag = 0.4, _uMag = 0.2 * _force
	//	//var _force = power(max(1 - j / array_length(tails[i]), 0), 8)
		
		
	//	p.x_vel = lengthdir_x(_waveMag, p.dir + _dir) + lengthdir_x(_uMag, _tailDir);
	//	p.y_vel = lengthdir_y(_waveMag, p.dir + _dir) + lengthdir_y(_uMag, _tailDir) + _force * 0.3;
	
	//	var _angle = point_direction(p.x + p.x_vel * global.delta_multi, p.y + p.y_vel * global.delta_multi, _lastX, _lastY);
	//	if _lastDir == undefined _lastDir = _angle;
	
	//	var _diff = (((_angle - _lastDir) + 180) % 360 + 360) % 360 - 180;
	//	_diff *= p.damp;
		
		
	
	//	p.dir = _lastDir + _diff;
	//	p.x = _lastX - lengthdir_x(p.len, p.dir);
	//	p.y = _lastY - lengthdir_y(p.len, p.dir);
	
	//	_lastX = p.x;
	//	_lastY = p.y;
	//	_lastDir = p.dir;
	//}
	
	tails[i].position(round(x) - 1, round(y) + 7)
	
	// workaround for lack of closures
	self.i = i
	tails[i].update(global.delta_multi, function(_p, j) {
		
		var _dir = sin(global.time / 60 / 1 + j * 0.4 + i * 3.14) * 2;
		var _spreadAngle = wave(50, 70, 24);
		var _tailDir = (wave(-4, 4, 20) - 90 + -_spreadAngle/2) - (-_spreadAngle/max(array_length(tails)-1, 1) * i);
		var _force = power(max(1 - j / 8, 0), 8)
		var _waveMag = 0.4, _uMag = 0.2 * _force
		//var _force = power(max(1 - j / array_length(tails[i]), 0), 8)
		
		_p.x_accel = lengthdir_x(_waveMag, _p.dir + _dir) + lengthdir_x(_uMag, _tailDir);
		_p.y_accel = lengthdir_y(_waveMag, _p.dir + _dir) + lengthdir_y(_uMag, _tailDir) + _force * 0.3;
		
	})
	
}

hairTuft.shift(round(x_vel * 0.5), round(y_vel))
hairTuft.position(round(x) - 2 + moveAnim.value * 0.5, round(y) - 22)
hairTuft.update(global.delta_multi, function(_p, j) {
	_p.y_accel = -2
}, function(_p, j) {
	_p.dir = clamp(_p.dir, 270 - 30, 270 + 30)
})
