
function pattern_add(_name, _pattern) {
	if !variable_global_exists("patterns") global.patterns = {}
	global.patterns[$ _name] = _pattern
}

function pattern_get(_name) {
	if !variable_global_exists("patterns") global.patterns = {}
	return global.patterns[$ _name]
}

function Pattern(_init, _onstop = undefined) constructor {
	if typeof(_init) == "string" {
		__init = pattern_get(_init)
	} else 
		__init = _init
	
	static __stopperr = function() {
		command_reset()
		movement_stop()
	}
	
	if _onstop != undefined
		__stop = _onstop
	else
		__stop = __stopperr
		
	context = noone
	
	static run = function(_context) {
		context = _context
		method(context, __init)()
	}
	static stop = function() {
		method(context, __stop)()
	}
}

function AttackPhase(_timeLength, _patterns, _run = undefined) constructor {
	static __empty = function(){}
	time = _timeLength
	patterns = _patterns
	force = 0
	run = _run
	if _run == undefined run = __empty
}

