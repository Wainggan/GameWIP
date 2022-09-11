event_inherited();

enemies = {
	"basic": function(_spd = 6, _intensity = 0){
		hp = 3;
		scoreGive = 1000;
		sprite_index = spr_enemy_flower;
		
		spd = _spd;
		intensity = _intensity // doesnt work
		
		polarity = sign(x - WIDTH / 2);
		
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * -polarity, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * -polarity)) * spd, "linear",function(){instance_destroy()});
		
		command_set([
			14,
			function(){
				count = 0;
				bullet_shoot_dir2(x, y, 4, 0.1, 8, point_direction(x, y, obj_player.x, obj_player.y));
				commandIndex--;
			},
		])
	},
	"big1": function(){
		hp = 140;
		scoreGive = 10000
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_cat;
		
		command_set([
			function(){
				movement_start(x, startY, 1 / 20);
				command_timer(60 * 10, function(){
					command_reset()
				})
				command_timer(60 * 11, function(){
					movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
				})
			},
			80,
			function(){
				bullet_preset_ring(x, y, 80, 8, irandom_range(0, 360), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 10, 0.2, 0.5, _dir) {
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
				48,
				function(){
					bullet_preset_plate(x, y, 11, 0, 270, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
						for (var i = 1; i <= 2; i++) 
							with bullet_shoot_dir(_x, _y, i * 1, _dir) {
								glow = cb_green;
							}
						
					});
					commandIndex--;
				}
			])
		})
	},
	"big1_2": function(_density = 56, _reload = 86){
		hp = 120;
		maxhp = 120;
		scoreGive = 10000
		
		density = _density;
		reload = _reload;
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_cat;
		
		movement_start(x, startY, 1 / 40);
		command_timer(60 * 10, function(){
			idk = true;
		})
		command_timer(60 * 12, function(){
			movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
		})
		
		idk = false;
		
		command_set([
			50,
			reload,
			function(){
				bullet_preset_ring(x, y, density, 8, irandom_range(0, 360), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 8, 0.2, 0.8, _dir) {
						glow = cb_blue;
						sprite_index = spr_bullet_arrow;
					}
				})
				if !idk commandIndex--;
			},
		]);
	},
	"basic3" : function(){
		hp = 6;
		scoreGive = 1000;
		
		startY = y;
		y = -50;
		
		sprite_index = spr_enemy_flower
		
		movement_start(x, startY, 1/20);
		
		command_timer(60 * 4, function(){
			movement_start(irandom_range(-32, WIDTH + 32), HEIGHT + 64, 1/300, "smoothStart", function(){ instance_destroy() });
		})
		
		command_set([
			0,
			40,
			function(){
				bullet_group_start(x, y);
					bullet_preset_poly(x, y, 4, 2, 2, function(_x, _y, _dir){
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
					command_timer(30, function(){
						for (var i = 0; i < array_length(bullets); i++) {
							bullets[i].dir = point_direction(bullets[i].x, bullets[i].y, obj_player.x, obj_player.y) + random_range(-1, 1);
							bullets[i].spd = 2;
						}
					})
				}
				
				commandIndex--;
			},
		])
	},
	"big2": function(){
		hp = 160;
		scoreGive = 5000;
		
		scoreGive = 10000;
		sprite_index = spr_enemy_crystal;
		
		startY = y;
		y = -64;
		
		movement_start(x, startY, 1/30);
		
		command_timer(60 * 6, function(){
			command_reset()
			movement_start(irandom_range(-32, WIDTH + 32), -64, 1/100, "smoothStart", function(){ instance_destroy() });
		})
		
		rad = 96;
		angle = 0;
		
		command_set([
			40,
			2,
			function(){
				bullet_preset_ring(x, y, 5, rad, angle, function(_x, _y, _dir){
					with bullet_shoot_dir(_x, _y, 3, _dir) {
						sprite_index = spr_bullet_point;
						glow = cb_teal;
					}
				})
				rad = max(rad - 1, 0);
				angle += 7;
				
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
		
		sprite_index = spr_enemy_testBoss
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 120, 1/50, , func_nextAttack);
		
		attacks = [
			function(){
				hp = 120;
				scoreGive = 10000;
				
				command_set([
					24,
					function(){
						bullet_preset_ring(x, y, 50, 8, irandom_range(0, 360), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 8, 0.4, 2, _dir).glow = cb_green
						});
						commandIndex--;
					}
				]);
				
				command_add([
					60, 
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-96, 96), 96, WIDTH - 96), irandom_range(60, 80), 1/60);
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 340;
				scoreGive = 50000;
				
				game_focus_set(true);
				
				command_set([
					24,
					function(){
						bullet_preset_plate(x, y, 5, 4, 135, 0, 90 + irandom_range(-8, 8), function(_x, _y, _dir){
							with bullet_shoot_vel(_x, _y, lengthdir_x(3, _dir), lengthdir_y(3, _dir)) {
								y_target = 5;
								y_accel = 0.1;
								
								glow = cb_teal;
								sprite_index = spr_bullet_large;
								
								command_timer(irandom_range(60, 80), function(){
									bullet_preset_ring(x, y, 7, 4, irandom_range(0, 360), function(_x, _y, _dir){
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
			
		]
		
	},
	"basic4": function(){
		hp = 24;
		scoreGive = 10000;
		
		sprite_index = spr_enemy_crystal;
		
		startY = y;
		y = -64;
		
		movement_start(x, startY, 1/40);
		
		count = 0;
		command_set([
			60,
			6,
			function(){
				bullet_preset_ring(x, y, 6, 8, irandom_range(0, 360), function(_x, _y, _dir){
					with bullet_shoot_dir2(_x, _y, 0, 0.1, 3, _dir) {
						glow = cb_pink;
					}
				});
				if count++ < 16
					commandIndex--;
				else
					command_timer(60, function(){
						movement_start(x + irandom_range(-16, 16), -64, 1/120, , function(){ instance_destroy() });
					})
			}
		])
	},
	"boss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		canDie = false;
		
		sprite_index = spr_enemy_testBoss
		
		x = -90;
		y = -20;
		
		bulletColors = [
			cb_red,
			cb_yellow,
			cb_green,
			cb_teal,
			cb_blue,
			cb_pink,
		]
		currentColor = 0;
		
		
		movement_start(WIDTH / 2, 128, 1/80, , function(){
			textbox_scene_create([
				["Oi!"],
				["gaming", [spr_comcat, 0, 1]],
				["gaminmg! !?", [spr_portraitTest, 0, -1]],
				["gami gngn ! !", [spr_comcat, 0, 1], func_nextAttack]
			])
		});
		
		attacks = [
			function(){
				hp = 340;
				
				scoreGive = 10000;
				
				movement_start(WIDTH / 2, 80, 1 / 20);
				
				command_set([
					20,
					28,
					function(){
						bullet_preset_ring(x, y, 56, 8, random_range(0, 100), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 11, 0.5 - max(parabola(180, 360, 0.28, _dir), 0), -2, _dir)
								.glow = bulletColors[currentColor % 6];
						})
						currentColor++
						commandIndex--;
					}
				])
			},
			function(){
				hp = 400
				scoreGive = 50000;
				
				count = 0;
				currentColor = 0;
				
				game_focus_set(true);
				
				command_set([
					60 * 2,
					function(){
						if count + 1 < 3
							movement_start(irandom_range(64, WIDTH - 64), irandom_range(40, 90), 1/20);
						else
							movement_start(clamp(obj_player.x + irandom_range(-32, 32), 96, WIDTH - 96), irandom_range(50, 110), 1 / 40);
					},
					20,
					function(){
						bullet_preset_ring(x, y, 15, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 3, _dir) {
								sprite_index = spr_bullet_arrow;
								glow = cb_grey;
								flag = 1;
							}
						})
						if count++ < 3
							commandIndex -= 2;
					},
					30,
					function(){
						screenShake_set(4);
						with obj_bullet {
							if flag != 1 continue;
							dir = point_direction(x, y, obj_player.x, obj_player.y);
							spd = 0.2;
							spd_accel = 0.1;
							spd_target = 4;
							flag = 0;
						}
						
						
						bullet_preset_ring(x, y, 60, 8, random_range(0, 100), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 11, 0.5, 1, _dir).glow = cb_grey;
						})
						
						count = 0;
					},
					61,
					function(){
						
						commandIndex = 1;
					}
				]);
				
				command_add([
					100,
					function(){
						bullet_preset_ring(WIDTH / 2, 20, 60, 8, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 11, 0.3, 0.4, _dir) {
								glow = other.bulletColors[other.currentColor % 6]
								sprite_index = spr_bullet_small;
							}
						});
						currentColor++
						commandIndex--;
					}
				])
				
			},
			function(){
				hp = 240;
				scoreGive = 10000;
				
				currentColor = 0
				
				command_set([
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-64, 64), 96, WIDTH - 96), irandom_range(40, 80), 1 / 30);
					},
					40,
					function(){
						bullet_preset_ring(x, y, 54, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 11, 0.75 - max(parabola(180, 360, 0.5, _dir), 0), -2, _dir) {
								glow = other.bulletColors[other.currentColor % 6]
							}
						})
						currentColor++
					},
					20,
					function(){
						commandIndex = 0;
					}
				]);
			},
			function(){
				hp = 340;
				scoreGive = 80000;
				
				game_focus_set(true);
				
				count = 0;
				currentColor = 0;
				
				rand = 0;
				
				command_set([
					function(){
						movement_start(WIDTH / 2, 90, 1 / 40);
					},
					60,
					function(){
						screenShake_set(4);
						with obj_bullet {
							if flag != 1 continue;
							dir = random_range(0, 360);
							spd = 0;
							spd_target = 2;
							spd_accel = 0.005;
							flag = 0;
							deathBorder = 32;
							sprite_index = spr_bullet_arrow;
						}
					},
					80,
					function(){
						rand = random_range(0, 1);
						bullet_preset_ring(x, y, 20, 0, random_range(0, 360), function(_x, _y, _dir){
							for (var i = 0; i < 10; i++)
								with bullet_shoot_dir2(_x, _y, 8 - i / 2 - rand, 0.1, 0, _dir) {
									glow = other.bulletColors[other.currentColor % 6];
									flag = 1;
								}
							currentColor++
						});
						
						currentColor++
						count = 0;
					},
					20,
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-128, 128), 96, WIDTH - 96), irandom_range(40, 80), 1 / 30);
					},
					30,
					function(){
						bullet_preset_ring(x, y, 50, 0, random_range(0, 360), function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 6, 0.1, 2, _dir) {
								glow = cb_grey;
								sprite_index = spr_bullet_small
							}
						});
						if count++ < 3
							commandIndex -= 3;
						else
							commandIndex = 0;
					}
				])
			},
			function(){
				hp = 200;
				scoreGive = 10000;
				
				currentColor = 0;
				
				command_set([
					30,
					function(){
						bullet_preset_ring(x, y, 66, 8, random_range(0, 360), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 11, 0.5 - max(parabola(180, 360, 0.2, _dir), 0), -2.5, _dir)
								.glow = bulletColors[currentColor % 6];
						})
						currentColor++
						commandIndex--;
					}
				]);
				command_add([
					40,
					function(){
						movement_start(clamp(obj_player.x + irandom_range(-96, 96), 96, WIDTH - 96), 70, 1 / 40);
						commandIndex--;
					}
				])
				
			},
			function(){
				hp = 360;
				scoreGive = 20000;
				
				game_focus_set(true);
				
				movement_start(WIDTH / 2, 80, 1 / 20);
				
				command_set([
					20,
					32,
					function(){
						bullet_preset_ring(x, y, 40, 8, random_range(-45, 45), function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 5, 0.2 - max(parabola(180, 360, 0.175, _dir), 0), -1, _dir) {
								if 0 < dir && dir < 180 sprite_index = spr_bullet_small
								glow = other.bulletColors[other.currentColor % 6];
							}
						})
						currentColor++
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 440;
				scoreGive = 100000;
				
				game_focus_set(true);
				
				currentColor = 0;
				
				movement_start(WIDTH / 2, 110, 1 / 40);
				
				command_set([
					40,
					70,
					function(){
						bullet_preset_ring(x, y, 40, 8, random_range(0, 100), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 11, 0.5 - max(parabola(180, 360, 0.2, _dir), 0), -1.5, _dir)
								.glow = bulletColors[currentColor % 6];
						})
						currentColor++
						commandIndex--;
					}
				]);
				command_add([
					32,
					function(){
						bullet_preset_plate(x, y, 2, 0, 120, 0, 270 + irandom_range(-16, 16), function(_x, _y, _dir){
							with bullet_shoot_dir(_x, _y, 3, _dir) {
								sprite_index = spr_bullet_large;
								glow = cb_grey;
								command_timer(irandom_range(50, 60), function(){
									instance_destroy();
									bullet_preset_ring(x, y, 12, 0, irandom(360), function(_x, _y, _dir){
										with bullet_shoot_dir(_x, _y, 1.5, _dir) {
											sprite_index = spr_bullet_arrow;
											glow = cb_grey;
										}
									})
								})
							}
						})
						commandIndex--
					}
				]);
				angle = 0;
				
			}
		];
	}
}

