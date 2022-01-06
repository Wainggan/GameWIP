hp = 600;
scoreGive = 90000

deathRadius = WIDTH

important = 1;

bP_test = function() {

}

pattern_frame = [
	[[bP_shootAround, [function(){return irandom_range(80, 100)}], [function(){return random_range(1, 2.5)}], [function(){return random(100)}]], 100],
]

mPattern_goAway = [[0,0,0]]

//bulletPattern = testPattern