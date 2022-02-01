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

tail.points[0].x = round(x) - 1
tail.points[0].y = round(y) + 7

tail.points_applyFunc(function(p, i, l){
	var tailfreq = 0.8//0.5
	var tailspeed = 0.2//0.1
	var tailstrength = 0.02//0.02

	var pVecX = p.x - l.x;
	var pVecY = p.y - l.y;
	var tanVecX = -pVecY
	var tanVecY = pVecX
	var tanMag = point_distance(0, 0, tanVecX, tanVecY)
	tanVecX /= tanMag;
	tanVecY /= tanMag;
      
	var e = ( sin((global.time/60-i/tailfreq)*tailspeed) * (tailstrength) )
      
	tanVecX *= e;
	tanVecY *= e;
      
	p.x_accel = tanVecX;
	p.y_accel = tanVecY
	
	// + (0.02 / (power(l - tailLength / 2, 2) * 0.02 + 2))
    
})
tail.update(global.delta_multi)
