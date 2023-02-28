event_inherited();

enemies = {
	"basic": function(_bspd = 2){
		hp = 4;
		
		sprite_index = spr_enemy_crystal
		
		startX = x;
		startY = y;
		
		b_speed = _bspd;
		
		x += -directionToMove * WIDTH;
		y = irandom_range(-2, -64);
		
		movement_start(startX, startY, 1/120);
		command_timer(60 * 10, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + choose(-1, 1) * HEIGHT, 1/360, "linear", function(){instance_destroy()})
			command_get(0)[1] = 24;
		})
		
		command_set([
			100, 
			10,
			function(){
				bullet_preset_ring(x, y, 10, 0, random(360), function(_x, _y, _dir, _i){
					with bullet_shoot_dir2(_x, _y, b_speed * 5, 0.5, b_speed, _dir) {
						glow = _i % 2 == 0 ? cb_teal : cb_pink;
						sprite_index = spr_bullet_arrow
					}
				})
				commandIndex--;
			}
		]);
	},
	"basic2": function(){
		hp = 45;
		
		sprite_index = spr_enemy_fire
		
		startX = x;
		startY = y;
		
		x += -directionToMove * WIDTH;
		
		b_offset = random(10)
		
		movement_start(startX, startY, 1/120);
		command_set([
			120,
			function(){
				movement_start(x, y - HEIGHT / 2, 1/(60 * 8), "linear")
			},
			60 * 8 + 60 * 2,
			function(){
				movement_start(x + directionToMove * WIDTH, y - 16, 1/120, , function(){instance_destroy()})
			}
		]);
		
		command_add([
			120,
			2,
			function(){
				with bullet_shoot_dir2(x, y, 2, 0.02, 1, wave(-360, 360, 6, b_offset)) {
					sprite_index = spr_bullet_small
				}
				commandIndex--
			}
		])
	},
	"big1": function(){
		hp = 200;
		ignoreSlap = true;
		
		sprite_index = spr_enemy_cat
		
		startX = x;
		startY = y;
		
		y = -64
		
		movement_start(startX, startY, 1/60);
		command_timer(60 * 28, function(){
			command_reset()
			movement_start(x, HEIGHT + 32, 1/360, , function() { instance_destroy() })
		})
		
		
		command_set([
			70,
			6,
			function(){
				var _dir = point_direction(x, y, obj_player.x, obj_player.y)
				with bullet_shoot_dir2(x, y, 5, 0.1, 4, _dir) {
					sprite_index = spr_bullet_point
					b_dir = _dir;
					b_off = global.time;
					
					step = function(){
						dir = b_dir + wave(-110, 110, 1, 0.25, (global.time - b_off)/60)
					}
				}
				with bullet_shoot_dir2(x, y, 5, 0.1, 4, _dir) {
					sprite_index = spr_bullet_point
					b_dir = _dir;
					b_off = global.time;
					
					step = function(){
						dir = b_dir + wave(-110, 110, 1, 0.75, (global.time - b_off)/60)
					}
				}
				commandIndex--
			}
		]);
		
		command_add([
			120,
			60,
			function(){
				var _dir = point_direction(x, y, obj_player.x, obj_player.y) + 180;
				bullet_preset_plate(x, y, 3, 0, 45, 0, _dir, function(_x, _y, _dir){
					for (var i = 0; i < 8; i++)
						bullet_shoot_dir(_x, _y, 0.5 + i * 0.5, _dir)
				})
				
				commandIndex--
			}
		])
		
	},
	"basic3": function(){
		hp = 10;
		
		//sprite_index = spr_enemy_crystal
		
		startX = x;
		startY = y;
		
		x += -directionToMove * WIDTH;
		y = irandom_range(-2, -64);
		
		movement_start(startX, startY, 1/120);
		command_timer(60 * 10, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + choose(-1, 1) * HEIGHT, 1/360, "linear", function(){instance_destroy()})
			command_get(0)[1] = 24;
		})
		
		command_set([
			100, 
			30,
			function(){
				if point_distance(x, y, obj_player.x, obj_player.y) > 100
				bullet_preset_ring(x, y, 6, 0, random(360), function(_x, _y, _dir, _i){
					with bullet_shoot_dir3(_x, _y, 0, 0.2, 2, 0.5, 1, _dir) {
						glow = _i % 2 == 0 ? cb_teal : cb_pink;
						sprite_index = spr_bullet_arrow
					}
				})
				commandIndex--;
			}
		]);
	},
	"basic4": function(){
		hp = 60;
		
		sprite_index = spr_enemy_crystal
		
		startX = x;
		startY = y;
		
		b_speed = 2;
		
		x += -directionToMove * WIDTH;
		y = irandom_range(-2, -64);
		
		movement_start(startX, startY, 1/120);
		command_timer(60 * 9, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + choose(-1, 1) * HEIGHT, 1/360, "linear", function(){instance_destroy()})
			command_get(0)[1] = 24;
		})
		
		command_set([
			100, 
			24,
			function(){
				bullet_preset_ring(x, y, 12, 0, random(360), function(_x, _y, _dir, _i){
					with bullet_shoot_dir2(_x, _y, b_speed * 3, 0.5, b_speed, _dir) {
						glow = _i % 2 == 0 ? cb_teal : cb_pink;
						sprite_index = spr_bullet_large;
					}
				})
				commandIndex--;
			}
		]);
		command_add([
			130, 
			60,
			function(){
				with bullet_laser(x, y, point_direction(x, y, obj_player.x, obj_player.y), 10, 60) {
					glow = cb_yellow;
				};
				commandIndex--;
			}
		])
	},
	"big2": function(){
		hp = 100;
		
		sprite_index = spr_enemy_cat;
		
		startX = x;
		startY = y;
		
		y = -64;
		
		b_amount = 0;
		
		movement_start(startX, startY, 1/60);
		command_timer(60 * 7, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + HEIGHT, 1/360, , function(){instance_destroy()})
			command_reset()
			//command_get(0)[1] = 24;
		})
		
		command_set([
			60, 
			20,
			function(){
				bullet_preset_ring(x, y, 64, 0, random(360), function(_x, _y, _dir, _i){
					with bullet_shoot_dir3(_x, _y, 12, 1, 2, 0.5, 4, _dir) {
						glow = cb_grey;
						sprite_index = spr_bullet_point;
					}
				})
				b_amount = 0;
			},
			60,
			16, 
			function(){
				bullet_preset_ring(x, y, 7, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir, _i){
					with bullet_laser(_x, _y, _dir, 10, 30) {
						glow = cb_yellow;
					}
				})
				commandIndex--;
				if b_amount++ > 4 commandIndex = 1;
			}
		]);
		
	},
	"miniboss": function(){
		hp = 69;
		deathRadius = WIDTH * 2;
		important = true;
		invinsible = true;
		ignoreSlap = true;
		canDie = false;
		
		sprite_index = spr_car
		
		x = WIDTH + 74;
		y = -60;
		
		movement_start(WIDTH / 2, 128, 1/120, , function(){
			func_nextAttack()
		});
		
		attacks = [
			function(){
				hp = 200;
				
				scoreGive = 6000;
				pointGive = 6;
				
				b_dir = 0;
				b_amount = 3;
				b_speed = 3;
				
				command_set([
					2,
					function(){
						b_dir = bullet_preset_golden(x, y, 4, b_amount, b_dir, function(_x, _y, _dir){
							bullet_group_start(_x, _y);
							bullet_preset_ring(_x, _y, 3, 6, _dir, function(_x, _y, _dir){
								with bullet_shoot(_x, _y) {
									sprite_index = spr_bullet_small;
									glow = cb_green
								}
							})
							with bullet_group_end() {
								dir = _dir;
								spd = 8;
								spd_target = other.b_speed
								spd_accel = 0.2
								step = function(){
									rotate(2 * global.delta_multi);
								}
							}
						})
						commandIndex--;
					}
				]);
				
				command_add([
					90,
					function(){
						movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 96 + irandom_range(-8, 64), 1/60);
						commandIndex--;
					}
				]);
				
				command_add([
					20,
					function(){
						with bullet_shoot_vel2(irandom_range(0, WIDTH), -64, 0, 0, 0, 0.02, 0, 4) {
							sprite_index = spr_bullet_huge;
							deathBorder = 96;
						}
						commandIndex--;
					}
				]);
				
				hpMod([
					function(){
						hp = 150;
						
						b_amount = 4;
						b_speed = 3.5
						command_get(1)[0] = 2;
						command_get(2)[0] = 18;
						
					},
					function(){
						hp = 270;
						
						b_speed = 4
						command_get(2)[0] = 14;
					},
				]);
				
			},
		];
	},
}

