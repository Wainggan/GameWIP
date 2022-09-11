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

focusAnimCurve.percent = approach(focusAnimCurve.percent, 1, 0.02 * global.delta_multi);

if !global.pause {
	screenShakeX = irandom_range(-global.screenShake, global.screenShake) * (global.file.settings.screenShake / 2);
	screenShakeY = irandom_range(-global.screenShake, global.screenShake) * (global.file.settings.screenShake / 2);
}

if !global.pause
	scoreAnim = lerp(scoreAnim, global.score, 1 - power(0.01, global.delta_milli * 2));
