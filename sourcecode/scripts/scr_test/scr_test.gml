
var _test = 1.0 / 0.0

show_debug_message(_test)

_test = _test * 10

show_debug_message(_test)

_test = _test + 10

show_debug_message(_test)

_test = clamp(_test, 5, 20)

show_debug_message(_test)

var _test = 0.0
_test /= 0.0
show_debug_message(_test)
_test *= 72
show_debug_message(_test)
_test += 10
show_debug_message(_test)
_test = clamp(_test, 10, 40)
