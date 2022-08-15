event_inherited();

enemies = {
	"basic": function(_spd = 6, _intensity = 0){
		hp = 3;	
		sprite_index = spr_enemy_flower;
		
		spd = _spd;
		intensity = _intensity // doesnt work
		
		polarity = sign(x - WIDTH / 2);
		
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * -polarity, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * -polarity)) * spd, "linear",function(){instance_destroy()});
		
		command_set([
			4,
			function(){
				bullet_preset_plate(x, y, 3, 0, 16 + intensity, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
					bullet_shoot_dir2(_x, _y, 0.5, 0.3, 15, _dir);
				})	
				commandIndex--;
			},
		])
		command_add([
			6,
			function(){
				bullet_preset_plate(x, y, 2, 24, 20 + intensity, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
					bullet_shoot_dir2(_x, _y, 4, 1, 22, _dir).glow = cb_green;
				})
				commandIndex--;
			},
		])
	},
	"big1": function(){
		hp = 180;
		maxhp = 120;
		scoreGive = 10000
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_cat;
		
		command_set([
			function(){
				movement_start(x, startY, 1 / 20);
				command_timer(60 * 1, function(){
					command_add([
						8,
						function(){
							var pos = choose(30, WIDTH - 30)
							with bullet_shoot_vel(pos, obj_player.y + irandom_range(-24, 24), sign(obj_player.x - pos) * 2, 0) {
								sprite_index = spr_bullet_inverted;
								glow = cb_pink;
								
								y_accel = 0.001;
								
								x_accel = 0.02;
								x_target = sign(x_vel) * 0.6;
							}
							commandIndex--;
						}
					])
				})
				command_timer(60 * 10, function(){
					command_reset()
				})
				command_timer(60 * 11, function(){
					movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
				})
			},
			44,
			function(){
				bullet_preset_ring(x, y, 100, 8, irandom_range(0, 360), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 8.5, 0.1, 0.5, _dir) {
						glow = cb_blue;
						sprite_index = spr_bullet_arrow;
					}
				})
				commandIndex--;
			},
		]);
	},
	"basic2": function(_hp = 64){
		hp = _hp;
		
		scoreGive = 4000;
		sprite_index = spr_enemy_thing;
		
		startY = y;
		y = -50;
		
		movement_start(x, startY, 1/20,,function(){
			command_timer(60*8, function(){
				command_reset()
				movement_start(x, -64, 1/80, "smoothStart", function(){ instance_destroy() });
			})
			command_set([
				32,
				function(){
					bullet_preset_plate(x, y, 15, 0, 270, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
						for (var i = 1; i <= 3; i++) 
							with bullet_shoot_dir(_x, _y, i * 1, _dir) {
								glow = cb_green;
							}
						
					});
					commandIndex--;
				}
			])
		})
	},
	"big1_2": function(_density = 80){
		hp = 120;
		maxhp = 120;
		scoreGive = 10000
		
		density = _density;
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_cat;
		
		command_set([
			function(){
				movement_start(x, startY, 1 / 40);
				command_timer(60 * 10, function(){
					command_reset()
				})
				command_timer(60 * 11, function(){
					movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
				})
			},
			80,
			function(){
				bullet_preset_ring(x, y, density, 8, irandom_range(0, 360), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 10, 0.2, 0.8, _dir) {
						glow = cb_blue;
						sprite_index = spr_bullet_arrow;
					}
				})
				commandIndex--;
			},
		]);
	},
	"basic3" : function(){
		hp = 6;
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_flower
		
		movement_start(x, startY, 1/20);
		
		command_timer(60 * 2, function(){
			movement_start(irandom_range(-32, WIDTH + 32), HEIGHT + 64, 1/300, "smoothStart", function(){ instance_destroy() });
		})
		
		command_set([
			30,
			14,
			function(){
				bullet_group_start(x, y);
					bullet_preset_poly(x, y, 4, 3, 2, function(_x, _y, _dir){
						with bullet_shoot(_x, _y) {
							glow = cb_pink
							sprite_index = spr_bullet_small
						}
					});
				lastGroup = bullet_group_end();
				with lastGroup {
					growVel = 0.3;
					growAccel = 0.016;
					rotate(irandom_range(0, 360))
					step = function(){
						scale(1 + growVel);
						growVel = max(0, growVel - growAccel);
					}
					command_timer(20, function(){
						for (var i = 0; i < array_length(bullets); i++) {
							bullets[i].dir = point_direction(bullets[i].x, bullets[i].y, obj_player.x, obj_player.y) + random_range(-2, 2);
							bullets[i].spd = 3;
						}
					})
				}
				
				commandIndex--;
			},
		])
	},
	"big2": function(){
		hp = 160;
		
		scoreGive = 10000;
		sprite_index = spr_enemy_crystal;
		
		startY = y;
		y = -64;
		
		movement_start(x, startY, 1/30);
		
		command_timer(60 * 6, function(){
			command_reset()
			movement_start(irandom_range(-32, WIDTH + 32), -64, 1/100, "smoothStart", function(){ instance_destroy() });
		})
		
		rad = 64;
		
		command_set([
			40,
			2,
			function(){
				bullet_preset_ring(x, y, 13, rad, wave(-360 * 4, 360 * 4, 14), function(_x, _y, _dir){
					with bullet_shoot_dir(_x, _y, 4, _dir) {
						sprite_index = spr_bullet_point;
						glow = cb_teal;
					}
				})
				rad = max(rad - 1, 8);
				
				commandIndex--;
			}
		])
	},
	"miniboss1": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 120, 1/50, , func_nextAttack);
		
		attacks = [
			function(){
				hp = 340;
				
				command_set([
					16,
					function(){
						bullet_preset_plate(x, y, 5, 4, 135, 0, 90 + irandom_range(-8, 8), function(_x, _y, _dir){
							with bullet_shoot_vel(_x, _y, lengthdir_x(3, _dir), lengthdir_y(3, _dir)) {
								y_target = 5;
								y_accel = 0.1;
								
								glow = cb_teal;
								sprite_index = spr_bullet_large;
								
								command_timer(irandom_range(70, 110), function(){
									bullet_preset_ring(x, y, 12, 8, irandom_range(0, 360), function(_x, _y, _dir){
										with bullet_shoot_dir(_x, _y, 1, _dir) {
											glow = cb_pink;
											sprite_index = spr_bullet_arrow;
										}
									})
									instance_destroy()
								})
							}
						})
						commandIndex--
					},
				])
				command_add([
					30,
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-32, 32), 96, WIDTH - 96), irandom_range(50, 100), 1/20);
						commandIndex--
					}
				])
			},
			function(){
				hp = 400;
				
				lastX = obj_player.x;
				lastY = obj_player.y;
				
				angle = 0
				
				command_set([
					2,
					function(){
						bullet_preset_ring(lastX, lastY, 48, 128, angle, function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 2, 1, 16, _dir, 3) {
								glow = cb_grey
								sprite_index = spr_bullet_large
							}
						});
						lastX = lerp(lastX, obj_player.x, 1 - power(1 - 0.6, global.delta_milli));
						lastY = lerp(lastY, obj_player.y - 8, 1 - power(1 - 0.6, global.delta_milli));
						angle += 360 / 48 / 2;
						commandIndex--;
					}
				]);
				
				targetAngle = 0;
				count = 0;
				
				command_add([
					12,
					function(){
						targetAngle = irandom_range(0, 360);
					},
					4,
					function(){
						bullet_preset_ring(x, y, 32, 0, targetAngle, function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 4, _dir) {
								glow = cb_yellow;
							}
						})
						if count++ > 8 {
							count = 0;
						} else {
							commandIndex--;
						}
					},
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-32, 32), 96, WIDTH - 96), irandom_range(50, 100), 1/12);
						commandIndex = 0;
					},
				]);
				
				command_add([
					12,
					function(){
						bullet_preset_ring(x, y, 64, 0, irandom_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 3, _dir) {
								glow = cb_green;
								sprite_index = spr_bullet_small
							}
						})
						commandIndex--;
					}
				])
			}
		]
		
	},
}

