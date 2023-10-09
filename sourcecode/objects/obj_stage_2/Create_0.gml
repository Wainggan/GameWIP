// STAGE 2

event_inherited()

game_music(mus_stage2)


// ~~ ENEMIES ~~

addEnemy("basic1", function(){
	setHp(5);
	setPoints(100, 1);
	
	setSprite(spr_enemy_flower_red);
		
	startX = x;
	startY = y;
		
	x += irandom_range(-128, 128);
	y = -64;
		
	setInvincible(true)
	movement_start(startX, startY, 1 / 30, , function(){ setInvincible(false) });
	
	command_timer(60 * 12, function(){
		command_reset();
		movement_start(x + irandom_range(-64, 64), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
	})
		
	b_reload = 4;
	b_dir = 0;
		
	command_set([
		20,
		10,
		function(){
			b_dir = point_direction(x, y, obj_player.x, obj_player.y)
		},
		3,
		function(){
			bullet_shoot_dir2(x, y, 0, 0.2, 11, b_dir).glow = cb_pink;
			if b_reload-- > 0 commandIndex--
		},
		20,
		function(){
			b_reload = 4;
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
			bullet_preset_plate(x, y, 2, 24, 48, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, 4, 2, 14, _dir).glow = cb_green;
			})
			commandIndex--;
		},
	])
})

