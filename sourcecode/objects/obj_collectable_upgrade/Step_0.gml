x_vel = approach(x_vel, 0, 0.02 * global.delta_multi)
y_vel = min(y_vel + 0.04 * global.delta_multi, max(y_tvel, 1));
y_tvel = min(y_tvel + 0.01 * global.delta_multi, 3);

image_angle = 0;
x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;

if HEIGHT + 32 < y
	instance_destroy()

if hp <= 0 {
	//instance_destroy();
	instance_destroy(obj_collectable_upgrade);
	var shockwave = render.shockwave_create(x, y)
	shockwave.mode = 1
	shockwave.scaleTarget = 512
	shockwave.scaleSpeed = 8
	
	screenShake_set(4, 0.2);
	global.pause = 4;
	
	#macro UPGRADE_AMOUNT 17
	
	with obj_player
		switch other.type {
			case 0:
				bulletDamage *= bulletAmount / (bulletAmount + 1);
				bulletAmount++;
				bulletSpreadAngle += 4;
				bulletSpreadSlow -= 0.5;
				break;
			case 1:
				bulletDamage += 0.2;
				bulletHomingDamage += 0.2;
				bulletLaserDamage += 0.0025;
				break;
			case 2:
				tReloadTime = max(tReloadTime - 1, 4); // TODO: balance
				tReloadHomingTime = max(tReloadHomingTime - 1, 7);
				grazeComboBulletMult *= 0.75;
				grazeComboBulletExp *= 0.98;
				bulletChargeTarget = max(bulletChargeTarget - 0.2, 1);
				break;
			case 3:
				moveSpeed += 0.5
				slowMoveSpeed += 0.2
				fastMoveSpeed += 0.5
				break;
			case 4:
				fastMoveSpeed += 2
				break;
			case 5:
				lifeChargeSpeed += 0.0001;
				lifeChargeGraze += 0.0002;
				lifeCharge += 0.2;
				break;
			case 6:
				if bulletHomingAmount == 0 {
					bulletHomingAmount++;
				} else {
					bulletHomingDamage *= bulletHomingAmount / ((bulletHomingAmount * 2 + 1) / 2);
					bulletHomingAmount++;
				}
				break;
			case 7:
				func_addLaser();
				break;
			case 8:
				collectDist += 16;
				break;
			case 9:
				collectPoint += 96;
				break;
			case 10:
				collectAllBullets = true;
				break;
			case 11:
				if bulletRoundAmount == 0 {
					bulletRoundAmount++;
				} else {
					bulletRoundDamage *= bulletRoundAmount / ((bulletRoundAmount * 2 + 1) / 2);
					bulletRoundAmount++;
				}
				break;
			case 12:
				if bulletWavyAmount == 0 {
					bulletWavyAmount++;
				} else {
					bulletWavyDamage *= bulletWavyAmount / ((bulletWavyAmount * 2 + 0.5) / 2);
					bulletWavyAmount++;
				}
				break;
			case 13:
				grazeReflectChance = min(grazeReflectChance + 0.05, 0.3);
				break;
			case 14:
				func_addHelper();
				break;
			case 15:
				func_addHelper();
				func_addHelper();
				break;
			case 16:
				func_addEvil();
				break;
			case 17:
				func_addEvil();
				func_addEvil();
				break;
			case 18:
				// time slow
				break;
		}
	
}
