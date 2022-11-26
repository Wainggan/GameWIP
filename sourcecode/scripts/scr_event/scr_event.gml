global.news = {}

function news_subscribe(_name, _func) {
	if global.news[$ _name] == undefined 
		global.news[$ _name] = [];
	array_push(global.news[$ _name], _func);
}

function news_push(_name, _args = []) {
	var _e = global.news[$ _name];
	if _e == undefined
		return false;
	if !is_array(_args)
		_args = [_args];
	var _l = array_length(_args);
	for (var i = 0; i < array_length(_e); i++) {
		_e[i](
			_l > 0 ? _args[0] : undefined,
			_l > 1 ? _args[1] : undefined,
			_l > 2 ? _args[2] : undefined,
			_l > 3 ? _args[3] : undefined,
			_l > 4 ? _args[4] : undefined,
			_l > 5 ? _args[5] : undefined,
			_l > 6 ? _args[6] : undefined
		);
	}
	return true;
}

