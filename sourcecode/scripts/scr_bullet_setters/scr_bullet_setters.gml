
function bullet_promote(_inst, _level) {
	var _v = 0;
	if _inst.behaviour = bullet_behaviour_1 _v = 1;
	if _inst.behaviour = bullet_behaviour_2 _v = 2;
	if _level > _v {
		if _level == 1 _inst.behaviour = bullet_behaviour_1;
		if _level == 2 _inst.behaviour = bullet_behaviour_2;
	}
}

function bullet_set_fade(_inst = self, _amount) {
	_inst.fade = _amount;
	_inst.fadeTime = _amount;
}

function bullet_set_look(_inst = self, _sprite = _inst.sprite_index, _glow = _inst.glow) {
	_inst.sprite_index = _sprite;
	_inst.glow = _glow
}

function bullet_set_dborder(_inst = self, _padding) {
	_inst.deathBorder = _padding;
}


function bullet_set_vel(_inst = self, _x_vel, _y_vel) {
	_inst.x_vel = _x_vel;
	_inst.y_vel = _y_vel;
}

function bullet_set_spd(_inst = self, _spd, _dir) {
	_inst.spd = _spd;
	_inst.dir = _dir;
}

function bullet_set_spd_target(_inst = self, _spd_accel, _spd_target) {
	_inst.spd_accel = _spd_accel;
	_inst.spd_target = _spd_target;
}

function bullet_set_spd_target2(_inst = self, _spd_accel2, _spd_target2) {
	_inst.spd_accel2 = _spd_accel2;
	_inst.spd_target2 = _spd_target2;
	
	bullet_promote(_inst, 1);
}

function bullet_set_dir_target(_inst = self, _dir_accel, _dir_target) {
	_inst.dir_accel = _dir_accel;
	_inst.dir_target = _dir_target;
	
	bullet_promote(_inst, 2);
}

function bullet_set_vel_target_x(_inst = self, _x_accel, _x_target) {
	_inst.x_accel = _x_accel;
	_inst.x_target = _x_target;
	
	bullet_promote(_inst, 1);
}
function bullet_set_vel_target_y(_inst = self, _y_accel, _y_target) {
	_inst.y_accel = _y_accel;
	_inst.y_target = _y_target;
	
	bullet_promote(_inst, 1);
}

function bullet_set_step(_inst = self, _step) {
	_inst.step = _step;
	
	bullet_promote(_inst, 2);
}

function bullet_set_command(_inst = self) {
	bullet_promote(_inst, 2)
}

