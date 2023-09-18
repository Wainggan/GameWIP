
function movement_setup() {
	movement_animCurve = undefined
	movement_frameFunc = undefined
}

function movement_start(_targetx, _targety, _speed, _type = "smooth", _func = function(){}) {
	movement_animCurve = new AnimCurve(_type)
		.add("x", x, _targetx)
		.add("y", y, _targety);
	movement_speed = _speed;
	movement_func = _func;
}
function movement_update() { // todo: replace with != undefined for speed
	if movement_animCurve != undefined {
		movement_animCurve.percent = min(movement_animCurve.percent + movement_speed * global.delta_multi, 1);
		x = movement_animCurve.evaluate("x");
		y = movement_animCurve.evaluate("y");
		if movement_animCurve.percent >= 1 {
			movement_animCurve = undefined;
			movement_func();
		}
	}
	if movement_frameFunc != undefined  movement_frameFunc();
}
function movement_stop() {
	movement_animCurve = undefined;
}
function movement_frame(_func) {
	movement_frameFunc = _func;
}
function movement_finished() {
	return movement_animCurve == undefined;
}