addEnemy("basic2", function(){
	setHp(16)
	setPoints(1000, 3)
	
	setSprite(spr_enemy_fire)
		
	startX = x;
	startY = y;
		
	x += irandom_range(-16, 16);
	y = -64;
	
	setInvincible(true);
	movement_start(startX, startY, 1 / 30, , function(){ setInvincible(false) });
		
	command_timer(60 * 12, function(){
		command_reset();
		movement_start(x + irandom_range(-256, 256), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
	})
		
	b_golden = random_range(0, 12);
		
	command_set([
		24,
		2,
		function(){
			b_golden = bullet_preset_golden(x, y, 0, 2, b_golden, function(_x, _y, _dir){
				bullet_shoot_dir(_x, _y, 2, _dir).glow = cb_grey;
			})
			commandIndex--
		},
	]);
})


enemies = {
	"basic3": function(_dir, _spd, _off = 0, _r = 5){
		hp = 120;
		scoreGive = 2000;
		pointGive = 6;
		
		b_off = _off
		
		sprite_index = spr_enemy_flower
		
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * _dir, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * _dir)) * _spd, "linear",function(){instance_destroy()});
		
		command_set([
			_r,
			function(){
				bullet_preset_plate(x, y, 3, 6, 90, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 7, 0.2, 1, _dir) {
						glow = cb_teal
						sprite_index = spr_bullet_point//spr_bullet_small
						
						command_timer(30, function(){
							dir_target = point_direction(x, y, obj_player.x, obj_player.y)
							dir_accel = 1
							glow = cb_pink
							spd_target = 7;
							spd_accel = 0.14
						})
					}
				})
				commandTimer = b_off;
				b_off = 0;
				commandIndex--;
			}
		])
		
	},
	"basic4": function() {
		hp = 180
		scoreGive = 1000
		pointGive = 8
		
		startX = x;
		startY = y;
		
		x = x + irandom_range(-96, 96)
		y = -64
		
		invinsible = true;
		movement_start(startX, startY, 1/120, , function(){invinsible = false});
		
		
		command_timer(60 * 10, function(){
			command_reset()
			movement_start(WIDTH / 2 + WIDTH * choose(-1, 1), y + 128, 1/360, , function(){
				instance_destroy()
			})
		})
		
		b_golden = 0
		
		command_set([
			120,
			2,
			function(){
				b_golden = bullet_preset_golden(x, y, 8, 3, b_golden, function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 14, 0.4, 1, _dir) {
						glow = cb_pink
						//sprite_index = spr_bullet_huge
					}
				})
				commandIndex--
			}
		])
		
		command_add([
			120 + 60,
			24,
			function(){
				with bullet_shoot_dir2(x, y, 1, 0.1, 4, point_direction(x, y, obj_player.x, obj_player.y)) {
					glow = cb_teal
					sprite_index = spr_bullet_inverted
				}
				commandIndex--
			}
		])
		
	},
	"basic5": function(){
		hp = 20;
		scoreGive = 2000;
		pointGive = 1;
		
		startX = x;
		startY = y;
		
		x += irandom_range(-64, 64);
		y = -64
		
		movement_start(startX, startY, 1 / 180, "linear", function(){ instance_destroy() });
		
		step = function(){
			if y > HEIGHT / 2 + 96 { 
				command_reset()
				step = undefined
			}
		}
		
		command_set([
			40,
			function(){
				bullet_preset_ring(x, y, 16, 8, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
					with bullet_shoot_dir(_x, _y, 2, _dir) {
						glow = cb_pink;
						sprite_index = spr_bullet_arrow;
					}
				})
				commandIndex--;
			}
		])
		
	},
	"idiot": function(_dir, _spd){
		hp = 3;
		scoreGive = 100;
		pointGive = 1;
		
		deathRadius = 96
		important = 2
		
		sprite_index = spr_enemy_flower
		
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * _dir, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * _dir)) * _spd, "linear",function(){instance_destroy()});
		
		onDeath = function(){
			var inst = instance_create_layer(x, y + 128, layer, obj_bulletDestroyer)
			inst.targetSize = deathRadius
			inst.sizeSpeed = 16;
			inst.bulletBonus = true;
		}
		
	},
	"miniboss1": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		bossFlag = true;
		important = true;
		invinsible = true;
		ignoreSlap = true;
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
				hp = 130;
				time(60 * 6, 60 * 5)
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
				
				command_add([
					24,
					1,
					function(){
						with bullet_shoot_dir2(choose(72, WIDTH - 72) + irandom_range(-112, 112), HEIGHT + 32, 0, 0.2, 9, 90, 1) {
							glow = cb_green;
							sprite_index = spr_bullet_large
						}
						
						commandIndex--
					}
				])
			},
			function(){
				hp = 180;
				time(60 * 11, 60 * 8)
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
								bullet_shoot_dir2(_x, _y, 6, 0.1, 2, _dir).glow = cb_green;
							})
						}
					}
				])
			},
			function(){
				hp = 180;
				time(60 * 11, 60 * 9)
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
						bullet_preset_plate(x, y, 2, 0, 16, 12, angle, function(_x, _y, _dir){
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
		bossFlag = true;
		important = true;
		invinsible = true;
		ignoreSlap = true;
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
				hp = 130;
				time(60 * 6, 60 * 5)
				scoreGive = 50000;
				pointGive = 6;
				
				movement_start(WIDTH / 2, 50, 1/20)
				command_set([
					8,
					7,
					function(){
						bullet_preset_ring(x, y, 56, 8, irandom_range(0, 359), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 12, 0.3, 3.5, _dir + random_range(-1, 1));
						})
						commandIndex--;
					}
				]);
				
				command_add([
					24,
					1,
					function(){
						with bullet_shoot_dir2(choose(72, WIDTH - 72) + irandom_range(-124, 124), HEIGHT + 32, 4, 0.4, 16, 90, 1) {
							glow = cb_green;
							sprite_index = spr_bullet_large
						}
						
						commandIndex--
					}
				])
			},
			function(){
				hp = 180;
				time(60 * 11, 60 * 8)
				scoreGive = 100000;
				pointGive = 10;
				
				b_angle = 0;
				b_count = 0;
				b_dir = 1;
				command_set([
					function() {
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					50,
					function(){
						movement_start(x + irandom_range(-48, 48), y + irandom_range(-32, 32), 1/50, "linear");
					},
					2,
					function(){
						bullet_preset_ring(x, y, 25, 8, b_angle, function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 8, 0.12, 2, _dir) {
								sprite_index = spr_bullet_small;
							}
						});
						b_angle += (360 / 25) / 2 / 2 * b_dir;
						b_count += 1;
						if b_count < 25
							commandIndex--;
						else {
							b_count = 0;
							commandIndex = 0;
							b_angle = irandom_range(0, 180)
							b_dir *= -1;
							bullet_preset_plate(x, y, 36, 12, 16, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								bullet_shoot_dir2(_x, _y, 6, 0.1, 2, _dir).glow = cb_green;
							})
						}
					}
				])
			},
			function(){
				hp = 180;
				time(60 * 11, 60 * 9)
				scoreGive = 200000;
				pointGive = 12;
				
				movement_start(WIDTH / 2, HEIGHT / 4, 1 / 20);
				command_set([
					10, 
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
					14,
					function(){
						bullet_preset_plate(x, y, 6, 0, 38, 12, angle, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 5, _dir);
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
	"boss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		bossFlag = true;
		important = true;
		invinsible = true;
		ignoreSlap = true;
		canDie = false;
		
		sprite_index = spr_car
		
		x = -74;
		y = -60;
		
		movement_start(WIDTH / 2, 100, 1/120, , function(){
			textbox_scene_create([
				["a", [spr_portraitTest, 0, -1]],
				["b", [spr_car, 0, 1]],
				["c", [spr_portraitTest, 0, -1]],
				["e", [spr_car, 0, 1]],
				["what", [spr_portraitTest, 0, -1], function() {
					game_music(mus_boss2)
					//audio_play_sound(mus_boss2, 0, false)
					func_nextAttack()
				}],
			]);
		});
		
		//currentAttack = 4;
		
		attacks = [
			function(){
				hp = 170;
				time([60 * 8, 60 * 18, 60 * 28], 60 * 23)
				scoreGive = 50000;
				pointGive = 6;
				
				b_golden = 0
				b_1_speed = 1;
				b_2_speed = 2;
				b_2_density = 2;
				
				command_switch([
					function(){
						command_set([
							2, 
							function(){
								b_golden = bullet_preset_golden(x, y, 0, 6, b_golden + 2, function(_x, _y, _dir, i) {
									with bullet_shoot_dir3(_x, _y, 8, 0.2, 1, 0.05, i % 2 == 0 ? b_1_speed * 2 : -b_1_speed, _dir) {
										sprite_index = spr_bullet_small;
									}
								})
								commandIndex--
							}
						]);
						command_add([
							120,
							function(){
								movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 96 + irandom_range(-8, 64), 1/60);
								commandIndex--;
							}
						])
					}, 60 * 5,
					function(){
						command_set([
							2, 
							function(){
								b_golden = bullet_preset_golden(x, y, 0, b_2_density, b_golden, function(_x, _y, _dir, i) {
									with bullet_shoot_dir3(_x, _y, 1, 0.2, 6, 0.1, b_2_speed, _dir) {
										sprite_index = spr_bullet_arrow;
										glow = cb_green
										dir_target = dir + angle_difference(point_direction(x, y, obj_player.x, obj_player.y), dir) * 0.5;
										dir_accel = 2;
									}
								});
								commandIndex--
							}
						]);
						command_add([
							60 * 2,
							function(){
								movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 96 + irandom_range(-8, 16), 1/60);
								commandIndex--;
							}
						]);
					}, 60 * 5,
				]);
				
				hpMod([
					function(){
						hp = 150;
						
						b_1_speed = 1.5;
					},
					function(){
						hp = 270;
						
						command_switch_add(1, function(){
							command_add([
								12,
								function(){
									with bullet_shoot_dir3(x, y, 10, 0.3, 1, 0.1, 4, point_direction(x, y, obj_player.x, obj_player.y)) {
										glow = cb_teal;
										sprite_index = spr_bullet_point;
									}
									commandIndex--
								}
							])
						})
						
					},
				]);
			},
			function(){
				hp = 280;
				time([60 * 12, 60 * 28], 60 * 23)
				scoreGive = 50000;
				pointGive = 6
				
				b_1_amount = 16;
				b_1_dir = 0;
				b_1_turn = 1;
				b_1_dir2 = 0;
				b_1_count2 = 0;
				
				command_switch([
					function(){
						command_set([
							13,
							function(){
								bullet_preset_ring(x, y, b_1_amount, 0, b_1_dir, function(_x, _y, _dir){
									with bullet_shoot_dir2(x, y, 10, 0.5, 3, _dir, 4) {
										glow = cb_red;
										dir_target = dir + 90 * (other.b_1_turn/5);
										dir_accel = other.b_1_turn / 5 * 4;
									}
								})
								var _d = wave(-5, 5, 15);
								b_1_turn = _d;
								b_1_dir += _d;
						
								commandIndex--;
							}
						]);
						command_add([
							60 * 3,
							function(){
								b_1_dir2 = point_direction(x, y, obj_player.x, obj_player.y);
								b_1_count2=  0
							},
							8,
							function(){
								b_1_dir2 += angle_difference(point_direction(x, y, obj_player.x, obj_player.y), b_1_dir2) * 0.1;
								bullet_preset_ring(x, y, 38, 0, b_1_dir2, function(_x, _y, _dir){
									with bullet_shoot_dir3(x, y, 0, 1, 10, 0.5, 4, _dir, 4) {
										glow = cb_green;
										sprite_index = spr_bullet_arrow;
									}
								})
								if b_1_count2++ >= 7 commandIndex = 0;
								else commandIndex--;
							}
						]);
						command_add([
							60 * 2,
							function(){
								movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 96), 96 + irandom_range(-8, 64), 1/60);
								commandIndex--;
							}
						]);
					}, 60 * 4
				]);
				
				hpMod([
					function(){
						hp = 320;
						
						command_switch_push([
							function(){
								command_set([
									4,
									function(){
										bullet_preset_ring(x, y, 24, 9, random(360), function(_x, _y, _dir, i){
											with bullet_shoot_dir2(_x, _y, 4, 0.4, i % 2 == 0 ? 1 : 2, _dir) {
												sprite_index = spr_bullet_small;
												glow = cb_yellow;
											}
										})
										commandIndex--;
									}
								]);
							}, 60
						]);
						command_switch_set(1);
						
					}
					
					
					
				])
			},
			function(){
				hp = 700;
				//time(60 * 11, 60 * 9)
				scoreGive = 200000;
				pointGive = 12;
				
				command_set([
					4, 
					function(){
						bullet_preset_ring(x, y, 9, 32, wave(-360, 360, 14), function(_x, _y, _dir){
							bullet_shoot_dir3(_x, _y, 1, 2, 12, 0.5, 2, _dir).sprite_index = spr_bullet_arrow;
						})
						
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
					28,
					function(){
						bullet_preset_plate(x, y, 8, 0, 80, 12, angle, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 3, _dir);
						})
						if count++ > 4 {
							count = 0;
							commandIndex = 0;
						} else commandIndex--;
					}
				]);
				
				command_add([
					5,
					function(){
						bullet_preset_ring(choose(-32, WIDTH + 32), 20, 9, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 1, _dir) {
								sprite_index = spr_bullet_small;
								glow = cb_green;
							}
						});
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 450;
				//time(60 * 11, 60 * 9)
				scoreGive = 200000;
				pointGive = 12;
			
				movement_start(WIDTH / 2, 110, 1/60);
				
				command_set([
					50,
					3,
					function(){
						bullet_preset_ring(x, y, 7, 0, wave(-720*2, 720*2, 6), function(_x, _y, _dir){
							with bullet_shoot_dir3(_x, _y, 0, 0.1, 5, 0.2, 2, _dir) {
								sprite_index = spr_bullet_small
								glow = cb_red
							}
						});
						commandIndex--;
					}
				]);
				b_count = 0;
				command_timer(120, function(){
					command_add([
						70,
						function(){
							b_count = irandom_range(0, 1);
							bullet_preset_plate(x, y, 17, 20, 32, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								with bullet_shoot_dir3(_x, _y, 9, 0.18, 0.1, 0.02, 0.7, _dir) {
									sprite_index = spr_bullet_point;
									glow = cb_green;
									if other.b_count++ % 2 == 1 {
										step = method(self, function(){
											if y > HEIGHT {
												dir += 180;
												y_accel = 0.004;
												spd += random_range(-0.4, 0.8);
												step = undefined;
											}
										});
										command_timer(140, function(){ glow = cb_blue })
									}
									
								}
							})
							commandIndex--;
						}
					])
				});
				command_add([
					60 * 2,
					function(){
						movement_start(approach(x, obj_player.x + irandom_range(-16, 16), 32), 110 + irandom_range(-8, 32), 1/40);
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 170;
				//time([60 * 18, 60 * 28], 60 * 23)
				scoreGive = 50000;
				pointGive = 6;
				
				b_golden = 0
				b_1_speed = 1;
				b_2_speed = 2.5;
				b_2_density = 3;
				b_2_mode = 0;
				b_2_amount = 1;
				b_2_reload = 24;
				
				command_switch([
					function(){
						command_set([
							2, 
							function(){
								b_golden = bullet_preset_golden(x, y, 0, 9, b_golden + 3, function(_x, _y, _dir, i) {
									with bullet_shoot_dir3(_x, _y, 8, 0.2, 1, 0.05, i % 2 == 0 ? b_1_speed * 2 : -b_1_speed, _dir) {
										sprite_index = spr_bullet_small;
									}
								})
								commandIndex--
							}
						]);
						command_add([
							120,
							function(){
								movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 96 + irandom_range(-8, 64), 1/60);
								commandIndex--;
							}
						])
					}, 60 * 2,
					function(){
						command_set([
							2, 
							function(){
								b_golden = bullet_preset_golden(x, y, 0, b_2_density, b_golden, function(_x, _y, _dir, i) {
									with bullet_shoot_dir3(_x, _y, 1, 0.2, 6, 0.1, b_2_speed, _dir) {
										sprite_index = spr_bullet_arrow;
										glow = cb_green
										dir_target = dir + angle_difference(point_direction(x, y, obj_player.x, obj_player.y), dir) * 0.5;
										dir_accel = 2;
									}
								});
								commandIndex--
							}
						]);
						command_add([
							b_2_reload,
							function(){
								bullet_preset_plate(x, y, b_2_amount, 4, 16, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
									with bullet_shoot_dir3(_x, _y, 10, 0.3, 1, 0.1, 4, _dir) {
										glow = cb_teal;
										sprite_index = spr_bullet_point;
										step = method(self, function(){
											if y > HEIGHT {
												dir += 180;
												y_accel = 0.06;
												spd += random_range(-0.4, 0);
												step = undefined;
											}
										});
									}
								})
								commandIndex--
							}
						])
						movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 128 + irandom_range(-8, 16), 1/60);
					}, 60 * 2,
				]);
				
				hpMod([
					function(){
						hp = 270;
						
						b_2_reload = 15;
						b_2_amount = 3;
					},
				]);
			}
		];
	},
};


