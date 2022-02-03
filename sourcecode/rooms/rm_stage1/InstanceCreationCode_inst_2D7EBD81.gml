hp = 400;
scoreGive = 100000

deathRadius = WIDTH

important = 1;

instvar_d = 0
instvar_amount = 3
instvar_wait = 140
instvar_density = 40
instvar_period = 32
instvar_bulletTest = function(){
	var t = new Timeline()
	t.add([bP_shootAround, instvar_density+10, 1.4, [function(){return random(100)}]], instvar_period + 5)
	repeat instvar_amount {
		t.add([bP_shootAround, instvar_density, 1.4, [function(){instvar_d += 360 / instvar_density / 2; return instvar_d}]], instvar_period)
	}
	t.addReset()
	instvar_amount = min(instvar_amount + 1, 9)
	instvar_wait = min(instvar_wait + 20, 220)
	instvar_density = min(instvar_density + 6, 80)
	instvar_period = max(instvar_period - 2, 17)
	array_push(bulletPatterns, t)
}


instvar_moveFunc = function(){
	movePattern.add(new Tween(2, [x, y], [random_range(60, WIDTH-60),random(HEIGHT / 8) + 30], TWEEN_XY, "smooth",instvar_bulletTest))
		.pause(instvar_wait, instvar_moveFunc)
}
onLoad = function(){
	instvar_moveFunc()
}