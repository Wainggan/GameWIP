

function game_start(_rm = rm_stage1) {
	global.logger.log("Game started, " + room_get_name(_rm))
	
	room_goto(_rm)
	global.gameActive = 1;
	global.highscore = global.file.save.leaderboard[0].score
	
	global.score = 0;
}
function game_nextRoom(_rm) {
	global.logger.log("Next room: " + room_get_name(_rm))
	
	render.background_reset()
	render.look_default()
	
	instance_create_layer(0, 0, "Instances", obj_roomTransition).roomTarget = _rm;
	
}
function game_stop() {
	global.logger.log("Game end")
	
	global.gameActive = 0;
	
	game_leaderboard_add("debug", global.score);
	
	global.score = 0;
	
	json_writeFrom(FILENAME, global.file);
	
	room_goto(rm_mainmenu);
}
function game_leaderboard_add(_name, _score) {
	var _lb = global.file.save.leaderboard;
	array_push(_lb, { name : _name, score : _score })
	array_sort(_lb, function(a, b){
		return b.score - a.score;
	})
	while array_length(_lb) > LEADERBOARDSIZE {
		array_pop(_lb)
	}
}

function game_music(_s) {
	news_push("music_change", [_s])
}


function text_splash(_x, _y, _text) {
	var _inst = instance_create_layer(_x, _y, "Instances", obj_specialText_score)
	with _inst {
		text = _text;
	}
	return _inst
}
function text_splash_random(_x, _y, _text, _posR = 16, _lifeR = 4, _lifeA = 0) {
	var _inst = instance_create_layer(_x + irandom_range(-_posR, _posR), _y + irandom_range(-_posR, _posR), "Instances", obj_specialText_score)
	with _inst {
		text = _text;
		life += irandom_range(0 + _lifeA, _lifeR + _lifeA)
	}
	return _inst
}

function text_damage_random(_x, _y, _dir, _text, _posR = 16, _lifeR = 4, _lifeA = 0, _spd = 1) {
	var _inst = instance_create_layer(
		_x + irandom_range(-_posR, _posR), 
		_y + irandom_range(-_posR, _posR), 
		"Instances", obj_specialText_damage
	);
	with _inst {
		text = _text;
		x_vel = lengthdir_x(_spd, _dir)
		y_vel = lengthdir_y(_spd, _dir)
		life += irandom_range(0 + _lifeA, _lifeR + _lifeA)
	}
	return _inst
}

function screenShake_set(_amount, _damp = 0.2) {
	global.screenShake = _amount;
	global.screenShakeDamp = _damp;
}

function game_pause(_set = undefined, _music = false) {
	if _set == undefined
		return game.pause;
	game.pause = max(game.pause, _set);
	game.musicPause = _music * _set;
}

function game_focus_set(_a = true) {
	if _a != global.focus with render {
		focusAnimCurve.percent = 0;
		focusAnimCurve.get().start = +!_a;
		focusAnimCurve.get().target = +_a;
	}
	global.focus = _a;
	global.focus_shut = false;
}
function game_focus_shut(_a = true) {
	if _a != global.focus with render {
		focusAnimCurve.percent = 0;
		focusAnimCurve.get().start = +!_a;
		focusAnimCurve.get().target = +_a;
	}
	global.focus = _a;
	global.focus_shut = _a;
}
function game_background(_back = global.currentBackground, _speed = global.currentBackgroundSpeed, _accel = 0.02) {
	global.currentBackground = _back;
	global.currentBackgroundSpeed = _speed;
	render.backgroundSpeedAccel = _accel;
}

function game_menu_open(_page) {
	menu.controller.next(_page)
}
function game_menu_steps(_steps) {
	menu.controller.steps(_steps);
}

function bullet_destroy(_inst) {
	
}

function beat_to_time(_beat, _bpm = music.bpm) {
	return 60 / _bpm * _beat
}
function beat_to_frame(_beat, _bpm = music.bpm) {
	return 60 / _bpm * _beat * 60
}

function particle_burst(_x, _y, _name) {
	particle._burst(_x, _y, _name)
}


function schedule(_time) {
	return (global.time % _time) < (global.lastTime % _time);
}


