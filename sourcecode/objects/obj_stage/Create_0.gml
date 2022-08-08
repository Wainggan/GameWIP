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
		
		sprite_index = spr_enemy_testBoss;
		
		x = -10;
		y = -90;
		movement_frame(function(){
			yOff = wave(-2, 2, 1);
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
				hp = 120;
				movement_start(WIDTH / 2, 50, 1/20)
				command_set([
					8,
					8,
					function(){
						bullet_preset_ring(x, y, 48, 8, irandom_range(0, 359), function(_x, _y, _dir){
							bullet_shoot_dir2(_x, _y, 12, 0.3, 3, _dir + random_range(-1, 1))
						})
						commandIndex--;
					}
				]);
			},
			function(){
				hp = 140;
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
						angle += 3 * dir * global.delta_multi;
						count += global.delta_multi;
						if count < 40
							commandIndex--;
						else {
							count = 0;
							commandIndex = 0;
							angle = irandom_range(0, 180)
							dir *= -1;
							bullet_preset_plate(x, y, 9, 8, 16, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
								bullet_shoot_dir(_x, _y, 1, _dir);
							})
						}
					}
				])
			},
			function(){
				hp = 160;
				
				movement_start(WIDTH / 2, HEIGHT / 4, 1 / 20);
				command_set([
					7, 
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
						bullet_preset_plate(x, y, 5, 0, 11, 12, angle, function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 5, _dir);
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
						bullet_preset_ring(choose(-32, WIDTH + 32), irandom_range(60, HEIGHT / 2), 9, 0, random_range(0, 360), function(_x, _y, _dir){
							bullet_shoot_dir(_x, _y, 2, _dir).sprite_index = spr_bullet_small;
						});
						commandIndex--;
					}
				])
			},
		]
		
		movement_start(WIDTH / 2, 100, 1/80, , function(){
			textbox_scene_create([
				["[wave:]Clearly[/],{pause:18} you are not a gamer."],
				["What", func_nextAttack],
			]);
		});
	},
}
enemy = function(_type, _x = 0, _y = 0, _args = []){
	show_debug_message(_type)
	show_debug_message(_args)
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

/*
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

