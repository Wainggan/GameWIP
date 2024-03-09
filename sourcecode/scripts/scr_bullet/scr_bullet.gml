

global.bullet_currentGroup = undefined;

function bullet_shoot(_x, _y, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_dir(_x, _y, _speed, _angle, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);

	bullet_set_spd(_inst, _speed, _angle)
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_dir2(_x, _y, _speed, _accel, _targetSpd, _angle, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);

	bullet_set_spd(_inst, _speed, _angle)
	bullet_set_spd_target(_inst, _accel, _targetSpd)
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}
function bullet_shoot_dir3(_x, _y, _speed, _accel, _targetSpd, _accel2, _targetSpd2, _angle, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);

	bullet_set_spd(_inst, _speed, _angle)
	bullet_set_spd_target(_inst, _accel, _targetSpd)
	bullet_set_spd_target2(_inst, _accel2, _targetSpd2)
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_vel(_x, _y, _xvel, _yvel, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);

	bullet_set_vel(_inst, _xvel, _yvel)
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}
function bullet_shoot_vel2(_x, _y, _xvel, _yvel, _xaccel, _yaccel, _xtarget, _ytarget, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);

	bullet_set_vel(_inst, _xvel, _yvel)
	bullet_set_vel_target_x(_inst, _xaccel, _xtarget)
	bullet_set_vel_target_x(_inst, _yaccel, _ytarget)
	bullet_set_fade(_inst, _delay);
	
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_laser(_x, _y, _dir, _life = undefined, _chargeUp = 16) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_laser);
	with _inst {
		self.angle = _dir;
		
		
		startTime = 8;
		fade = _chargeUp + startTime;
		fadeTime = _chargeUp + startTime;
		life = _life != undefined ? _life + (fadeTime + endTime) : _life;
	}
	bullet_promote(_inst, 2)
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}
function bullet_laser2(_x, _y, _dir, _dirAccel, _dirTarget, _life = undefined) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_laser);
	with _inst {
		self.angle = _dir;
		self.angle_accel = _dir;
		self.angle_target = _dir;
		
		life = _life;
	}
	bullet_promote(_inst, 2)
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_preset_ring(_x, _y, _amount, _rad, _dir, _func = function(_x, _y, _dir, i){}) {
	for (var i = 0; i < _amount; i++) {
		_func(_x + lengthdir_x(_rad, _dir), _y + lengthdir_y(_rad, _dir), _dir, i);
		_dir += 360 / _amount;
	}
}
function bullet_preset_plate(_x, _y, _amount, _spreadDist, _spreadAngle, _len, _dir, _func = function(_x, _y, _dir, i){}) {
	if _amount == 0
		return;
	if _amount == 1 {
		_func(_x + lengthdir_x(_len, _dir), _y + lengthdir_y(_len, _dir), _dir, 0);
		return;
	}
	for (var i = 0; i < _amount; i++) {
		var _newDir = (_dir + -_spreadAngle/2) - (-_spreadAngle/(_amount-1) * i)
		var _offset = _spreadDist * (_amount - 1 - (i * 2))
		_func(_x + lengthdir_x(_offset, _newDir - 90) + lengthdir_x(_len, _newDir), 
			_y + lengthdir_y(_offset, _newDir - 90) + lengthdir_y(_len, _newDir), _newDir, i);
	}
}
function bullet_preset_poly(_x, _y, _sides, _amount, _length, _dir, _func = function(_x, _y, _dir, i){}) {
	var _points = [];
	for (var i = 0; i < _sides; i++) {
		var p = {
			x: lengthdir_x(_length, i / _sides * 360 + _dir),
			y: lengthdir_y(_length, i / _sides * 360 + _dir),
		};
		p.dir = point_direction(p.x, p.y, 
			lengthdir_x(_length, (i + 1) / _sides * 360 + _dir),
			lengthdir_y(_length, (i + 1) / _sides * 360 + _dir)
		);
		array_push(_points, p);
	}
	for (var i = 0; i < array_length(_points); i++) {
		var p = _points[i];
		for (var j = 0; j < _amount; j++) {
			_func(
				p.x + (_points[i + 1 < _sides ? i + 1 : 0].x - p.x) * (j / _amount) + _x,
				p.y + (_points[i + 1 < _sides ? i + 1 : 0].y - p.y) * (j / _amount) + _y,
				p.dir, (i + 1) * j
			);
		}
	}
}
function bullet_preset_line(_x, _y, _x2, _y2, _res, _start = 0, _off = 0, _func = function(_x, _y, _dir, i){}) {
	var _dist = point_distance(_x, _y, _x2, _y2);
	var _dir = point_direction(_x, _y, _x2, _y2)
	for (var i = _start; i < _res - _off; i++) {
		_func(_x + (_x2 - _x) * (i / _res), _y + (_y2 - _y) * (i / _res), _dir, i);
	}
}
function bullet_preset_line2(_x, _y, _dir, _len, _amount, _func = function(_x, _y, _dir, i){}) {
	for (var i = 0; i < _amount; i++) {
		_func(_x, _y, _dir, i);
		_x += lengthdir_x(_len, _dir);
		_y += lengthdir_y(_len, _dir);
	}
}
function bullet_preset_golden(_x, _y, _len, _amount, _iteration, _func = function(_x, _y, _dir, i){}) {
	static ratio = 1.6180339;
	var dir = _iteration * ratio * 360;
	for (var i = 0; i < abs(_amount); i++) {
		_func(_x + lengthdir_x(_len, dir), _y + lengthdir_y(_len, dir), dir, i);
		dir += 360 / ratio;
	}
	return _iteration + _amount;
}

function bullet_group_start(_x, _y) {
	var inst = instance_create_layer(_x, _y, "Instances", obj_bulletGroup);
	global.bullet_currentGroup = inst;
	return inst;
}

function bullet_group_end() {
	var inst = global.bullet_currentGroup;
	global.bullet_currentGroup = undefined;
	return inst;
}