//stageIndex = 10

stage = [
	function(){
		time(60)
	},
	function(){
		// 120 + 8 * 60 + 16 * 40)
		
		enemy("basic4", WIDTH / 2, 80)
		
		time(60 * 13)
		//time = -1
	},
	function(){
		enemy("basic1", WIDTH/2, 90)
		for (var i = 0; i < 8; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + i * 60)
		}
		for (var i = 0; i < 8; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + 8 * 60 + i * 40)
		}
		for (var i = 0; i < 32; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 120 + 8 * 60 + 8 * 40 + i * 30)
		}
		enemy_delay("basic2", WIDTH / 2, 120, 12 * 60)
		for (var i = 1; i < 8; i++) {
			enemy_delay("basic2", irandom_range(96, WIDTH - 96), irandom_range(100, 140), 12 * 60 + i * 120)
		}
		time(60 * (48 - 12))
	},
	function(){
		enemy("miniboss1", 0, 0);
		
		time(, true, 60 * 26)
	},
	
	function(){
		spawnUpgrade()
		time(120)
	},
	function(){
		enemy("basic3", -128, 60, [1, 4, undefined, 9])
		time(240)
	},
	function(){
		for (var i = 0; i < 4; i++)
			enemy_delay("basic3", -16 - i * 64, 60, 1, [1, 0.55, i * 2])
		for (var i = 0; i < 4; i++)
			enemy_delay("basic3", WIDTH + + 16 + i * 64, 60, 1, [-1, 0.55, i * 2])
		
		for (var i = 1; i < 11; i++) {
			var _c = i % 2 == 0 ? 1 : -1
			enemy_delay("idiot", WIDTH / 2 + ((WIDTH / 2) + (i * 128)) * _c, irandom_range(HEIGHT / 2 + 32, HEIGHT - 96), 1, [-_c, 1])
		}
		
		for (var i = 0; i < 5; i++) {
			enemy_delay("basic2", WIDTH / 2, 120, 60 * 8 + i * 60 * 5, [6, 40, 6])
		}
		
		time(60 * 24)
	},
	function(){
		// 120 + 8 * 60 + 16 * 40)
		
		enemy("basic4", WIDTH / 2, 80)
		
		time(60 * 12)
	//time = -1
	},
	function(){
		for (var i = 0; i < 4; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), i * 60)
		}
		for (var i = 0; i < 8; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 4 * 60 + i * 40)
		}
		for (var i = 0; i < 24 + 16; i++) {
			enemy_delay("basic1", irandom_range(64, WIDTH - 64), irandom_range(80, 120), 4 * 60 + 8 * 40 + i * 30)
		}
		for (var i = 2; i < 8; i++) {
			enemy_delay("basic2", irandom_range(96, WIDTH - 96), irandom_range(100, 140), i * 120)
		}
		for (var i = 2; i < 6; i++) {
			enemy_delay("basic2", irandom_range(96, WIDTH - 96), irandom_range(100, 140), 8 * 120 + i * 160)
		}
		
		for (var i = 0; i < 12; i++) {
			enemy_delay("basic5", irandom_range(8, WIDTH - 8), HEIGHT + 32, 60 * 26 + i * 60) // buff
		}
		
		time(60 * 36 + 60 * 3) // too small
	},
	function(){
		enemy("miniboss2", 0, 0);
		
		time(, true, 60 * 26)
	},
	function(){
		spawnUpgrade()
		
		time(240)
	},
	function(){
		enemy("boss", 0, 0);
		
		time(, true)
	},
	function(){
		spawnUpgrade()
		
		time(, true)
	},
	function(){
		game_music(-1)
		game_nextRoom(rm_stage3);
	}
];