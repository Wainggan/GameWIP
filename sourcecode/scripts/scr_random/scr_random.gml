
function Counter(_seed = 1) constructor {
	
	seed0 = max(_seed, 1);
	seed1 = max(_seed + 100, 1);
	seed2 = max(_seed + 300, 1);
	
	count = 0
	
	static rand = function() {
		
		seed0 = (171 * seed0) mod 30269
	    seed1 = (172 * seed1) mod 30307
	    seed2 = (170 * seed2) mod 30323

	    return (seed0 / 30269.0 + seed1 / 30307.0 + seed2 / 30323.0) mod 1
		
	}
	
	static next = function() {
		return count++
	}
	
}


var _test = new Counter(0)

show_debug_message(_test.rand())
show_debug_message(_test.rand())
show_debug_message(_test.rand())

var _test = new Counter(1)

show_debug_message(_test.rand())
show_debug_message(_test.rand())
show_debug_message(_test.rand())

var _test = new Counter(10)

show_debug_message(_test.rand())
show_debug_message(_test.rand())
show_debug_message(_test.rand())

var _test = new Counter(0)

show_debug_message(_test.rand())
show_debug_message(_test.rand())
show_debug_message(_test.rand())


