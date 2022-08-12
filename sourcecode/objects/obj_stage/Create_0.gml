enemies = {
	"stage1-basic": function(_spd = 6, _intensity = 0){
		hp = 4;
		maxhp = 4;
		
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
					bullet_shoot_dir2(_x, _y, 4, 1, 22, _dir);
				})
				commandIndex--;
			},
		])
	},
	"stage1-miniboss1": function(){
		hp = 120;
		maxhp = 120;
		scoreGive = 10000
		
		startY = y;
		y = -50;
		
		command_set([
			function(){
				movement_start(x, startY, 1 / 20);
				command_timer(60 * 1, function(){
					command_add([
						32,
						function(){
							var pos = choose(30, WIDTH - 30)
							with bullet_shoot_vel(pos, obj_player.y, sign(obj_player.x - pos) * 2, 0) {
								sprite_index = spr_bullet_inverted;
								y_accel = 0.02;
								
								x_accel = 0.01;
								x_target = 1;
							}
							commandIndex--;
						}
					])
				})
				command_timer(60 * 6, function(){
					command_reset()
				})
				command_timer(60 * 7, function(){
					movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
				})
			},
			10,
			12,
			function(){
				var dir = random_range(0, 359);
				for (var i = 0; i < 60; i++) {
					bullet_shoot_dir2(x, y, 8, 0.2 + random_range(-0.02, 0.025), 3.5, dir + random_range(-1, 1));
					dir += 360 / 60;
				}
				commandIndex--;
			}
		]);
	},
	"stage1-basic2": function(){
		hp = 100;
		maxhp = 100;
		
		scoreGive = 4000;
		
		startY = y;
		y = -50;
		
		movement_start(x, startY, 1/20,,function(){
			command_timer(60*5, function(){
				command_reset()
				movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
			})
			command_set([
				32,
				function(){
					bullet_preset_plate(x, y, 9, 0, 270, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
						for (var i = 1; i <= 3; i++) 
							with bullet_shoot_dir(_x, _y, i * 2, _dir) {
								sprite_index = spr_bullet_large
							}
						
					});
					commandIndex--;
				}
			])
		})
	},
	"stage1-basic3": function(_spd = 2){
		hp = 4;
		maxhp = 4;
		spd = _spd;
		
		polarity = sign(x - WIDTH / 2);
		
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * -polarity, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * -polarity)) * spd, "linear",
			function(){
				instance_destroy()
			}
		);
		
		command_set([
			24,
			function(){
				for (var i = 1; i <= 4; i++) 
					with bullet_shoot_dir(x, y, i * 1, point_direction(x, y, obj_player.x, obj_player.y)) {
						sprite_index = spr_bullet_point
					}
				commandIndex --;
			},
		])
	},
	"stage1-basic4": function(_wait = 32, _rate = 4, _density = 5, _spd = 1, _retries = 2, _spin = 12, _hp = 12){
		hp = _hp;
		maxhp = _hp;
		
		wait = _wait;
		rate = _rate;
		density = _density;
		spd = _spd;
		spin = _spin;
		retries = _retries;
		
		polarity = sign(x - WIDTH / 2);
		
		startX = x;
		startY = y;
		x = irandom_range(32, WIDTH - 32);
		y = -64;
		
		count = 0;
		func_move = function(){
			command_reset();
			if count == 0 {
				movement_start(startX, startY, 1 / 40, ,
					function(){
						func_shot();
						command_timer(wait, function(){
							func_move();
						})
					}
				);
				count++
			} else if count < retries {
				movement_start(irandom_range(32, WIDTH - 32), irandom_range(30, 100), 1 / 40, ,
					function(){
						func_shot();
						command_timer(wait, function(){
							func_move();
						})
					}
				);
				count++;
			} else {
				movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * choose(-1, 1), irandom_range(10, HEIGHT / 2), 1 / 80, ,
					function(){
						instance_destroy();
					}
				);
			}
		}
		func_shot = function(){
			command_set([
				rate,
				function(){
					bullet_preset_ring(x, y, density, 16, wave(0, 360 * spin, 10), function(_x, _y, _dir){
						bullet_shoot_dir(_x, _y, spd, _dir);
					})
					commandIndex --;
				},
			])
		}
		func_move();
	},
	"stage1-boss": function(){
		invinsible = true;
		important = true;
		canDie = false;
		
		sprite_index = spr_car;
		
		x = -10;
		y = -90;
		movement_frame(function(){
			xOff = irandom_range(-1, 1);
			yOff = irandom_range(-1, 1);
		})
		
		func_nextAttack = function(){
			command_reset();
			movement_stop();
			if currentAttack < array_length(attacks) {
				hp = 1;
				invinsible = true;
				command_timer(30, function(){
					invinsible = false;
					attacks[currentAttack]();
					maxhp = hp;
					currentAttack++;	
				});
			} else {
				canDie = true;
			}
		}
		
		onDeath = func_nextAttack;
		
		deathRadius = WIDTH * 2;
		
		currentAttack = 0;
		attacks = [
			function(){
				hp = 140;
				scoreGive = 50000;
				movement_start(WIDTH / 2, 50, 1/20)
				command_set([
					8,
					8,
					function(){
						bullet_preset_ring(x, y, 54, 8, irandom_range(0, 359), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 12, 0.3, 3, _dir + random_range(-1, 1));
						})
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 220;
				scoreGive = 100000;
				angle = 0;
				count = 0;
				dir = 1;
				command_set([
					function() {
						movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
					},
					50,
					function(){
						movement_start(x + irandom_range(-48, 48), y + irandom_range(-32, 32), 1/40, "linear");
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
								glow = cb_blue;
							}
						});
						commandIndex--;
					}
				])
			},
			function(){
				hp = 320;
				scoreGive = 200000;
				movement_start(WIDTH / 2, 110, 1/40);
				
				angle = 0;
				angle2 = 0;
				angle2_vel = 0;
				
				command_set([
					50,
					17,
					function(){
						bullet_preset_ring(x, y, 16, 0, angle + angle2, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 2, _dir).sprite_index = spr_bullet_small;
						});
						bullet_preset_ring(x, y, 16, 0, -angle + angle2, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 2, _dir).sprite_index = spr_bullet_small;
						});
						angle += global.delta_multi * 3;
						angle2 += global.delta_multi * angle2_vel;
						angle2_vel = min(angle2_vel + 0.01 * global.delta_multi, 1)
						commandIndex--;
					}
				]);
				count = 0;
				command_timer(120, function(){
					command_add([
						70,
						function(){
							count = irandom_range(0, 1);
							bullet_preset_plate(x, y, 25, 6, 32, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								var inst = bullet_shoot_dir2(_x, _y, 11, 0.14, 0.5, _dir);
								inst.sprite_index = spr_bullet_point;
								if count++ % 2 == 1 inst.step = method(inst, function(){
									if y > HEIGHT {
										dir += 180;
										y_accel = 0.004;
										spd += random_range(-0.4, 0.4)
										step = undefined;
									}
								});
							})
							commandIndex--;
						}
					])
				})
			},
			function(){
				hp = 100;
				dir = -1;
				movement_start(WIDTH / 2, 110, 1/40);
				command_set([
					50,
					40,
					function(){
						bullet_group_start(x, y);
							bullet_preset_poly(x, y, 4, 16, 100, function(_x, _y, _dir) {
								bullet_shoot(_x, _y);
							})
						with bullet_group_end() {
							dir = other.dir;
							step = function(){
								rotate(dir * 0.5 * global.delta_multi)
								scale(1 + 0.02 * global.delta_multi)
							}
						}
						dir = -dir;
						commandIndex--;
					}
				])
			},
		]
		
		movement_start(WIDTH / 2, 100, 1/80, , function(){
			textbox_scene_create([
				["Hi! :D {pause:32}  \nDo you know the way to the convinience store by any chance?", [spr_playericon, 0, -1]],
				["[shake:]VROOM VROOOM VROOM", [spr_car, 0, 1]],
				["[shake:]VROOOOM VROOOM"],
				["[shake:]VROOOOOOOOOOOOOOOOOOOOOM \nVRUM VRUM VRUM VRUM"],
				["what", [spr_playericon, 0, -1], func_nextAttack],
			]);
		});
	},
}