stageIndex = 6

audio_play_sound(mus_stage3, 10, false)

stage = [
	function(){
		time(60)
	},
	function(){
		for (var i = 0; i < 10; i++) {
			enemy_delay("basic", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), irandom_range(50, 200), i * 60);
		}
		time(60 * 10 + 60 * 3 + 60 * 3)
	},
	function(){
		for (var i = 0; i < 4; i++) {
			enemy_delay("basic2", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-20, 20), HEIGHT - 196, i * 60);
		}
		time(60 * 4 + 60 * 6)
	},
	function(){
		for (var i = 0; i < 12; i++) {
			enemy_delay("basic", irandom_range(WIDTH/2 - 32, WIDTH/2 + 32), irandom_range(50, 200), i * 120);
		}
		for (var i = 0; i < 6; i++) {
			enemy_delay("basic2", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-20, 20), HEIGHT - 32, i * 160);
		}
		time(28*60)//160 * 6 + 60 * 8)
	},
	
	function(){
		enemy("big1", WIDTH/2, HEIGHT / 2);
		for (var i = 0; i < 14; i++) {
			enemy_delay("basic3", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), HEIGHT/2 + choose(-1, 1) * 140 + irandom_range(-80, 80), i * 120);
		}
		time(120 * 14)
	},
	function(){
		for (var i = 0; i < 2; i++) {
			enemy_delay("basic4", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-10, 10), irandom_range(50, 80), 0);
		}
		time(60 * 14);
	},
	function(){
		enemy("big2", WIDTH/2, 100);
		enemy_delay("big2", WIDTH/2 - 128, 60, 60 * 4);
		enemy_delay("big2", WIDTH/2 + 128, 60, 60 * 4);
		
		for (var i = 0; i < 4; i++) {
			enemy_delay("basic3", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), HEIGHT/2 + choose(-1, 1) * 140 + irandom_range(-80, 80), i * 120);
		}
		
		time(60 * 14);
	},
	function(){
		enemy("miniboss", WIDTH/2, 64);
	}
]