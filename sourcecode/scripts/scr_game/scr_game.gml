function game_start(_rm = rm_stage1) {
	room_goto(_rm)
	global.gameActive = 1;
	global.highscore = global.file.save.leaderboard[0].score
	
}

function game_stop() {
	global.gameActive = 0;
	
	var _lb = global.file.save.leaderboard;
	array_push(_lb, { name : "debug", score : global.score })
	array_sort(_lb, function(a, b){
		return b.score - a.score;
	})
	while array_length(_lb) > LEADERBOARDSIZE {
		array_pop(_lb)
	}
	
	global.score = 0;
	
	
	
	json_writeFrom(FILENAME, global.file);
	
	room_goto(rm_mainmenu);
}