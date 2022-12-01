// STAGE 1

event_inherited()

game_music(mus_stage1test)

enemies = {
	"basic1": function(){
		hp = 4;
		scoreGive = 100;
		pointGive = 2;
		
		sprite_index = spr_enemy_flower;
		
		startX = x;
		startY = y;
		
		x += irandom_range(-32, 32);
		y = -64;
		
		invinsible = true;
		movement_start(startX, startY, 1 / 20);
		
		command_timer(60 * 1, function(){
			movement_start(clamp(x + irandom_range(-64, 64), 96, WIDTH - 96), y + irandom_range(-16, 64), 1/180)
		})
		command_timer(60 * 4, function(){
			command_reset();
			movement_start(x + irandom_range(-96, 96), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
		})
		
		command_set([
			20,
			7,
			function(){
				invinsible = false
				bullet_shoot_dir2(x, y, 2, 0.3, 4.5, point_direction(x, y, obj_player.x, obj_player.y));
				commandIndex--;
			}
		]);
		
	},
	"basic2": function(){
		hp = 12;
		scoreGive = 200;
		pointGive = 2;
		
		sprite_index = spr_enemy_crystal;
		
		onGround = true;
		
		step = function(){
			if y > HEIGHT - HEIGHT / 3
				command_reset()
			if y > HEIGHT + 32 {
				instance_destroy()
			}
		}
		
		command_set([
			30,
			32,
			function(){
				bullet_preset_ring(x, y, 32, 8, wave(-360, 360, 10), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 2, 0.2, 3, _dir) {
						sprite_index = spr_bullet_point
						glow = cb_grey;
					}
				})
				commandIndex--;
			}
		]);
	},
	"big1": function(){
		hp = 50;
		scoreGive = 1000;
		pointGive = 3;
		
		sprite_index = spr_enemy_cat;
		
		startY = y;
		
		y = -64;
		
		movement_start(x, startY, 1/20);
		
		
		command_timer(60 * 6, function(){
			command_reset();
		})
		command_timer(60 * 8, function(){
			movement_start(x + irandom_range(-256, 256), -64, 1/360, , function(){ instance_destroy() })
		})
		
		command_set([
			30, 
			16,
			function(){
				bullet_preset_ring(x, y, 32, 8, wave(-360, 360, 10), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 6, 0.2, -3, _dir) {
						sprite_index = spr_bullet_inverted
						glow = cb_blue;
					}
				})
				commandIndex--;
			}
		])
	},
	"miniboss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_enemy_testBoss
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 120, 1/50, , func_nextAttack);
		
		attacks = [
			function(){
				hp = 40
				scoreGive = 10000;
				pointGive = 8;
				
				b_density = 56;
				b_range = 96;
				
				command_set([
					18,
					function(){
						bullet_preset_ring(x, y, b_density, 8, irandom_range(0, 360), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 8, 0.4, 2.4, _dir).glow = cb_green
						});
						commandIndex--;
					}
				]);
				
				command_add([
					60, 
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-b_range, b_range), 96, WIDTH - 96), irandom_range(60, 80), 1/60);
						commandIndex--;
					}
				]);
				
				hpMod = [
					function(){
						hp = 40;
						
						b_density = 60
						b_range = 64;
						
						command_get(0)[0] = 16
					},
					function(){
						hp = 40;
						
						b_density = 64
						b_range = 24;
						
						command_get(0)[0] = 14;
					},
				]
			},
			function(){
				hp = 80;
				scoreGive = 50000;
				pointGive = 12;
				
				game_focus_set(true);
				
				b_density = 7;
				
				command_set([
					20,
					function(){
						bullet_preset_plate(x, y, 5, 4, 135, 0, 90 + irandom_range(-8, 8), function(_x, _y, _dir){
							with bullet_shoot_vel(_x, _y, lengthdir_x(3, _dir), lengthdir_y(3, _dir)) {
								y_target = 5;
								y_accel = 0.1;
								
								glow = cb_green;
								sprite_index = spr_bullet_large;
								
								command_timer(irandom_range(60, 80), function(){
									bullet_preset_ring(x, y, 10, 4, irandom_range(0, 360), function(_x, _y, _dir){
										with bullet_shoot_dir2(_x, _y, 3, 0.1, 1, _dir) {
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
				
				hpMod = [
					function(){
						hp = 100;
						
						b_density = 10;
						command_get(0)[0] = 16
					},
					function(){
						hp = 140;
						
						b_density = 14;
						command_get(0)[0] = 14
					}
				]
			},
		]
	},
	"boss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_enemy_testBoss
		
		x = -120;
		y = -60;
		
		movement_start(WIDTH / 2, 90, 1/50, , function(){
			textbox_scene_create([
				["hi!"],
				["go away", undefined, function(){
					game_music(-1)
					func_nextAttack();
				}]
			])
		});
		
		//currentAttack = 1
		
		attacks = [
			function(){
				hp = 240
				scoreGive = 10000;
				pointGive = 8;
				
				b_1_density = 24
				b_1_speed = 2.5
				b_1_reload = 24;
				
				b_2_angle = 0;
				b_2_speed = 2.5
				b_2_reload = 8
				
				command_switch([
					function(){
						movement_start(clamp(x, WIDTH / 2 - 48, WIDTH / 2 + 48), 90, 1/20)
						command_set([
							20,
							b_1_reload,
							function(){
								bullet_preset_plate(x, y, 25, b_1_density, 4, -16, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir) {
									bullet_shoot_dir2(_x, _y, 8, 0.2, b_1_speed, _dir).glow = cb_blue;
								})
								commandIndex--;
							}
						]);
				
						command_add([
							60, 
							function(){
								movement_start(clamp(obj_player.x + irandom_range(-32, 32), 128, WIDTH - 128), irandom_range(40, 60), 1/60);
								commandIndex--;
							}
						]);
					}, 180,
					function(){
						command_set([
							20,
							b_2_reload,
							function(){
								var _dir = irandom_range(0, 360);
								bullet_preset_ring(x, y, 2, 0, _dir, function(_x, _y, _dir){
									bullet_preset_plate(_x, _y, 4, 3, 4, 0, _dir, function(_x, _y, _dir){
										bullet_shoot_dir(_x, _y, b_2_speed, _dir).glow = cb_yellow;
									})
								})
								bullet_preset_ring(x, y, 8, 0, _dir + 360 / 8 / 2, function(_x, _y, _dir){
									bullet_preset_plate(_x, _y, 2, 3, 4, 0, _dir, function(_x, _y, _dir){
										bullet_shoot_dir(_x, _y, b_2_speed, _dir).glow = cb_yellow;
									})
								})
								b_2_angle += 26.7;
								commandIndex--;
							}
						]);
					}, 360
				])				
				
				hpMod = [
					function(){
						hp = 240;
						
						b_1_density = 20
						b_1_reload = 16
						
						b_2_speed = 3;
						b_2_reload = 7;
					},
					function(){
						hp = 360;
						
						b_1_density = 18
						b_1_reload = 15;
						b_1_speed = 4
						
						b_2_reload = 8;
						
						command_switch_add(0, function(){
							command_add([
								10,
								48,
								function(){
									var _h = irandom_range(-24, 24);
									bullet_preset_plate(0, HEIGHT / 2 + _h, 56, 28, 4, -16 - irandom_range(0, 32), 0, function(_x, _y, _dir) {
										bullet_shoot_dir2(_x, _y, 6, 0.2, 2, _dir).glow = cb_yellow;
									})
									bullet_preset_plate(WIDTH, HEIGHT / 2 + _h, 56, 28, 4, -16 - irandom_range(0, 32), 180, function(_x, _y, _dir) {
										bullet_shoot_dir2(_x, _y, 6, 0.2, 2, _dir).glow = cb_yellow;
									})
									commandIndex--;
								}
							]);
						}, true);
						command_switch_set_time(0, 80);
						command_switch_add(1, function(){
							command_add([
								30,
								24,
								function(){
									with bullet_shoot_dir2(x, y, 12, 0.3, 3.5, point_direction(x, y, obj_player.x, obj_player.y)) {
										sprite_index = spr_bullet_large
										glow = cb_blue;
									}
									commandIndex--;
								}
							]);
						}, true)
					},
				]
			},
			function(){
				hp = 200
				scoreGive = 10000
				pointGive = 8
				
				b_1_accel = 0.1
				b_1_target = 0
				b_1_density = 32
				b_1_reload = 40
				
				b_2_amount = 12;
				b_2_speed = 4;
				b_2_dir = 0;
				b_2_turn = 1;
				b_2_reload = 12;
				
				command_switch([
					function(){ // Rain
						command_set([
							b_1_reload,
							function(){
								bullet_preset_ring(x, y, b_1_density, -64, random_range(0, 360), function(_x, _y, _dir){
									with bullet_shoot_vel(_x, _y, lengthdir_x(12, _dir), lengthdir_y(4, _dir)) {
										sprite_index = spr_bullet_point;
										glow = cb_blue;
										x_accel = other.b_1_accel
										x_target = other.b_1_target * x_vel;
										y_accel = 0.01
										y_target = 2
										step = function(){
											if x < 0 {
												x_vel *= -1
												x = 0
											}
											if x > WIDTH {
												x_vel *= -1
												x = WIDTH
											}
										}
									}
								})
						
								commandIndex--
							}
						]);
						
						command_add([
							120,
							function(){
								movement_start(clamp(obj_player.x + irandom_range(-8, 8), 96, WIDTH - 96), irandom_range(80, 90), 1/60);
								commandIndex--;
							}
						]);
					}, 240,
					function(){ // Speed
						command_set([
							b_2_reload,
							function(){
								var _d = wave(-5, 5, 15);
								b_2_turn = _d;
								bullet_preset_ring(x, y, b_2_amount, 0, b_2_dir, function(_x, _y, _dir){
									with bullet_shoot_dir2(x, y, 10, 0.5, b_2_speed, _dir, 4) {
										glow = cb_yellow;
										dir_target = dir + 90 * other.b_2_turn / 5;
										dir_accel = 3;
									}
								})
								b_2_dir += _d;
						
								commandIndex--;
							}
						]);
						
						command_add([
							120,
							function(){
								movement_start(clamp(obj_player.x + irandom_range(-8, 8), 96, WIDTH - 96), irandom_range(80, 90), 1/60);
								commandIndex--;
							}
						])
					}, 360
				])
				
				
				
				hpMod = [
					function(){
						hp = 240;
						
						b_1_reload = 32;
						b_1_accel = 0.07;
						b_1_density = 38
												
						b_2_reload = 10;
						b_2_speed = 4.5
						b_2_amount = 14;
					},
					function(){
						hp = 240;
						
						b_1_reload = 24;
						b_1_density = 42
						
						b_2_reload = 8;
						b_2_speed = 5
						b_2_amount = 15;
					}
				];
				
			},
			function(){
				hp = 150
				scoreGive = 60000
				pointGive = 12
				
				b_dir = -1
				b_density = 50;
				b_angleDensity = 6
				b_rotateSpeed = 0.1
				b_speed = 1
				
				movement_start(WIDTH / 2, 90, 1/30);
				
				command_set([
					60,
					function(){
						bullet_group_start(x, y)
						bullet_preset_ring(x, y, b_angleDensity, 32, point_direction(x, y, obj_player.x, obj_player.y) + 360 / b_angleDensity / 2, function(_x, _y, _dir){
							bullet_preset_line2(_x, _y, _dir, b_density, 16, function(_x, _y) {
								with bullet_shoot(_x, _y) {
									deathBorder = -1;
									glow = cb_blue
									step = function(){
										if y > HEIGHT + 64 instance_destroy()
									}
								}
							})
						})
						with bullet_shoot(x, y) {
							sprite_index = spr_bullet_large
							glow = cb_blue
						}
						with bullet_group_end() {
							b_dir = other.b_dir;
							b_rotateSpeed = other.b_rotateSpeed;
							b_speed = other.b_speed;
							dir = point_direction(x, y, obj_player.x, obj_player.y);
							spd = 0;
							spd_accel = 0.01;
							spd_target = b_speed;
							step = function(){
								rotate(b_dir * b_rotateSpeed * global.delta_multi)
							}
						}
						b_dir *= -1;
					},
					180,
					function(){
						commandIndex = 0;
					}
				]);
				
				hpMod = [
					function(){
						hp = 300;
						
						b_density = 44
						b_angleDensity = 12
						b_speed = 1.2
						command_get(0)[0] = 40
					},
					function(){
						hp = 400;
						
						b_density = 42
						b_angleDensity = 15
						b_speed = 1.4
						b_rotateSpeed = 0.12
						command_get(0)[0] = 30;
						
						command_add([
							96,
							function(){
								bullet_preset_plate(0, HEIGHT / 2 + irandom_range(-48, 48), 56, 48, 4, -16 - irandom_range(0, 32), 0, function(_x, _y, _dir) {
									bullet_shoot_dir2(_x, _y, 6, 0.2, 2, _dir).glow = cb_yellow;
								})
								bullet_preset_plate(WIDTH, HEIGHT / 2 + irandom_range(-48, 48), 56, 48, 4, -16 - irandom_range(0, 32), 180, function(_x, _y, _dir) {
									bullet_shoot_dir2(_x, _y, 6, 0.2, 2, _dir).glow = cb_yellow;
								})
								commandIndex--;
							}
						]);
					},
				]
			},
		]
	}
};

//stageIndex = 6;

stage = [
	function(){
		time = 60 * 0.76 - 20;
	},
	function(){
		game_background( , 1);
		for (var i = 0; i < 16; i++)
			enemy_delay("basic1", WIDTH / 2 + irandom_range(-196, 196), irandom_range(32, 96), i * (60 * 0.76));
		time = 16 * (60 * 0.76) + 60;
	},
	function(){
		game_background( , 4);
		
		enemy_delay("big1", WIDTH / 2, 90, 60);
		
		time = 60 * 6;
	},
	function(){
		for (var i = 0; i < 16; i++)
			enemy_delay("basic1", WIDTH / 2 + irandom_range(-128, 128), irandom_range(32, 120), i * (60 * 1));
		
		enemy_delay("big1", WIDTH / 2, 90, 60 * 2);
		enemy_delay("big1", WIDTH / 2, 90, 60 * 8);
			
		time = 16 * (60 * 1) + 60 * 2;
	},
	function(){
		game_background([1, 2] , 1);
		
		for (var i = 0; i < 8; i += 2) {
			enemy_delay("basic2", WIDTH / 2 + -190, -32, i * (60 * 1));
			enemy_delay("basic2", WIDTH / 2 +  190, -32, (i + 1) * (60 * 1));
		}
		
		time = 8 * (60 * 1) + 60 * 3;
	},
	function(){
		game_background([3, 4], 4);
		
		enemy_delay("miniboss", 0, 0, 60 * 1);
		
		time = -1;
	},
	function(){
		game_background([5, 6], 2)
		spawnUpgrade()
		
		time = 30
	},
	function(){
		
		for (var i = 0; i < 25; i++)
			enemy_delay("basic1", WIDTH / 2 + irandom_range(-96, 96), irandom_range(32, 96), i * (60 * 1));
			
		for (var i = 0; i < 8; i += 2) {
			enemy_delay("basic2", WIDTH / 2 + -190, -32, 60 * 4 + i * (60 * 2));
			enemy_delay("basic2", WIDTH / 2 +  190, -32, 60 * 4 + (i + 1) * (60 * 2));
		}
		
		enemy_delay("big1", WIDTH / 2, 90, 60 * 10);
		enemy_delay("big1", WIDTH / 2, 90, 60 * 17);
		
		time = 60 * 27;
	},
	function(){
		game_background(, 1);
		
		enemy_delay("boss", 0, 0, 60)
		
		time = -1;
	}, 
	function(){
		spawnUpgrade()
		
		time = -1
	},
	function(){
		time = 120
	},
	function(){
		game_music(-1)
		game_nextRoom(rm_stage2);
	}
];