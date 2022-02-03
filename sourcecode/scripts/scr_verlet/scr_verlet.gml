function RopeManager() constructor {
	points = [];
	sticks = [];
	iterations = 10;
	
	createRope = function(_x, _y, _amount) {
	    for (var i = 0; i < _amount; i++) {
		    var p = new RopePoint(_x, _y + i)
			array_push(points, p)
		    if (i >= 1) {
				var s = new RopeStick(points[i-1], points[i])
				array_push(sticks, s)
		    }
	    }
	}
	
	update = function(_mult = 1){
		for (var i = 0; i < array_length(points); i++) {
			points[i].update(_mult);
		}
		repeat (iterations) {
			for (var i = 0; i < array_length(sticks); i++) {
				sticks[i].update();
			}
		}
	}
	
	points_applyFunc = function(_func = function(_p, _i, _d){}) {
		var _lastPoint = points[0];
		for (var i = 0; i < array_length(points); i++) {
			_func(points[i], i, _lastPoint);
			_lastPoint = points[i];
	    }
	}
	sticks_applyFunc = function(_func = function(_p, _i){}) {
		for (var i = 0; i < array_length(sticks); i++) {
			_func(sticks[i], i);
	    }
	}
}

enum ROPEP {
	x, y, x_prev, y_prev, x_accel, y_accel, x_drag, y_drag, locked, soft
}

function rope_point_create(_x, _y) {
	var p = []
	p[ROPEP.x] = _x;
	p[ROPEP.y] = _y;
	p[ROPEP.x_prev] = _x;
	p[ROPEP.y_prev] = _y;
	p[ROPEP.x_accel] = 0;
	p[ROPEP.y_accel] = 0;
	p[ROPEP.x_drag] = 1;
	p[ROPEP.y_drag] = 1;
	p[ROPEP.locked] = false;
	p[ROPEP.soft] = false;
	return p;
}
function rope_point_update(p, _mult) {
	if (!p[@ ROPEP.locked]) {
		var _prevX = p[@ ROPEP.x];
		var _prevY = p[@ ROPEP.y];
			
		p[@ ROPEP.x] += (p[@ ROPEP.x] - p[@ ROPEP.x_prev]) * p[@ ROPEP.x_drag] * _mult;
		p[@ ROPEP.y] += (p[@ ROPEP.y] - p[@ ROPEP.y_prev]) * p[@ ROPEP.y_drag] * _mult;
			
		p[@ ROPEP.x] += p[@ ROPEP.x_accel] * _mult;
		p[@ ROPEP.y] += p[@ ROPEP.y_accel] * _mult;
			
		p[@ ROPEP.x_prev] = _prevX;
		p[@ ROPEP.y_prev] = _prevY;
	}
}

function RopePoint(_x, _y) constructor {
	x = _x;
	y = _y;
	
	x_prev = x;
	y_prev = y;
	
	x_accel = 0;
	y_accel = 0;
	
	x_drag = 1;
	y_drag = 1;
	
	locked = false;
	soft = true;
	
	static update = function(_mult) {
		if (!locked) {
			var _prevX = x;
			var _prevY = y;
			
			x += (x - x_prev) * x_drag * _mult;
			y += (y - y_prev) * y_drag * _mult;
			
			x += x_accel * _mult;
			y += y_accel * _mult;
			
			x_prev = _prevX;
			y_prev = _prevY;
		}
	}
	//get_x_vel = function() {
	//	return x - x_prev;
	//}
	//get_y_vel = function() {
	//	return y - y_prev;
	//}
	//set_x_vel = function(_v) {
	//	x_prev = x - _v;
	//	return self;
	//}
	//set_y_vel = function(_v) {
	//	y_prev = x - _v;
	//	return self;
	//}
}

function RopeStick(_pA, _pB) constructor {
	pointA = _pA;
	pointB = _pB;
    
	length = 3;
  
	static update = function() {
		if ((pointA.soft || pointB.soft) && (point_distance(pointA.x, pointA.y, pointB.x, pointB.y) < length)) {
		    return;
		}
		var centerX = (pointA.x + pointB.x) / 2;
		var centerY = (pointA.y + pointB.y) / 2;
    
		var stickDirX = pointA.x - pointB.x;
		var stickDirY = pointA.y - pointB.y;
		var stickDirD = point_distance(0, 0, stickDirX, stickDirY);
		stickDirX /= stickDirD;
		stickDirY /= stickDirD;
    
		if (!pointA.locked) {
		    pointA.x = centerX + stickDirX * length / 2;
		    pointA.y = centerY + stickDirY * length / 2;
		}
		if (!pointB.locked) {
		    pointB.x = centerX - stickDirX * length / 2;
		    pointB.y = centerY - stickDirY * length / 2;
		}
	}
}