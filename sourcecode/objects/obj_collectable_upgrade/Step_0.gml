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
	
	#macro UPGRADE_AMOUNT 5
	
	with obj_player
		switch other.type {
			case 0:
				bulletDamage *= bulletAmount / (bulletAmount + 1);
				bulletAmount++;
				bulletSpreadAngle += 3;
				break;
			case 1:
				bulletDamage += 0.2;
				break;
			case 2:
				tReloadTime = max(tReloadTime - 1, 4);
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
				break;
		}
	
}
