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
	repeat instvar_amount {
		t.add([bP_shootAround, instvar_density, 1.4, [function(){instvar_d += 360 / instvar_density / 2; return instvar_d}]], instvar_period)
	}
	t.pause(45)
	t.add([bP_shootAround, instvar_density + 18, 1.6, [function(){return random(360)}]], instvar_period)
	t.addReset()
	instvar_amount = min(instvar_amount + 1, 25)
	instvar_wait = instvar_period * (instvar_amount + 1) + 60
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