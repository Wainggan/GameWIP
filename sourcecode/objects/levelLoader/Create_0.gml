chunkList = noone;
func_findChunks = function() {
	chunkList = [];
	with obj_levelChunker {
		func_setupLevel()
		array_push(other.chunkList, id);
	}
	array_sort(chunkList, function(inst1, inst2) {
		return inst2.y - inst1.y;
	})
	
	currentChunk = 0
	
	//instance_deactivate_object(obj_enemy)
}

func_loadChunk = function() {
	
	
	
	if array_length(chunkList) <= currentChunk {
		return false
	}
	
	var chunkInst = chunkList[currentChunk];
	
	chunkInst.func_activateChunk()
	
	
	
}

pauseTime = -69;

currentChunk = 0;