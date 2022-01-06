func_inputUpdate(inputSystem.check("left") || inputSystem.check("stickhorz") < 0,
				inputSystem.check("right") || inputSystem.check("stickhorz") > 0,
				inputSystem.check("up") || inputSystem.check("stickvert") < 0,
				inputSystem.check("down") || inputSystem.check("stickvert") > 0)


state.run()

iFrames -= global.delta_multi
reloadTime -= global.delta_multi
grazeComboTimer -= global.delta_multi
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