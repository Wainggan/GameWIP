if active {
	//var fix = []
	for (var i = array_length(enemyList)-1; i >= 0; i--) {
		var inst = enemyList[i]
		if !instance_exists(inst) {
			//array_push(fix, i)
			//array_pop(enemyList)
			array_delete(enemyList, i, 1)
		}
	}
	
	//for (var i = 0; i < array_length(fix); i++) {
	//	array_delete(enemyList, fix[i], 1)
	//}
}