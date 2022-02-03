hp = 510;
scoreGive = 80000

deathRadius = WIDTH

important = 1;

var bP_test = new Timeline([bP_shootAround, 56, 1.4, [function(){return random(100)}]], 40)
array_push(bulletPatterns, bP_test)

instvar_moveFunc = function(){
	movePattern.add(new Tween(0.8, [x, y], [random_range(60, WIDTH-60),random(HEIGHT / 3) + 40], TWEEN_XY, "smooth",instvar_moveFunc))
		.pause(80)
}
onLoad = function(){
	instvar_moveFunc()
}