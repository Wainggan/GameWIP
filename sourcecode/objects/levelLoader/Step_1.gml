if array_length(chunkList) >= 1 && pauseTime = -69 {
	if !(array_length(chunkList)-1 < currentChunk) {
		if array_length(chunkList[currentChunk].enemyList) == 0 {
		
			if array_length(chunkList) == 0 {
				log("??? This shouldn't run?????? check obj_levelLoader's Begin Step", LOG_WARNING)
				
				game_end() // umm something weird happened ig
			} else {
				pauseTime = chunkList[currentChunk].pauseTime;
				
			
			
			}
		}
	} else {
		//game_end() // no more chunks, end of level
		
		//room_goto(rm_mainmenu)
		game_stop()
	}
}

if pauseTime != -69 {
	if pauseTime <= 0 {
		chunkList[currentChunk].active = false
		currentChunk++
		func_loadChunk()
		pauseTime = -69
		
		log("New chunk loaded, " + string(currentChunk))
	} else {
		pauseTime -= global.delta_multi;
	}
}