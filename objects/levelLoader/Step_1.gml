if array_length(chunkList) >= 1 && pauseTime = -69 {
	if !(array_length(chunkList)-1 < currentChunk) {
		if array_length(chunkList[currentChunk].enemyList) == 0 {
		
			if array_length(chunkList) == 0 {
				game_end() // umm something weird happened ig
			} else {
				pauseTime = chunkList[currentChunk].pauseTime;
				
				
				show_debug_message("ohno")
				show_debug_message(array_length(chunkList))
			
			
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
	} else {
		pauseTime -= global.delta_multi;
	}
}