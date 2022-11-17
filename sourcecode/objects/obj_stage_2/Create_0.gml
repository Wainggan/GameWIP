// STAGE 2

event_inherited()

enemies = {
	"basic1": function(){
		hp = 7
		scoreGive = 100;
		pointGive = 1;
		
		sprite_index = spr_enemy_flower
		
		startX = x;
		startY = y;
		
		x += irandom_range(-128, 128);
		y = -64;
		
		invinsible = true;
		movement_start(startX, startY, 1 / 30, , function(){ invinsible = false });
		
		command_timer(60 * 12, function(){
			command_reset();
			movement_start(x + irandom_range(-64, 64), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
		})
		
		b_reload = 6;
		b_dir = 0;
		
		command_set([
			20,
			10,
			function(){
				b_dir = point_direction(x, y, obj_player.x, obj_player.y)
			},
			2,
			function(){
				bullet_shoot_dir2(x, y, 0, 0.2, 14, b_dir).glow = cb_pink;
				if b_reload-- > 0 commandIndex--
			},
			20,
			function(){
				b_reload = 6;
				movement_start(clamp(x + irandom_range(-128, 128), 32, WIDTH - 32), irandom_range(30, 200), 1/20);
			},
			20, 
			function(){
				commandIndex = 1;
			}
		]);
		command_add([
			80,
			6,
			function(){
				bullet_preset_plate(x, y, 2, 24, 32, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
					bullet_shoot_dir2(_x, _y, 4, 2, 14, _dir).glow = cb_green;
				})
				commandIndex--;
			},
		])
	},
	"basic2": function(_density = 12){
		hp = 14
		scoreGive = 100;
		pointGive = 2;
		
		sprite_index = spr_enemy_flower
		
		startX = x;
		startY = y;
		
		x += irandom_range(-16, 16);
		y = -64;
		
		invinsible = true;
		movement_start(startX, startY, 1 / 30, , function(){ invinsible = false });
		
		command_timer(60 * 12, function(){
			command_reset();
			movement_start(x + irandom_range(-256, 256), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
		})
		
		b_density = _density
		b_golden = 0;
		
		command_set([
			20,
			2,
			function(){
				b_golden = bullet_preset_golden(x, y, 0, 2, b_golden, function(_x, _y, _dir){
					bullet_shoot_dir(_x, _y, 2, _dir).glow = cb_grey;
				})
				commandIndex--
			},
		]);
		
	},
	"miniboss1": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_car
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 100, 1/80, , function(){
			ignore textbox_scene_create([
				["a", [spr_portraitTest, 0, -1]],
				["b", [spr_car, 0, 1]],
				["c", [spr_portraitTest, 0, -1]],
				["e", [spr_car, 0, 1]],
				["what", [spr_portraitTest, 0, -1], func_nextAttack],
			]);
			func_nextAttack()
		});
		
		attacks = [
			function(){
				hp = 140;
				scoreGive = 50000;
				pointGive = 6;
				
				movement_start(WIDTH / 2, 50, 1/20)
				command_set([
					8,
					8,
					function(){
						bullet_preset_ring(x, y, 48, 8, irandom_range(0, 359), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 12, 0.3, 3, _dir + random_range(-1, 1));
						})
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 220;
				scoreGive = 100000;
				pointGive = 10;
				
				angle = 0;
				count = 0;
				dir = 1;
				command_set([
					function() {
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					50,
					function(){
						movement_start(x + irandom_range(-48, 48), y + irandom_range(-32, 16), 1/40, "linear");
					},
					1,
					function(){
						bullet_preset_ring(x, y, 13, 8, angle, function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 8, 0.12, 2, _dir) {
								sprite_index = spr_bullet_small;
							}
						});
						angle += 4 * dir;
						count += 1;
						if count < 40
							commandIndex--;
						else {
							count = 0;
							commandIndex = 0;
							angle = irandom_range(0, 180)
							dir *= -1;
							bullet_preset_plate(x, y, 9, 8, 16, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								bullet_shoot_dir2(_x, _y, 4, 0.1, 1, _dir).glow = cb_green;
							})
						}
					}
				])
			},
			function(){
				hp = 190;
				scoreGive = 200000;
				pointGive = 12;
				
				movement_start(WIDTH / 2, HEIGHT / 4, 1 / 20);
				command_set([
					12, 
					function(){
						bullet_shoot_dir2(irandom_range(16, WIDTH-16), -32, 12, 0.2, 3, 270, 1).sprite_index = spr_bullet_large;
						commandIndex--;
					}
				]);
				count = 0;
				angle = 0;
				command_add([
					30,
					function(){
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					40,
					function(){
						angle = point_direction(x, y, obj_player.x, obj_player.y);
					},
					16,
					function(){
						bullet_preset_plate(x, y, 3, 0, 16, 12, angle, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 4.5, _dir);
						})
						if count++ > 3 {
							count = 0;
							commandIndex = 0;
						} else commandIndex--;
					}
				]);
				
				command_add([
					6,
					function(){
						bullet_preset_ring(choose(-32, WIDTH + 32), irandom_range(60, HEIGHT / 2), 9, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 2, _dir) {
								sprite_index = spr_bullet_small;
								glow = cb_green;
							}
						});
						commandIndex--;
					}
				])
			},
		];

		
	},
	"miniboss2": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_car
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 100, 1/80, , function(){
			ignore textbox_scene_create([
				["im back", [spr_car, 0, 1]],
				["just", [spr_portraitTest, 0, -1]],
				["why", [spr_portraitTest, 0, -1]],
				["why not", [spr_car, 0, 1]],
				["go away", [spr_portraitTest, 0, -1], func_nextAttack],
			]);
		});
		
		attacks = [
			function(){
				hp = 140;
				scoreGive = 50000;
				pointGive = 8;
				
				movement_start(WIDTH / 2, 50, 1/20)
				command_set([
					8,
					6,
					function(){
						bullet_preset_ring(x, y, 54, 8, irandom_range(0, 359), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 12, 0.3, 3.5, _dir + random_range(-2, 2));
						})
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 220;
				scoreGive = 100000;
				pointGive = 10;
				
				angle = 0;
				count = 0;
				dir = 1;
				command_set([
					function() {
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					50,
					function(){
						movement_start(x + irandom_range(-48, 48), y + irandom_range(-32, 8), 1/50, "linear");
					},
					1,
					function(){
						bullet_preset_ring(x, y, 17, 8, angle, function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 8, 0.12, 2, _dir) {
								sprite_index = spr_bullet_small;
							}
						});
						angle += 4 * dir;
						count += 1;
						if count < 50
							commandIndex--;
						else {
							count = 0;
							commandIndex = 0;
							angle = irandom_range(0, 180)
							dir *= -1;
							bullet_preset_plate(x, y, 13, 8, 24, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								bullet_shoot_dir2(_x, _y, 4, 0.1, 1.5, _dir).glow = cb_green;
							})
						}
					}
				])
			},
			function(){
				hp = 190;
				scoreGive = 200000;
				pointGive = 12;
				
				movement_start(WIDTH / 2, HEIGHT / 4, 1 / 20);
				command_set([
					9, 
					function(){
						bullet_shoot_dir2(irandom_range(16, WIDTH-16), -32, 12, 0.2, 4, 270, 1).sprite_index = spr_bullet_large;
						commandIndex--;
					}
				]);
				count = 0;
				angle = 0;
				command_add([
					20,
					function(){
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					40,
					function(){
						angle = point_direction(x, y, obj_player.x, obj_player.y);
					},
					11,
					function(){
						bullet_preset_plate(x, y, 3, 0, 16, 12, angle, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 4.5, _dir);
						})
						if count++ > 4 {
							count = 0;
							commandIndex = 0;
						} else commandIndex--;
					}
				]);
				
				command_add([
					4,
					function(){
						bullet_preset_ring(choose(-32, WIDTH + 32), irandom_range(60, HEIGHT / 2), 9, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 2, _dir) {
								sprite_index = spr_bullet_small;
								glow = cb_green;
							}
						});
						commandIndex--;
					}
				])
			},
		];

		
	},
};

stage = [
	function(){
		//enemy_delay("basic2", WIDTH / 2, 60, 1)// 120 + 8 * 60 + 16 * 40)
		time = 240
	},
	function(){
		enemy("basic1", WIDTH/2, 90)
		for (var i = 0; i < 8; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + i * 60)
		}
		for (var i = 0; i < 16; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + 8 * 60 + i * 40)
		}
		for (var i = 0; i < 32; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + 8 * 60 + 16 * 40 + i * 30)
		}
		enemy_delay("basic2", WIDTH / 2, 120, 120 + 8 * 60 + 16 * 40 + 60)
		for (var i = 2; i < 8; i++) {
			enemy_delay("basic2", irandom_range(96, WIDTH - 96), irandom_range(100, 140), 120 + 8 * 60 + 16 * 40 + 60 + i * 120)
		}
		time = 120 + 8 * 60 + 16 * 40 + 32 * 30 + 60 * 8
	},
	function(){
		enemy("miniboss1", 0, 0);
		
		time = -1
	},
	function(){
		time = 120
	},
	function(){
		enemy("miniboss2", 0, 0);
		
		time = -1
	}
];