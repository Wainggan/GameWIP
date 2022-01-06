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
	}
}
