//positionY -= 0.5;
if array_length(chunkList) >= 1 {
	if !(array_length(chunkList)-1 < currentChunk) {
		if array_length(chunkList[currentChunk].enemyList) == 0 {
			//var chunkInst = array_pop(chunkList)
			//instance_destroy(chunkInst)
		
		
			if array_length(chunkList) == 0 {
				game_end() // no more chunks
			} else {
				currentChunk++
				func_loadChunk()
			
			
			}
		}
	} else {
		game_end()
	}
}

/*
var fix = 0;
for (var i = 0; i < array_length(enemyList); i++) {
	var inst = enemyList[i]
	if inst.y > positionY {
		instance_activate_object(inst)
		
		fix ++
		//array_pop(enemyList)
	}
}

repeat fix {
	array_pop(enemyList)
}