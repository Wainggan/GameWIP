event_inherited();

enemies = {
	"boss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_enemy_testBoss
		
		x = -90;
		y = -20;
		
		
		movement_start(WIDTH / 2, HEIGHT / 3, 1/40, , function(){
			func_nextAttack();
		});
		
		attacks = [
			function(){
				hp = 200;
				
				movement_start(WIDTH / 2, 60, 1/20);
				
				command_set([
					20-16,
					16,
					function(){
						bullet_preset_plate(x, y, 25, 12, 48, -16, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 2, _dir).glow = cb_blue;
						})
						commandIndex--;
					}
				]);
				command_add([
					100,
					function(){
						rand = 60 + irandom_range(-10, 20);
						bullet_preset_plate(x, y, 2, 0, 90, 0, 270 + irandom_range(-10, 10), function(_x, _y, _dir){
							var _rand = rand
							with bullet_shoot_dir(_x, _y, 4, _dir) {
								sprite_index = spr_bullet_small;
								glow = cb_yellow;
								
								y_target = 2;
								y_accel = 0.02;
								
								command_timer(_rand, function(){
									bullet_preset_ring(x, y, 32, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
										with bullet_laser(_x, _y, _dir, 8, 32) {
											glow = cb_yellow;
										}
									})
									instance_destroy()
								})
							}
						})
						commandIndex--;
					}
				])
				
			},
		]
	}
};

stage = [
	function(){
		enemy("boss", 0, 0)
		time(,true);
	},
]
