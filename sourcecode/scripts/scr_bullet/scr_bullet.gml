function bullet_shoot(_x, _y, _delay = 8) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_bullet);
	with _inst {
		self.fade = _delay;
		self.fadeTime = _delay;
	}
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
	return _inst;
}
