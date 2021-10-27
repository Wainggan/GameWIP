if active {
	//var fix = []
	
	miniWaveReload -= global.delta_multi;
	if miniWaveReload <= 0 {
		miniWaveReload = var_tMiniWaveReload;
		
		if array_length(miniWave) {
			miniWave[currentMiniWave]()
		}
		
		currentMiniWave += 1;
		if currentMiniWave >= array_length(miniWave) {
			currentMiniWave = 0;
		}
	}
	
	for (var i = array_length(enemyList)-1; i >= 0; i--) {
		var inst = enemyList[i]
		if !instance_exists(inst) {
			
			
			array_delete(enemyList, i, 1)
			
		}
	}
	
	
	
	//for (var i = 0; i < array_length(fix); i++) {
	//	array_delete(enemyList, fix[i], 1)
	//}
}