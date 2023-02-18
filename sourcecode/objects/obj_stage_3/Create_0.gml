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
		hp = 300;
		ignoreSlap = true;
		
		sprite_index = spr_enemy_cat
		
		startX = x;
		startY = y;
		
		y = -64
		
		movement_start(startX, startY, 1/60);
		
		
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
						dir = b_dir + wave(-124, 124, 1, 0.25, (global.time - b_off)/60)
					}
				}
				with bullet_shoot_dir2(x, y, 5, 0.1, 4, _dir) {
					sprite_index = spr_bullet_point
					b_dir = _dir;
					b_off = global.time;
					
					step = function(){
						dir = b_dir + wave(-124, 124, 1, 0.75, (global.time - b_off)/60)
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
					for (var i = 0; i < 12; i++)
						bullet_shoot_dir(_x, _y, 0.5 + i * 0.25, _dir)
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
		hp = 30;
		
		sprite_index = spr_enemy_crystal
		
		startX = x;
		startY = y;
		
		b_speed = 2;
		
		x += -directionToMove * WIDTH;
		y = irandom_range(-2, -64);
		
		movement_start(startX, startY, 1/120);
		command_timer(60 * 10, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + choose(-1, 1) * HEIGHT, 1/360, "linear", function(){instance_destroy()})
			command_get(0)[1] = 24;
		})
		
		command_set([
			100, 
			18,
			function(){
				bullet_preset_ring(x, y, 12, 0, random(360), function(_x, _y, _dir, _i){
					with bullet_shoot_dir2(_x, _y, b_speed * 5, 0.5, b_speed, _dir) {
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
		hp = 40;
		
		sprite_index = spr_enemy_cat;
		
		startX = x;
		startY = y;
		
		y = -64;
		
		b_amount = 0;
		
		movement_start(startX, startY, 1/60);
		command_timer(60 * 10, function(){
			movement_start(x + choose(-1, 1) * WIDTH, y + choose(-1, 1) * HEIGHT, 1/360, "linear", function(){instance_destroy()})
			command_get(0)[1] = 24;
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
		
	}
}

//stageIndex = 5

audio_play_sound(mus_stage3test, 10, false)

stage = [
	function(){
		time(120)
	},
	function(){
		for (var i = 0; i < 14; i++) {
			enemy_delay("basic", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), irandom_range(50, 200), i * 60);
		}
		time(60 * 14 + 60 * 2)
	},
	function(){
		for (var i = 0; i < 4; i++) {
			enemy_delay("basic2", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-20, 20), HEIGHT - 196, i * 60);
		}
		time(60 * 4 + 60 * 6)
	},
	function(){
		for (var i = 0; i < 6; i++) {
			enemy_delay("basic2", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-20, 20), HEIGHT - 32, i * 160);
		}
		time(160 * 6 + 60 * 8)
	},
	function(){
		for (var i = 0; i < 2; i++) {
			enemy_delay("basic4", WIDTH/2 + (i % 2 == 0 ? -1 : 1) * 200 + irandom_range(-10, 10), irandom_range(50, 80), 0);
		}
		time(60 * 4 + 60 * 4);
	},
	function(){
		enemy("big1", WIDTH/2, HEIGHT / 2);
		for (var i = 0; i < 14; i++) {
			enemy_delay("basic3", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), HEIGHT/2 + choose(-1, 1) * 140 + irandom_range(-80, 80), i * 120);
		}
		time(120 * 14)
	},
	function(){
		enemy("big2", WIDTH/2, 60);
		
		for (var i = 0; i < 14; i++) {
			enemy_delay("basic3", WIDTH/2 + choose(-1, 1) * 150 + irandom_range(-80, 80), HEIGHT/2 + choose(-1, 1) * 140 + irandom_range(-80, 80), i * 120);
		}
	}
]