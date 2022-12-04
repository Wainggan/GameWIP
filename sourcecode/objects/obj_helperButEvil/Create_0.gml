x_vel = 0;
y_vel = 0;

tReloadTime = 12;
reloadTime = tReloadTime;

target = noone;

off = random(200);
dir = choose(-1, 1);

image_alpha = 0.6

command_set([
	120 + random_range(-4, 4),
	function(){
		if point_distance(x, y, obj_player.x, obj_player.y) < 126 || !obj_player.canShoot {
			commandIndex--
			return;
		}
		bullet_preset_ring(x, y, 5, 8, random(360), function(_x, _y, _dir) {
			with bullet_shoot_dir(_x, _y, 2, _dir) {
				glow = cb_grey;
				sprite_index = spr_bullet_small
			}
		})
		commandTimer = random(20)
		commandIndex--
	}
]);