stage = [
function(){
	enemy("boss", 0, 0)
	time = -1;
},
	function(){
		time = 60
	},
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
		
		time = 60 * 8;
	},
	function(){
		enemy("basic2", WIDTH / 2, 60, [64])
		
		time = 60 * 5;
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
		
		enemy("big2", WIDTH / 2, 50);
		
		time = 60 * 8;
	},
	function(){
		enemy("miniboss1", WIDTH / 2, 0);
		
		time = -1;
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy("basic", WIDTH + 64 + i * 44, irandom_range(40, 80), [undefined, 8]);
			
		for (var i = 0; i < 8; i++)
			enemy("basic", -64 - i * 44, irandom_range(40, 80), [undefined, 8]);
		
		time = 200;
	},
	function(){
		for (var i = 0; i < 16; i++)
			enemy("basic", WIDTH + 64 + i * 44, irandom_range(40, 110), [2]);
			
		for (var i = 0; i < 16; i++)
			enemy("basic", -64 - i * 44, irandom_range(40, 110), [2]);
		
		time = 60 * 8;
	},
	function(){
		enemy("basic4", WIDTH / 2, 90);
		
		time = 240;
	},
	function(){
		enemy("basic4", 64, 40);
		enemy("basic4", WIDTH - 64, 40);
		
		time = 280;
	},
	function(){
		enemy("basic4", 64, 90);
		enemy("basic4", WIDTH - 64, 90);
		enemy("basic4", WIDTH / 2, 60);
		
		enemy_delay("big1_2", WIDTH / 2, 100, 80, [40, 96]);
		
		time = 280;
	},
	function(){
		enemy("basic4", 64, 90);
		enemy("basic4", WIDTH - 64, 90);
		enemy("basic4", WIDTH / 2, 60);
		
		
		time = 60 * 6;
	},
	function(){
		enemy("basic2", 120, 60)
		enemy("basic2", WIDTH - 120, 60)
		
		enemy_delay("basic2", 64, 90, 60 * 8)
		enemy_delay("basic2", WIDTH - 64, 90, 60 * 8)
		
		enemy_delay("big1_2", WIDTH / 2, 100, 120, [40]);
		
		for (var i = 0; i < 12; i++)
			enemy_delay("basic3", irandom_range(128, WIDTH - 128), irandom_range(80, 120), 120 + i * 80);
		
		time = 120 + 80 * 12 + 60 * 4;
	},
	function(){
		for (var i = 0; i < 3; i++)
			enemy_delay("big2", WIDTH / 2, 50 + i * 60, i * 60 * 6);
		
		time = 60 * 6 * 3 + 60 * 2;
	},
	function(){
		enemy("boss", 0, 0)
		time = -1; 
	},
	function(){
		time = 60 * 6
	},
	function(){ game_stop(); }
]