//enemies = {};


enemy = function(_type, _x = 0, _y = 0, _args = []){
	var inst = instance_create_layer(_x, _y, "Instances", obj_enemy);
	var func = method_get_index(method(inst, enemies[$ _type]));
	with inst {
		script_execute_ext(func, _args);
	}
	
	return inst;
}
enemyBuffer = [];
enemy_delay = function(_type, _x, _y, _time, _args = []){
	var _arr = [];
	for (var i = 0; i < argument_count; i++)
		array_push(_arr, argument[i]);
	
	array_push(enemyBuffer, _arr);
}

time = 60 * 2;
stageIndex = -1;

stage = [
	
]


stage = [
	function(){
		enemy("stage1-boss");
		time = -1;
	}
]


stage = [
	function(){
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 60, [undefined, 6]);
			
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", -64 - i * 44, 90, [undefined, 6]);
		
		time = 180;
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 40, [3]);
			
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", -64 - i * 44, 60, [3]);
			
		time = 60;
	},
	function(){
		for (var i = 0; i < 7; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 80, [2]);
			
		for (var i = 0; i < 7; i++)
			enemy("stage1-basic", -64 - i * 44, 100, [2]);
			
		time = 220;
	},
	function(){
		enemy("stage1-miniboss1", WIDTH / 2, 60)
		
		time = 60 * 8;
	},
	function(){
		enemy("stage1-basic2", WIDTH / 2, 60)
		time = 120
	},
	function(){
		for (var i = 0; i < 2; i++)
			enemy("stage1-basic3", -64 - i * 64, 60, [1]);
		time = 90
	},
	function(){
		for (var i = 0; i < 3; i++)
			enemy("stage1-basic3", WIDTH + 64 + i * 64, 40, [1]);
		time = 180
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy_delay("stage1-basic4", irandom_range(64, WIDTH - 64), irandom_range(30, 60), i * 40, [32 + i * 4]);

		time = (8 + 5) * 40
	},
	function(){
		for (var i = 0; i < 16; i++)
			enemy_delay("stage1-basic4", irandom_range(64, WIDTH - 64), irandom_range(50, HEIGHT / 2), i * 30, [32 + i * 2, 5, undefined, undefined, 3]);
		time = (16 + 5) * 30;
	},
	function(){
		enemy("stage1-basic2", WIDTH / 2, 40);
		
		time = 60 * 6
	},
	function(){
		for (var i = 0; i < 2; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 40, [4, 15]);
			
		for (var i = 0; i < 2; i++)
			enemy("stage1-basic", -64 - i * 44, 60, [4, 15]);
		
		time = 60 * 3
	},
	function(){
		enemy("stage1-basic4", WIDTH / 2, 50, [128, 3, 11, undefined, 24, undefined, 240]);
		
		for (var j = 0; j < 4; j++) {
			for (var i = 0; i < 3; i++)
				enemy_delay("stage1-basic3", (j % 2 == 0 ? -64 - i * 64 : WIDTH + 64 + i * 64), 60, (j + 1) * 60 * 8, [3]);
		}
		
		time = 60 * 10
	},
	function(){
		time = -1
	},
	function(){game_stop()}
]

