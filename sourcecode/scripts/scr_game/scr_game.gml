

function game_start(_rm = rm_stage1) {
	global.logger.log("Game started, " + room_get_name(_rm))
	
	room_goto(_rm)
	global.gameActive = 1;
	global.highscore = global.file.save.leaderboard[0].score
}
function game_nextRoom(_rm) {
	global.logger.log("Next room: " + room_get_name(_rm))
	
	game_background(0, 4, );
	
	instance_create_layer(0, 0, "Instances", obj_roomTransition).roomTarget = _rm;
	
}
function game_stop() {
	global.logger.log("Game end")
	
	global.gameActive = 0;
	
	var _lb = global.file.save.leaderboard;
	array_push(_lb, { name : "debug", score : global.score })
	array_sort(_lb, function(a, b){
		return b.score - a.score;
	})
	while array_length(_lb) > LEADERBOARDSIZE {
		array_pop(_lb)
	}
	
	global.score = 0;
	
	json_writeFrom(FILENAME, global.file);
	
	room_goto(rm_mainmenu);
}
function game_music(_s) {
	news_push("music_change", [_s])
}


function text_splash(_x, _y, _text) {
	with instance_create_layer(_x, _y, "Instances", obj_specialText) {
		text = _text;
	}
}
function text_splash_random(_x, _y, _text, _posR = 16, _lifeR = 4, _lifeA = 0) {
	with instance_create_layer(_x + irandom_range(-_posR, _posR), _y + irandom_range(-_posR, _posR), "Instances", obj_specialText) {
		text = _text;
		life += irandom_range(0 + _lifeA, _lifeR + _lifeA)
	}
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
}
function game_background(_back = global.currentBackground, _speed = global.currentBackgroundSpeed, _accel = 0.03) {
	global.currentBackground = _back;
	global.currentBackgroundSpeed = _speed;
	render.backgroundSpeedAccel = _accel;
}

function bullet_destroy(_inst) {
	
}

function particle_burst(_x, _y, _name) {
	particle._burst(_x, _y, _name)
}


function schedule(_time) {
	return (global.time % _time) < (global.lastTime % _time);
}


