
function YarnPoint() constructor {
	x = 0;
	y = 0;
	x_vel = 0;
	y_vel = 0;
	x_accel = 0;
	y_accel = 0;
	damp = 1;
	dir = 0;
	len = 10;
}

function Yarn() constructor {
	
	points = []
	
	static add = function(_p) {
		array_push(points, _p)
	}
	
	static position = function(_x, _y) {
		if array_length(points) == 0 return;
		points[0].x = _x;
		points[0].y = _y;
	}
	
	static shift = function(_offX, _offY) {
		for (var i = 0; i < array_length(points); i++) {
			points[i].x += _offX;
			points[i].y += _offY;
		}
	}
	
	static update = function(_delta = 1, _callback = undefined, _postCallback = undefined) {
		if array_length(points) == 0 return;
	
		var _lastX = points[0].x;
		var _lastY = points[0].y;
		var _lastDir = undefined;
	
		for (var i = 1; i < array_length(points); i++) {
			var _p = points[i];
			
			_p.x_accel = 0;
			_p.y_accel = 0;
			
			if _callback _callback(_p, i, points)
			
			_p.x_vel = _p.x_accel;
			_p.y_vel = _p.y_accel;
			
			var _angle = point_direction(_p.x + _p.x_vel * _delta, _p.y + _p.y_vel * _delta, _lastX, _lastY);
			if _lastDir == undefined _lastDir = _angle;
			
			var _diff = (((_angle - _lastDir) + 180) % 360 + 360) % 360 - 180;
			_diff *= _p.damp;
			
			_p.dir = _lastDir + _diff;
			
			if _postCallback _postCallback(_p, i)
			
			_p.x = _lastX - lengthdir_x(_p.len, _p.dir);
			_p.y = _lastY - lengthdir_y(_p.len, _p.dir);
			
			_lastX = _p.x;
			_lastY = _p.y;
			_lastDir = _p.dir;
		}
	}
	
	static loop = function(_callback) {
		
		for (var i = 0; i < array_length(points); i++) {
			var _p = points[i];
			if _callback _callback(_p, i, points)
		}
		
	}
	
}

function yarn_create(_length, _callback) {
	var _yarn = new Yarn()
	for (var i = 0; i < _length; i++) { // 10
		var _p = new YarnPoint();
		
		if _callback _callback(_p, i)
		
		_yarn.add(_p)
	}
	return _yarn
}



