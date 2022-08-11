menuList = [];

func_open = function(_menu) {
	_menu.position = 0;
	array_push(menuList, _menu);
}
func_pop = function() {
	array_pop(menuList).position = 0;
}
func_close = function() {
	var _check = array_pop(menuList);
	while _check {
		_check.position = 0;
		_check = array_pop(menuList);
	}
}

menu_main = new Menu()
	.add_button("Test", function(){
		game_start();
		func_close();
	})
	.add_button("Settings", function(){
	})
	.add_button("Debug", function(){
	})
	.add_button("Exit", function(){
		game_end();
	})
