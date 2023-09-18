// STAGE 1

event_inherited()

game_music(mus_stage1)

// ~~ ENEMIES ~~

addEnemy("basic1", function(){
	setHp(5)
	setPoints(100, 2);
	
	setSprite(spr_enemy_flower);
	
	startX = x;
	startY = y;
		
	x += irandom_range(-32, 32);
	y = -64;
	
	setInvincible(true)
	movement_start(startX, startY, 1 / 20);
		
	command_timer(60 * 1, function(){
		movement_start(clamp(x + irandom_range(-64, 64), 96, WIDTH - 96), y + irandom_range(-16, 64), 1/180)
	})
	command_timer(60 * 4, function(){
		command_reset();
		movement_start(x + irandom_range(-96, 96), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
	})
	
	b_alt = 0
		
	command_set([
		20,
		new CommandBeat(4),
		function(){
			setInvincible(false)
			b_alt++
			bullet_preset_plate(x, y, b_alt % 2 == 0 ? 2 : 1, 2, 3, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir) {
				with bullet_shoot_dir2(_x, _y, 2, 0.3, 4.5, _dir) {
					if other.b_alt % 2 == 0 sprite_index = spr_bullet_small
				}
			})
			sound.play(snd_bulletshoot)
			commandIndex--;
		}
	]);
})

addEnemy("basic2", function() {
	setHp(12)
	setPoints(200, 2);
	
	setSprite(spr_enemy_crystal);
	
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
		new CommandBeat(12),
		function(){
			bullet_preset_ring(x, y, 24, 8, wave(-360, 360, 10), function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 2, 0.2, 3, _dir) {
					sprite_index = spr_bullet_point
					glow = cb_grey;
				}
			})
			sound.play(snd_bulletshoot)
			commandIndex--;
		}
	]);
})

addEnemy("big1", function(){
	setHp(50)
	setPoints(1000, 3)
	
	setSprite(spr_enemy_cat)
	
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
		new CommandBeat(8),
		function(){
			bullet_preset_ring(x, y, 28, 8, wave(-360, 360, 10), function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 6, 0.2, 3, _dir) {
					sprite_index = spr_bullet_large
					glow = cb_blue;
				}
			})
			sound.play(snd_bulletshoot_2)
			commandIndex--;
		}
	])
})


pattern_add("stage1-miniboss-1", function() {
	
	setInvincible(false)
	
	b_density = 56;
	b_range = 64;
				
	command_set([
		new CommandBeat(8),
		function(){
			bullet_preset_ring(x, y, b_density, 8, irandom_range(0, 360), function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, 8, 0.4, 2.4, _dir).glow = cb_green
			});
			sound.play(snd_bulletshoot)
			command_repeat(6)
		},
		40,
		nextPattern
	]);
				
	command_add([
		60, 
		function(){
			movement_start(clamp(obj_player.x + irandom_range(-b_range, b_range), 96, WIDTH - 96), irandom_range(60, 80), 1/60);
			command_repeat(3)
		}
	]);
	
})

pattern_add("stage1-miniboss-2", function() {
	
	b_dir = irandom(360)
	b_dirV = choose(-1, 1)
	
	movement_start(clamp(obj_player.x + irandom_range(-96, 96), 96, WIDTH - 96), irandom_range(60, 80), 1/20);
	
	command_set([
		20,
		new CommandBeat(1),
		function(){
			b_dir += 5 * b_dirV
			
			bullet_preset_ring(x, y, 20, 8, b_dir, function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, random_range(7, 9), 0.4, random_range(2.3, 2.6), _dir).glow = c_grey
			});
			sound.play(snd_bulletshoot)
			command_repeat(10)
		},
		40,
		nextPattern
	])
	
	
})

