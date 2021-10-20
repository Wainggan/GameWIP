if array_length(chunkList) >= 1 {
	if !(array_length(chunkList)-1 < currentChunk) {
		if array_length(chunkList[currentChunk].enemyList) == 0 {
		
			if array_length(chunkList) == 0 {
				game_end() // umm something weird happened ig
			} else {
				currentChunk++
				func_loadChunk()
				
				show_debug_message("ohno")
				show_debug_message(array_length(chunkList))
			
			
			}
		}
	} else {
		game_end() // no more chunks, end of level
	}
}
