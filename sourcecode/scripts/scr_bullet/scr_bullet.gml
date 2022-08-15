#macro cb_red make_color_rgb(238, 10, 91)
#macro cb_blue make_color_rgb(10, 91, 238)
#macro cb_green make_color_rgb(10, 238, 91)

#macro cb_yellow make_color_rgb(245, 209, 81)
#macro cb_pink make_color_rgb(209, 81, 245)
#macro cb_teal make_color_rgb(81, 245, 209)

#macro cb_grey make_color_rgb(92, 92, 92)

global.bullet_currentGroup = undefined;

function bullet_shoot(_x, _y, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.fade = _delay;
		self.fadeTime = _delay;
	}
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_dir(_x, _y, _speed, _angle, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.spd = _speed;
		self.dir = _angle;
		
		self.fade = _delay;
		self.fadeTime = _delay;
	}
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_dir2(_x, _y, _speed, _accel, _targetSpd, _angle, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.spd = _speed;
		self.spd_accel = _accel;
		self.spd_target = _targetSpd;
		self.dir = _angle;
		
		self.fade = _delay;
		self.fadeTime = _delay;
	}
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_shoot_vel(_x, _y, _xvel, _yvel, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.x_vel = _xvel;
		self.y_vel = _yvel;
		
		self.fade = _delay;
		self.fadeTime = _delay;
	}
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}
function bullet_shoot_vel2(_x, _y, _xvel, _yvel, _xaccel, _yaccel, _xtarget, _ytarget, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.x_vel = _xvel;
		self.y_vel = _yvel;
		self.x_accel = _xaccel;
		self.y_accel = _yaccel;
		self.x_target = _xtarget;
		self.y_target = _ytarget;
		
		self.fade = _delay;
		self.fadeTime = _delay;
	}
	if global.bullet_currentGroup != undefined
		global.bullet_currentGroup.add(_inst);
	return _inst;
}

function bullet_preset_ring(_x, _y, _amount, _rad, _dir, _func = function(_x, _y, _dir){}) {
	for (var i = 0; i < _amount; i++) {
		_func(_x + lengthdir_x(_rad, _dir), _y + lengthdir_y(_rad, _dir), _dir);
		_dir += 360 / _amount;
	}
}
function bullet_preset_plate(_x, _y, _amount, _spreadDist, _spreadAngle, _len, _dir, _func = function(_x, _y, _dir){}) {
	if _amount <= 1 {
		_func(_x + lengthdir_x(_len, _dir), _y + lengthdir_y(_len, _dir), _dir);
		return;
	}
	for (var i = 0; i < _amount; i++) {
		var _newDir = (_dir + -_spreadAngle/2) - (-_spreadAngle/(_amount-1) * i)
		var _offset = _spreadDist * (_amount - 1 - (i * 2))
		_func(_x + lengthdir_x(_offset, _newDir - 90) + lengthdir_x(_len, _newDir), 
			_y + lengthdir_y(_offset, _newDir - 90) + lengthdir_y(_len, _newDir), _newDir);
	}
}
function bullet_preset_poly(_x, _y, _sides, _amount, _length, _func = function(_x, _y, _dir){}) {
	var _points = [];
	for (var i = 0; i < _sides; i++) {
		var p = {
			x: lengthdir_x(_length, i / _sides * 360),
			y: lengthdir_y(_length, i / _sides * 360),
		};
		p.dir = point_direction(p.x, p.y, 
			lengthdir_x(_length, (i + 1) / _sides * 360),
			lengthdir_y(_length, (i + 1) / _sides * 360)
		);
		array_push(_points, p);
	}
	for (var i = 0; i < array_length(_points); i++) {
		var p = _points[i];
		for (var j = 0; j < _amount; j++) {
			_func(
				p.x + (_points[i + 1 < _sides ? i + 1 : 0].x - p.x) * (j / _amount) + _x,
				p.y + (_points[i + 1 < _sides ? i + 1 : 0].y - p.y) * (j / _amount) + _y,
				p.dir
			);
		}
	}
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