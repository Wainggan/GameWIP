moveCont = new TweenManager()

test = function(){
	moveCont.add(new Tween(2, [x, y], [random(512),random(480)], TWEEN_XY, "smooth",test))
}

alarm[0] = 50