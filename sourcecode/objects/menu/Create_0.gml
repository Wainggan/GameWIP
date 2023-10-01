menuList = [];
camX = 0;


controller = new PageController()

leaderboard = new Page_Leaderboard()
leaderboardType = new Page_Keyboard()


menu_main = new Page_Menu()
	.add_button("Stage 1", function(){
		game_start(rm_stage1);
		controller.close();
	})
	.add_button("Stage 2", function(){
		game_start(rm_stage2);
		controller.close();
	})
	.add_button("Stage 3", function(){
		game_start(rm_stage3);
		controller.close();
	})
	.add_button("Leaderboard", function(){
		leaderboard.previous(menu_main)
		controller.next(leaderboard)
	})
	.add_button("Keyboard", function(){
		leaderboardType.previous(menu_main)
		leaderboardType.next(menu_main)
		controller.next(leaderboardType)
	})

if DEBUG {
	menu_main
	.add_button("TEST", function(){
		game_start(rm_stagetest);
		controller.close();
	})
	.add_button("TEST2", function(){
		game_start(rm_stagetest2);
		controller.close();
	})
	.add_button("Stage 4", function(){
		game_start(rm_stage4);
		controller.close();
	})
}
menu_main
	.add_button("Settings", function(){
		menu_settings.previous(menu_main);
		controller.next(menu_settings);
	})
	.add_button("Debug", function(){
		menu_debug.previous(menu_main);
		controller.next(menu_debug);
	})
	.add_button("Exit", function(){
		game_end();
	})


controller.next(menu_main)


menu_settings = new Page_Menu()
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

menu_debug = new Page_Menu()
	.add_button("Delete File", function(){
		global.file = global.file_default;
		json_writeFrom(FILENAME, global.file);
	})

menu_pause = new Page_Menu()
	.add_button("Continue", function(){
		func_close();
	})
	.add_button("Settings", function(){
		func_open(menu_settings);
	})

