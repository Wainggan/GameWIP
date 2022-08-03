//if !active exit

if (lastParent != noone) {
	if (!instance_exists(parent)) {
		instance_destroy()
	}
}
lastParent = parent

if hp > maxhp {
	maxhp = hp
}



// making sure the bullet list has active instances
for (var i = 0; i < array_length(bulletList); i++) {
	if (!instance_exists(bulletList[i])) {
		array_delete(bulletList, i, 1)
		i--
	}
}

// shooting bullets
for (var i = 0; i < array_length(bulletPatterns); i++) {
	bulletPatterns[i].update(global.delta_multi);
	if bulletPatterns[i].changed == true {
		var _currentBulletPattern = bulletPatterns[i].evaluate()
		if _currentBulletPattern != -1 {
			func_addBullets(script_execute_deep(_currentBulletPattern));
		}
	} else if array_length(bulletPatterns[i].list) == 0 {
		array_delete(bulletPatterns, i, 1)
		i--
	}
	
}

// movement

movePattern.update(global.delta_multi)


frameFunc()