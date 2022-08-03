function movement_start(_targetx, _targety, _speed, _type = "smooth", _func = function(){}) {
	movement_animCurve = new AnimCurve(_type)
		.add("x", x, _targetx)
		.add("y", y, _targety);
	movement_speed = _speed;
	movement_func = _func;
}
function movement_update() {
	if variable_instance_exists(self, "movement_animCurve") 
		&& movement_animCurve != undefined {
		movement_animCurve.percent = min(movement_animCurve.percent + movement_speed, 1);
		x = movement_animCurve.evaluate("x");
		y = movement_animCurve.evaluate("y");
		if movement_animCurve.percent >= 1 {
			movement_animCurve = undefined;
			movement_func();
		}
	}
}
function movement_finished() {
	return !variable_instance_exists(self, "movement_animCurve") 
		|| movement_animCurve == undefined;
}