
// makes tendrils that aim towards the player
// good for a vii boss

command_set([
	8,
	function(){
		bullet_preset_plate(x, y, 4, 6, 180, -10, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir) {
			with bullet_shoot_dir2(x, y, 10, 0.25, 4, _dir) {
				bullet_set_command()
				command_timer(30, function(){
					bullet_set_dir_target(, 3, point_direction(x, y, obj_player.x, obj_player.y))
				})
			}
		})
		commandIndex--
	}
])



