for (var i = 0; i < array_length(shockwave_waves); i++) {
	var w = shockwave_waves[i]
	w.currentlife += 1 * global.delta_multi
	
	if (w.mode == 0 && w.currentlife < w.life) {
		w.scale = (w.scaleTarget/1024) * (w.currentlife / w.life)//w.scaleSpeed/1024 * global.delta_multi;
		w.alpha -= 1/w.life * global.delta_multi
	} else if (w.mode == 1 && w.scale < w.scaleTarget/1024) {
		w.scale += w.scaleSpeed/1024 * global.delta_multi;
		w.alpha = 1 - w.scale / (w.scaleTarget/1024)
	} else {
		array_delete(shockwave_waves, i, 1)
		i--
	}
}

if global.score != lastScore {
	scoreAnimCurve.percent = 0;
	scoreAnimCurve.get().start = scoreAnim
	scoreAnimCurve.get().target = global.score
}
if global.score != scoreAnim {
	scoreAnim = scoreAnimCurve.evaluate()
	scoreAnimCurve.percent += 0.03 * global.delta_multi;
	if scoreAnimCurve.percent >= 1 {
		scoreAnim = global.score
	}
}
lastScore = global.score;