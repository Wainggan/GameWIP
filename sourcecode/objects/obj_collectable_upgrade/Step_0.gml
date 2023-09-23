x_vel = approach(x_vel, 0, 0.02 * global.delta_multi)
y_vel = min(y_vel + 0.04 * global.delta_multi, max(y_tvel, 1));
y_tvel = min(y_tvel + 0.01 * global.delta_multi, 3);

image_angle = 0;
x += x_vel * global.delta_multi;
y += y_vel * global.delta_multi;

if HEIGHT + 64 < y
	instance_destroy()

if hp <= 0 {
	//instance_destroy();
	instance_destroy(obj_collectable_upgrade);
	var shockwave = render.shockwave_create(x, y)
	shockwave.mode = 1
	shockwave.scaleTarget = 512
	shockwave.scaleSpeed = 8
	
	repeat 10
		text_splash_random(x, y, 1000, 32, 10)
	global.score += 10000;
	
	
	screenShake_set(4, 0.2);
	game_pause(4)
	
	with obj_player {
		print($"{other.type} {config.get(other.type)}")
		config.get(other.type).level += 1
	}
	
}
