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
		func_open(menu_settings);
	})
	.add_button("Debug", function(){
		func_open(menu_debug);
	})
	.add_button("Exit", function(){
		game_end();
	})

menu_settings = new Menu()
	.add_radio("Screenshake", ["None", "50%", "100%"], global.file.settings.screenShake, function(_e){
		global.file.settings.screenShake = _e;
	})

menu_debug = new Menu()
	.add_button("Delete File", function(){
		global.file = global.file_default;
		json_writeFrom(FILENAME, global.file);
	})

menu_pause = new Menu()
	.add_button("Continue", function(){
		func_close();
	})
	.add_button("Settings", function(){
		func_open(menu_settings);
	})