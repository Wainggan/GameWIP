function TweenManager() constructor {
	tweens = [];
	add = function(_tween) {
		array_push(tweens, _tween);
		return self;
	}
	update = function(_mult = undefined) {
		if (array_length(tweens) > 0 && tweens[0].update(_mult)) {
			tweens[0].onEnd()
			array_delete(tweens, 0, 1)
		}
	}
}
function TWEEN_X(_value) { x = _value; };
function TWEEN_Y(_value) { y = _value; };
function TWEEN_XY(_value) { x = _value[0]; y = _value[1]; };
function TWEEN_ANGLE(_value) { image_angle = _value; };
function TWEEN_SIZE(_value) { image_xscale = _value; image_yscale = _value; };
function TWEEN_ALPHA(_value) { image_alpha = _value; };
function Tween(_speed, _start = 0, _target = 1, _property = function(){}, _tween = "smooth", _onEnd = function(){}) constructor {
	start = _start;
	target = _target;
	
	spd = _speed;
	if (is_array(start)) {
		var _total = 0;
	    for (var i = 0; i < array_length(start); i++) {
	        _total += power(target[i] - start[i], 2);
	    }
	    spd = _speed / sqrt(_total);
	} else {
		spd = _speed / abs(target - start);
	}
	percent = 0;
	
	property = method(other, _property);
	tween = animcurve_get_channel(ac_tween, _tween);
	
	onEnd = _onEnd;
	
	update = function(_mult = 1) {
		percent = min(percent + spd * _mult, 1);
		if (is_array(start)) {
            var value = [];
            for (var i = 0; i < array_length(start); i++) {
                value[i] = lerp(start[i], target[i], animcurve_channel_evaluate(tween, percent));
            }
            property(value);
        }
        else {
            property(lerp(start, target, animcurve_channel_evaluate(tween, percent)));
        }
        return percent >= 1;
	}
}

///@func AnimCurve([curveType = "smooth"], [start = 0], [target = 1])
function AnimCurve(_curve = "smooth", _start = 0, _target = 1) constructor {
	percent = 0;
	curve = _curve
	items = {
		def : {
			start : _start,
			target : _target
		}
	}
	add = function(_name, _start, _end) {
		items[$ _name] = {
			start : _start,
			target : _end
		}
		return self;
	}
	getPercent = function() {
		return animcurve_channel_evaluate( animcurve_get_channel(ac_tween, curve), percent)
	}
	evaluate = function(_name = "def"){
		return lerp(items[$ _name].start, items[$ _name].target, getPercent())
	}
	get = function(_name = "def") {
		return items[$ _name]
	}
	
	reset = function() {
		percent = 0;
		items = {
			def : {
				start : _start,
				target : _target
			}
		}
		return self;
	}
}
