miniWave = [
	function(){
		func_createEnemy(-WIDTH, 128, obj_enemy_slideInFromSide)
		func_createEnemy(-WIDTH - 64*1, 128, obj_enemy_slideInFromSide)
		func_createEnemy(-WIDTH - 64*2, 128, obj_enemy_slideInFromSide)
		func_createEnemy(-WIDTH - 64*3, 128, obj_enemy_slideInFromSide)
		func_createEnemy(-WIDTH - 64*4, 128, obj_enemy_slideInFromSide)
	},
	function(){
		func_createEnemy(WIDTH*2, 128, obj_enemy_slideInFromSide)
		func_createEnemy(WIDTH*2 + 64*1, 128, obj_enemy_slideInFromSide)
		func_createEnemy(WIDTH*2 + 64*2, 128, obj_enemy_slideInFromSide)
		func_createEnemy(WIDTH*2 + 64*3, 128, obj_enemy_slideInFromSide)
		func_createEnemy(WIDTH*2 + 64*4, 128, obj_enemy_slideInFromSide)
	}
]