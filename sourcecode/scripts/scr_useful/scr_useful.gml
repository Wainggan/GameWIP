function approach(_a,_b,_amount) {
	if (_a < _b)
	{
	    _a += _amount;
	    if (_a > _b)
	        return _b;
	}
	else
	{
	    _a -= _amount;
	    if (_a < _b)
	        return _b;
	}
	return _a;
}

function round_ext(_value,_round) {
	return round(_value / _round) * _round;
}

function map(val, start1, end1, start2, end2) {
	var prop = (val - start1)/(end1-start1);
	return prop*(end2-start2) + start2;
}

function wave(_from, _to, _duration, _offset = 0, _time = global.time / 60/*current_time * 0.001*/) {
	var a4 = (_from - _to) * 0.5;
	return _to + a4 + sin((((_time) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

function wrap(_value,_min,_max) {
	var _mod = ( _value - _min ) mod ( _max - _min );
	if ( _mod < 0 ) return _mod + _max; else return _mod + _min;
}


function chance(_percent) {
	return argument0 > random(1);
}


///@func script_execute_deep(array, [runPlainFunctionFirst = true])
function script_execute_deep(_in, _plainFunction = true) {
	if (!is_array(_in)) {
		if !_plainFunction return _in;
		if (is_method(_in) || (_in > 100000 && script_exists(_in))) {
			return _in();
		} else {
			return _in;
		}
	} else if (array_length(_in)==0 || !(is_method(_in[0]) || (_in[0] > 100000 && script_exists(_in[0])))) return _in;
	
	var newIn = [];
	for (var i = 1; i < array_length(_in); i++) {
		array_push(newIn, script_execute_deep(_in[i], false));
	}
	var fix = _in[0]
	if is_method(fix) {
		fix = method_get_index(fix)
	}
	return script_execute_ext(fix, newIn);
}


///@func array_append(array, array)
function array_append(array1, array2) {
	for(var i = 0; i < array_length(array2); i++) {
		array1[@ array_length(array1)] = array2[i];
	}
	return array1;
}