pattern_add("stage1-miniboss-3", function() {
				
	b_density = 7;
				
	command_set([
		new CommandBeat(8),
		function(){
			sound.play(snd_bulletshoot_2)
			bullet_preset_plate(x, y, 5, 4, 135, 0, 90 + irandom_range(-8, 8), function(_x, _y, _dir){
				with bullet_shoot_vel(_x, _y, lengthdir_x(3, _dir), lengthdir_y(3, _dir)) {
					y_target = 5;
					y_accel = 0.1;
								
					glow = cb_green;
					sprite_index = spr_bullet_large;
					
					
					command_timer(irandom_range(60, 80), function(){
						sound.play(snd_bulletshoot)
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
			command_repeat(6)
		},
		80,
		nextPattern
	])
	
	command_add([
		new CommandBeat(8),
		40,
		function(){
			movement_start(clamp(obj_player.x + irandom_range(-32, 32), 96, WIDTH - 96), irandom_range(50, 100), 1/20);
			commandIndex--
		}
	])
	
})

addEnemy("miniboss", function() {
	setBoss()
	
	setSprite(spr_enemy_testBoss)
	setInvincible(true)
	
	x = WIDTH + 74;
	y = -60;
	
	movement_start(WIDTH / 2, 120, 1/50, , startPhase);
	
	setPatterns([
		new Pattern("stage1-miniboss-1"),
		new Pattern("stage1-miniboss-2"),
		new Pattern("stage1-miniboss-3"),
	]);
		
	setPhases([
		new AttackPhase(beat_to_time(8 * 4), [0, 1]),
		new AttackPhase(beat_to_time(8 * 4), [2, 0]),
	]);
})


pattern_add("stage1-boss-1", function(){
	b_density = 24
	b_speed = 2.5
	b_reload = 6;
	
	if b_difficulty >= 1 {
		b_density = 18
	}
	if b_difficulty >= 2 {
		b_density = 20
		b_reload = 4;
		b_speed = 4
	}
	
	movement_start(clamp(x, WIDTH / 2 - 48, WIDTH / 2 + 48), 90, 1/20)
	command_set([
		20,
		new CommandBeat(b_reload),
		function(){
			sound.play(snd_bulletshoot_2)
			bullet_preset_plate(x, y, 25, b_density, 4, -16, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir) {
				with bullet_shoot_dir2(_x, _y, 8, 0.2, b_speed, _dir) {
					glow = cb_blue;
				}
			})
			command_repeat(12)
		},
		nextPattern
	]);
	
	command_add([
		60, 
		function(){
			movement_start(clamp(obj_player.x + irandom_range(-32, 32), 128, WIDTH - 128), irandom_range(40, 60), 1/60);
			commandIndex--;
		}
	]);
})

pattern_add("stage1-boss-2", function(){
	b_amount = 8
	b_speed = 2.5
	b_wait = 0
	
	if b_difficulty >= 2 {
		b_amount = 10
		b_speed = 3;
	}
	if b_difficulty >= 3 {
		b_amount = 16
		b_wait = 40
	}
	
	command_set([
		20,
		b_wait,
		new CommandBeat(4),
		function(){
			var _dir = irandom_range(0, 360);
			sound.play(snd_bulletshoot)
			bullet_preset_ring(x, y, 2, 0, _dir, function(_x, _y, _dir){ // long
				bullet_preset_plate(_x, _y, 4, 3, 4, 0, _dir, function(_x, _y, _dir){
					bullet_shoot_dir(_x, _y, b_speed, _dir).glow = cb_yellow;
				})
			})
			bullet_preset_ring(x, y, b_amount, 0, _dir + 360 / b_amount / 2, function(_x, _y, _dir){ // short
				bullet_preset_plate(_x, _y, 2, 3, 4, 0, _dir, function(_x, _y, _dir){
					bullet_shoot_dir(_x, _y, b_speed, _dir).glow = cb_yellow;
				})
			})
			command_repeat(20)
		},
		nextPattern
	]);
})

pattern_add("stage1-boss-3", function(){ // Speed
	b_amount = 12;
	b_speed = 4;
	b_dir = 0;
	b_turn = 1;
	b_reload = 12;
	
	if b_difficulty >= 2 {
		b_reload = 10;
		b_speed = 4.5
		b_amount = 15;
	}
	if b_difficulty >= 3 {
		b_reload = 6;
		b_speed = 5
		b_amount = 20;
	}
	
	command_set([
		new CommandBeat(4),
		function(){
			var _d = wave(-5, 5, 15);
			b_turn = _d;
			sound.play(snd_bulletshoot)
			bullet_preset_ring(x, y, b_amount, 0, b_dir, function(_x, _y, _dir){
				with bullet_shoot_dir2(x, y, 10, 0.5, b_speed, _dir, 4) {
					glow = cb_yellow;
					dir_target = dir + 90 * other.b_turn / 5;
					dir_accel = 3;
					sprite_index = spr_bullet_arrow
				}
			})
			b_dir += _d;
						
			command_repeat(10)
		},
		nextPattern
	]);
	
	command_add([
		120,
		function(){
			movement_start(clamp(obj_player.x + irandom_range(-8, 8), 96, WIDTH - 96), irandom_range(80, 90), 1/60);
			commandIndex--;
		}
	])
})

pattern_add("stage1-boss-4", function(){

	b_golden = 0

	movement_start(WIDTH / 2 + irandom_range(-16, 16), HEIGHT / 4 + irandom_range(-16, 16), 1/40)
	command_set([
		50,
		1,
		function(){
			sound.play(snd_bulletshoot)
			b_golden = bullet_preset_golden(x, y, 9, 4, b_golden, function(_x, _y, _dir){
				with bullet_shoot_dir3(_x, _y, 0.5, 0.01, 1, 0.1, 4, _dir) {
					glow = cb_rust
				}
			})
			command_repeat(40)
		},
		10,
		nextPattern
	]);

})

pattern_add("stage1-boss-5", function(){

	b_dir = -1
	b_density = 44;
	b_angleDensity = 12
	b_rotateSpeed = 0.1
	b_speed = 1.2
				
	movement_start(WIDTH / 2, 90, 1/30);
				
	command_set([
		60,
		function(){
			sound.play(snd_bulletshoot_2)
			bullet_group_start(x, y)
			bullet_preset_ring(x, y, b_angleDensity, 32, point_direction(x, y, obj_player.x, obj_player.y) + 360 / b_angleDensity / 2, function(_x, _y, _dir){
				bullet_preset_line2(_x, _y, _dir, b_density, 10, function(_x, _y) {
					with bullet_shoot(_x, _y) {
						deathBorder = other.b_density * 14;
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
		120,
		function(){
			command_repeat(2, -3)
		},
		60,
		nextPattern
	]);

})

addEnemy("boss", function(){
	setBoss()
	
	setSprite(spr_boss_raoul, true)
	setInvincible(true)
	
	x = -120;
	y = -60;
		
	movement_start(WIDTH / 2, 90, 1/50, , function(){
		textbox_scene_create([
			["a", [spr_test_viiPortrait, 0, -1]],
			["d", [spr_car, 0, 1]],
			["go away", undefined, function(){
				game_music(mus_boss1)
				setInvincible(false)
				startPhase();
			}]
		])
	});
	
	setPatterns([
		new Pattern("stage1-boss-1"),
		new Pattern("stage1-boss-2"),
		new Pattern("stage1-boss-3"),
		new Pattern("stage1-boss-4"),
		new Pattern("stage1-boss-5"),
	]);
	
	b_difficulty = 0
		
	setPhases([
		new AttackPhase(beat_to_time(10 * 4), [0, 1], function(){
			game_background(, 3)
		}),
		new AttackPhase(beat_to_time(16 * 4), [3, 0, 2], function(){
			game_background([3, 4], 5, 0.01)
			b_difficulty = 1
		}),
		new AttackPhase(beat_to_time(16 * 4), [4, 1], function(){
			game_background([5, 6])
			b_difficulty = 2
		}),
		new AttackPhase(beat_to_time(16 * 4), [1, 4, 2], function(){
			game_background([7, 8], 6, 0.01)
			render.look_set_overlay(0.04, c_red)
			b_difficulty = 3
		}),
	]);
})


// ~~ STAGE ~~

//stageIndex = 7;
 addSection(function(){
	game_background(, 1);
	
	enemy_delay("boss", 0, 0, 60)
})
 addPause(, true);

addPause(beat_to_frame(1));

addSection(function(){
	game_background( , 1);
	for (var i = 0; i < 16; i++)
		enemy_delay("basic1", WIDTH / 2 + irandom_range(-196, 196), irandom_range(32, 96), i * beat_to_frame(2));
});
addPause(beat_to_frame(8 * 4 - 1))

addSection(function(){
	game_background( , 4);
	
	enemy_delay("big1", WIDTH / 2, 90, 60);
})
addPause(beat_to_frame(4 * 4))

addSection(function(){
	for (var i = 0; i < 24; i++)
		enemy_delay("basic1", WIDTH / 2 + irandom_range(-128, 128), irandom_range(80, 128), i * beat_to_frame(2));
	
	enemy_delay("big1", WIDTH / 2, 90, beat_to_frame(2 * 4));
	enemy_delay("big1", WIDTH / 2, 90, beat_to_frame(6 * 4));
})
addPause(beat_to_frame(12 * 4));

addSection(function(){
	game_background([1, 2] , 1);
	
	for (var i = 0; i < 8; i += 2) {
		enemy_delay("basic2", WIDTH / 2 + -190, -32, i * (60 * 1));
		enemy_delay("basic2", WIDTH / 2 +  190, -32, (i + 1) * (60 * 1));
	}
})
addPause(beat_to_frame(8 * 4));

addSection(function(){
	game_background([3, 4], 4);
		
	enemy_delay("miniboss", 0, 0, 10);
})
addPause(, true);

addSection(function(){
	game_background([5, 6], 2)
	spawnUpgrade()
})
addPause(beat_to_frame(4))

addSection(function(){
	for (var i = 0; i < 25; i++)
		enemy_delay("basic1", WIDTH / 2 + irandom_range(-96, 96), irandom_range(80, 128), i * beat_to_frame(2));
	
	for (var i = 0; i < 6; i += 2) {
		enemy_delay("basic2", WIDTH / 2 + -190, -32, 60 * 4 + i * (60 * 2.5));
		enemy_delay("basic2", WIDTH / 2 +  190, -32, 60 * 4 + (i + 1) * (60 * 2.5));
	}
	
	enemy_delay("big1", WIDTH / 2, 90, beat_to_frame(8 * 4));
	enemy_delay("big1", WIDTH / 2, 90, beat_to_frame(12 * 4));
})
addPause(beat_to_frame(16 * 4) - 4);

addPause(beat_to_frame(4));



addSection(function(){
	game_background(, 1);
	
	enemy_delay("boss", 0, 0, 60)
})
addPause(, true);

addSection(function(){
	render.look_set_overlay(0.03, c_teal)
	spawnUpgrade()
})
addPause(120, true, 60)

addSection(function(){
	print("table")
	game_music(-1)
	game_nextRoom(rm_stage2);
})

