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
	
	//instance_deactivate_object(obj_enemy)
}

func_loadChunk = function() {
	
	if array_length(chunkList) <= currentChunk {
		return false
	}
	
	var chunkInst = chunkList[currentChunk];
	
	with chunkInst {
		for (var i = 0; i < array_length(enemyList); i++) {
			var inst = enemyList[i];
			
			instance_activate_object(inst);
			
			var offset = inst.y - bbox_bottom;
			
			inst.y = HEIGHT + offset;
		}
		
		active = true;
		
	}
	
	
	
}

currentChunk = 0;