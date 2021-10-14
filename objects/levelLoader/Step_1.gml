positionY -= 0.5;

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