hp = 600;
scoreGive = 90000

deathRadius = WIDTH

important = 1;

var bP_test = new Timeline([bP_shootAround, [function(){return irandom_range(80, 100)}], [function(){return random_range(1, 2.5)}], [function(){return random(100)}]]
	, 100)
array_push(bulletPatterns, bP_test)

