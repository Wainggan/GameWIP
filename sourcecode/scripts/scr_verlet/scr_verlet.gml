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

function RopePoint(_x, _y) constructor {
	x = _x;
	y = _y;
	
	x_prev = x;
	y_prev = y;
	
	x_accel = 0;
	y_accel = 0;
	
	x_drag = 0;
	y_drag = 0;
	
	elastic = 1;
	
	locked = false;
	soft = true;
	
	update = function(_mult) {
		if (!locked) {
			var _prevX = x;
			var _prevY = y;
			
			x += (x - x_prev) * _mult;
			y += (y - y_prev) * _mult;
			
			x += x_accel * _mult;
			y += y_accel * _mult;
			
			_prevX = lerp(_prevX, x, clamp(x_drag * _mult, 0, 1))
			_prevY = lerp(_prevY, y, clamp(y_drag * _mult, 0, 1))
			x_prev = _prevX;
			y_prev = _prevY;
		}
	}
	get_x_vel = function() {
		return x - x_prev;
	}
	get_y_vel = function() {
		return y - y_prev;
	}
	set_x_vel = function(_v) {
		x_prev = x - _v;
		return self;
	}
	set_y_vel = function(_v) {
		y_prev = x - _v;
		return self;
	}
}


function RopeStick(_pA, _pB) constructor {
	pointA = _pA;
	pointB = _pB;
    
	length = 3;
  
	update = function() {
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
		    pointA.x = lerp(pointA.x, centerX + stickDirX * length / 2, pointA.elastic);
		    pointA.y = lerp(pointA.y, centerY + stickDirY * length / 2, pointA.elastic);
		}
		if (!pointB.locked) {
		    pointB.x = lerp(pointB.x, centerX - stickDirX * length / 2, pointB.elastic);
		    pointB.y = lerp(pointB.y, centerY - stickDirY * length / 2, pointB.elastic);
		}
	}
}