stage = [
	function(){
		for (var i = 0; i < 8; i++)
			enemy("basic", WIDTH + 64 + i * 44, 60, [undefined, 6]);
			
		for (var i = 0; i < 8; i++)
			enemy("basic", -64 - i * 44, 90, [undefined, 6]);
		
		time = 180;
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy("basic", WIDTH + 64 + i * 44, 40, [3]);
			
		for (var i = 0; i < 8; i++)
			enemy("basic", -64 - i * 44, 70, [3]);
			
		time = 60;
	},
	function(){
		for (var i = 0; i < 6; i++)
			enemy("basic", WIDTH + 64 + i * 44, 80, [2]);
			
		for (var i = 0; i < 6; i++)
			enemy("basic", -64 - i * 44, 100, [2]);
			
		time = 220;
	},
	function(){
		enemy("big1", WIDTH / 2, 60)
		
		time = 60 * 12;
	},
	function(){
		enemy("basic2", WIDTH / 2, 60, [64])
		
		time = 60 * 6;
	},
	function(){
		enemy("basic2", 110, 60)
		enemy("basic2", WIDTH - 110, 60)
		
		enemy_delay("big1_2", WIDTH / 2, 100, 120)
		
		time = 60 * 12;
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy_delay("basic3", irandom_range(110, WIDTH - 110), irandom_range(80, 120), i * 80);
		
		enemy_delay("basic2", WIDTH / 2, 60, 80 * 3 + 30)
		
		time = 60 * 8 + 80 * 4;
	},
	function(){
		for (var i = 0; i < 12; i++)
			enemy_delay("basic3", irandom_range(110, WIDTH - 110), irandom_range(80, 120), i * 60 + 20);
		
		enemy("basic2", 110, 80)
		enemy("basic2", WIDTH - 110, 80)
		
		enemy_delay("big1_2", WIDTH / 2, 100, 60 * 8 - 30, [60])
		
		time = 60 * 12 + 60 * 7;
	},
	function(){
		for (var i = 0; i < 3; i++)
			enemy_delay("big2", WIDTH / 2, 40 + i * 30, i * 60 * 8);
		
		time = 60 * 8 * 3 + 60 * 2;
	},
	function(){
		enemy("miniboss1", WIDTH / 2, 0);
		
		time = -1;
	},
	function(){ time = 120; },
	function(){ time = -1; },
	function(){ game_stop(); }
]
