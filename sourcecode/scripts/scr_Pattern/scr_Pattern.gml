
function pattern_add(_name, _pattern) {
	if !variable_global_exists("patterns") global.patterns = {}
	global.patterns[$ _name] = _pattern
}

function pattern_get(_name) {
	if !variable_global_exists("patterns") global.patterns = {}
	return global.patterns[$ _name]
}

function Pattern(_init) constructor {
	if typeof(_init) == "string" {
		init = pattern_get(_init)
	} else 
		init = _init
}

function AttackPhase(_timeLength, _patterns, _force = undefined) constructor {
	time = _timeLength
	patterns = _patterns
	force = _force
}

