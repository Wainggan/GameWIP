inputSystem.update()

func_inputUpdate(inputSystem.check("left"),
				inputSystem.check("right"),
				inputSystem.check("up"),
				inputSystem.check("down"))


state.run()

iFrames -= global.delta_multi
reloadTime -= global.delta_multi
grazeComboTimer -= instance_number(obj_bullet) ? global.delta_multi : 0
if grazeComboTimer <= 0 {
	grazeCombo = 0;
}

for (var i = 0; i < array_length(grazeBulletList); i++) {
	grazeBulletList[i][1] -= global.delta_multi;
	if grazeBulletList[i][1] <= 0 {
		array_delete(grazeBulletList, i, 1);
		i--
	}
}

grazeHitboxGraphicShow = max(grazeHitboxGraphicShow-grazeHitboxGraphicShowSpeed * global.delta_multi, 0)

array_foreach(tails, function(tail, tailNumb){
	//tail.points[0].x = round(x) - 1
	//tail.points[0].y = round(y) + 7
	tail.points[0].x = round(x) - 1 + cos(tailNumb / array_length(tails) * 3.1415 * 2) * power(array_length(tails), 0.7)
    tail.points[0].y = round(y) + 7 + sin(tailNumb / array_length(tails) * 3.1415 * 2) * power(array_length(tails), 0.7)
	tail.points_applyFunc(method({tailNumb : tailNumb}, function(p, i, l){
		var tailfreq = 0.8//0.5
		var tailspeed = 0.2//0.1
		var tailstrength = 0.04//0.02
		var tailOffset = power(tailNumb * 1.5 + 1.432, 3.751);

		var pVecX = p.x - l.x;
		var pVecY = p.y - l.y;
		var tanVecX = -pVecY
		var tanVecY = pVecX
		var tanMag = point_distance(0, 0, tanVecX, tanVecY)
		tanVecX /= tanMag;
		tanVecY /= tanMag;
      
		var e = ( sin((global.time/60-(i + tailOffset)/tailfreq + power(tailOffset, 2))*tailspeed) +
				sin((global.time/60-(i + tailOffset * 0.14)/tailfreq + power(tailOffset, 2))*tailspeed * 1.7124) / 2) * (tailstrength)
      
		tanVecX *= e;
		tanVecY *= e;
      
		p.x_accel = tanVecX;
		p.y_accel = tanVecY;
		
		var wa = (sin(global.time/60 / 100 + tailOffset) + sin(global.time/60 / 100 + 9.13 + tailOffset)) / 2
        p.x_accel += cos(global.time/60 * wa + (tailNumb / array_length(other.tails) * 3.1415 * 2)) * 0.02 / power((i+1), 0.35);
        p.y_accel += sin(global.time/60 * wa + (tailNumb / array_length(other.tails) * 3.1415 * 2)) * 0.02 / power((i+1), 0.35)
			 + (0.03 / power(i, 0.4))
	}))
	tail.update(global.delta_multi)
})