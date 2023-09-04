menuList = [];
camX = 0;


func_open = function(_menu) {
	_menu.position = 0;
	_menu.camY = 0;
	array_push(menuList, _menu);
}
func_pop = function() {
	with array_pop(menuList) {
		position = 0;
		hoveringTime = 0;
	}
}
func_close = function() {
	var _check = array_pop(menuList);
	while _check {
		_check.position = 0;
		_check.hoveringTime = 0;
		_check = array_pop(menuList);
	}
}

menu_main = new Menu()
	.add_button("Stage 1", function(){
		game_start(rm_stage1);
		func_close();
	})
	.add_button("Stage 2", function(){
		game_start(rm_stage2);
		func_close();
	})
	.add_button("Stage 3", function(){
		game_start(rm_stage3);
		func_close();
	})

if DEBUG {
	menu_main
	.add_button("TEST", function(){
		game_start(rm_stagetest);
		func_close();
	})
	.add_button("TEST2", function(){
		game_start(rm_stagetest2);
		func_close();
	})
	.add_button("Stage 4", function(){
		game_start(rm_stage4);
		func_close();
	})
}
menu_main
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
	.add_radio("Screenshake", ["None", "50%", "100%"], global.file.settings.graphics.screenShake, function(_e){
		global.file.settings.graphics.screenShake = _e;
	})
	.add_slider("Global Volume", 0, 10, 1, global.file.settings.sound.globalVolume * 10, , function(_e){
		show_debug_message(_e * 0.1)
		global.file.settings.sound.globalVolume = _e * 0.1;
		news_push("volume_change", [
			global.file.settings.sound.globalVolume * 
			global.file.settings.sound.musicVolume
		])
	})
	.add_slider("Music Volume", 0, 10, 1, global.file.settings.sound.musicVolume * 10, , function(_e){
		show_debug_message(_e * 0.1)
		global.file.settings.sound.musicVolume = _e * 0.1;
		news_push("volume_change", [
			global.file.settings.sound.globalVolume * 
			global.file.settings.sound.musicVolume
		])
	})
	.add_slider("SFX Volume", 0, 10, 1, global.file.settings.sound.sfxVolume * 10, , function(_e){
		show_debug_message(_e * 0.1)
		global.file.settings.sound.sfxVolume = _e * 0.1;
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