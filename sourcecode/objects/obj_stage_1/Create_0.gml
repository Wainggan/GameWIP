// STAGE 1

event_inherited()

game_music(mus_stage1)

// ~~ ENEMIES ~~

global.counters.offsets = new Counter(0)

addEnemy("basic1", function(){
	setHp(5)
	setPoints(100, 1);
	
	setSprite(spr_enemy_flower);
	setHook_Insta();
	
	startX = x;
	startY = y;
		
	x += global.counters.offsets.rand_irange(-32, 32);
	y = -64;
	
	setInvincible(true)
	movement_start(startX, startY, 1 / 20);
		
	command_timer(60 * 1, function(){
		movement_start(lerp(x, WIDTH / 2, 0.25), y + 32, 1/180)
	})
	command_timer(60 * 4, function(){
		command_reset();
		movement_start(lerp(x, WIDTH / 2, -0.8), HEIGHT + 64, 1/360, , function(){ instance_destroy() })
	})
	
	b_alt = 0
		
	command_set([
		20,
		new CommandBeat(4),
		function(){
			setInvincible(false)
			b_alt++
			bullet_preset_plate(x, y, b_alt % 2 == 0 ? 2 : 1, 2, 3, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir) {
				with bullet_shoot_dir2(_x, _y, 2, 0.3, 4, _dir) {
					bullet_set_look(, spr_bullet_normal, cb_red)
					if other.b_alt % 2 == 0 bullet_set_look(, spr_bullet_small)
				}
			})
			sound.play(snd_bulletshoot)
			commandIndex--;
		}
	]);
})


addEnemy("basic2", function(_seed = 0) {
	setHp(12)
	setPoints(200, 2);
	
	setSprite(spr_enemy_crystal);
	setHook_Insta();
	
	setGrounded(true);
		
	step = function(){
		if y > HEIGHT - HEIGHT / 3
			command_reset()
		if y > HEIGHT + 32 {
			instance_destroy()
		}
	}
	
	b_rand = new Counter(_seed)
		
	command_set([
		30,
		new CommandBeat(16),
		function(){
			bullet_preset_ring(x, y, 28, 8, 270, function(_x, _y, _dir){
				with bullet_shoot_dir3(_x + b_rand.rand_irange(-5, 5), _y, 0, 0.01, 0.2, 0.1, 1.5, _dir) {
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
		movement_start(lerp(x, WIDTH / 2, -1), -64, 1/360, , function(){ instance_destroy() })
	})
	
	b_angle = 270

	command_set([
		30, 
		new CommandBeat(8),
		function(){
			b_angle += 360 / 26 / 2 
			bullet_preset_ring(x, y, 24, 8, b_angle, function(_x, _y, _dir){
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


global.counters.miniboss_movement = new Counter()
pattern_add("stage1-miniboss-1", function() {
	
	setInvincible(false)
	
	b_density = 56;
	b_range = 64;
	
	b_move = global.counters.miniboss_movement.next()
	
	command_set([
		new CommandBeat(8),
		function(){
			bullet_preset_ring(x, y, b_density, 8, wave(-360, 360, 4, , time_phase / 60), function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, 8, 0.4, 2.4, _dir).glow = cb_green
			});
			sound.play(snd_bulletshoot)
			command_repeat(6)
		},
		40,
		nextPattern
	]);
	
	command_add([
		50, 
		function(){
			movement_start(
				approach(x, clamp(obj_player.x + (b_move % 2 == 0 ? -1 : 1) * b_range, 96, WIDTH - 96), 48), 
				70 + sin(b_move) * 10, 1/50
			);
			b_move++
			command_repeat(3)
		}
	]);
	
})

pattern_add("stage1-miniboss-2", function() {
	
	b_dir = 270 //wave(-360, -360, 4, , time_phase / 60)
	b_dirV = wave(-1, 1, 2, , time_phase / 60) * 5
	
	b_hole = 0
	
	movement_start(
		clamp(WIDTH / 2 - (obj_player.x - WIDTH / 2), 96, WIDTH - 96), 80, 1/20
	);
	
	command_set([
		20,
		new CommandBeat(1),
		function(){
			b_dir += (360 / 18 / 2 / 2) * sign(b_dirV) + 0.08 * b_dirV
			
			bullet_preset_ring(x, y, 18, 8, b_dir, function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, 9, 0.4, 2, _dir).glow = c_grey
			});
			sound.play(snd_bulletshoot)
			command_repeat(10)
		},
		50,
		nextPattern
	])
	
	
})

pattern_add("stage1-miniboss-3", function() {
				
	b_density = 7;
	
	b_move = global.counters.miniboss_movement.next()
	b_dir = b_move % 2 == 0 ? -1 : 1
				
	command_set([
		new CommandBeat(8),
		function(){
			sound.play(snd_bulletshoot_2)
			b_dir *= -1
			bullet_preset_plate(x, y, 5, 4, 135, 0, 90 + b_dir * 10, function(_x, _y, _dir, _i){
				with bullet_shoot_vel(_x, _y, lengthdir_x(3, _dir), lengthdir_y(3, _dir)) {
					bullet_set_vel_target_y(, 0.1, 5)
					
					bullet_set_look(, spr_bullet_large, cb_green)
					
					offset = _i
					
					bullet_set_command()
					command_timer(60, function(){
						sound.play(snd_bulletshoot)
						bullet_preset_ring(x, y, 9, 4, 90, function(_x, _y, _dir){
							with bullet_shoot_dir2(_x, _y, 3, 0.1, 1, _dir) {
								bullet_set_look(, spr_bullet_arrow, cb_pink);
							}
						})
						instance_destroy()
					})
				}
			})
			command_repeat(6)
		},
		function(){
			command_edit(1, [100])
		},
		100,
		nextPattern
	])
	
	command_add([
		30,
		new CommandBeat(8),
		function(){
			b_move++
			movement_start(
				approach(x, clamp(obj_player.x + (b_move % 2 == 0 ? -1 : 1) * 48, 96, WIDTH - 96), 48), 
				75 + sin(b_move) * 25, 1/20
			);
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

global.counters.boss_1_move = new Counter()
pattern_add("stage1-boss-1", function(){
	b_density = 24
	b_speed = 2.5
	b_reload = 6;
	b_pause = 0;
	
	if currentPhase >= 1 {
		b_density = 20
	}
	if currentPhase >= 2 {
		b_reload = 5;
		b_speed = 4
		b_pause = 16
	}
	
	b_move = global.counters.boss_1_move.next()
	
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
		b_pause,
		nextPattern
	]);
	
	command_add([
		60, 
		function(){
			b_move++
			movement_start(clamp(obj_player.x + (b_move++ % 2 == 0 ? -32 : 32), 128, WIDTH - 128), 50 + sin(15 * b_move) * 10, 1/60);
			commandIndex--;
		}
	]);
})

global.counters.boss_2_dir = new Counter()
pattern_add("stage1-boss-2", function(){
	b_amount = 8
	b_speed = 2.5
	b_wait = 0
	
	if currentPhase >= 2 {
		b_amount = 9
		b_speed = 3;
	}
	if currentPhase >= 3 {
		b_speed = 2.25;
		b_wait = 40
	}
	
	b_dir = global.counters.boss_2_dir.next() * 45
	b_delta = global.counters.boss_2_dir.count % 2 == 0 ? -1 : 1
	
	command_set([
		20,
		b_wait,
		new CommandBeat(4),
		function(){
			b_dir += (360 / b_amount / 1.3333333 + 4) * b_delta;
			var _dir = b_dir
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

global.counters.boss_3_move = new Counter()
pattern_add("stage1-boss-3", function(){ // Speed
	b_amount = 12;
	b_speed = 4;
	b_dir = 0;
	b_turn = 1;
	b_reload = 12;
	b_wait = 0
	
	if currentPhase >= 2 {
		b_reload = 8;
		b_amount = 15;
		b_wait = 30
	}
	if currentPhase >= 3 {
	}
	
	b_move = global.counters.boss_3_move.next()
	
	command_set([
		b_wait,
		new CommandBeat(4),
		function(){
			var _d = wave(-5, 5, 15, , time_phase / 60);
			b_turn = _d;
			sound.play(snd_bulletshoot)
			bullet_preset_ring(x, y, b_amount, 0, b_dir, function(_x, _y, _dir){
				with bullet_shoot_dir2(x, y, 10, 0.5, b_speed, _dir, 4) {
					glow = cb_yellow;
					bullet_set_dir_target(, 3, dir + 90 * other.b_turn / 5)
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
			b_move++
			movement_start(approach(x, clamp(obj_player.x, 96, WIDTH - 96), 16), 85 + sin(15 * b_move) * 8, 1/60);
			commandIndex--;
		}
	])
})

global.counters.boss_4_pos = new Counter(49)
global.counters.boss_4_offset = new Counter()
pattern_add("stage1-boss-4", function(){

	b_golden = 0
	b_offset = global.counters.boss_4_offset.next()

	movement_start(
		WIDTH / 2 + global.counters.boss_4_pos.rand_irange(-32, 32),
		HEIGHT / 4 + global.counters.boss_4_pos.rand_irange(-32, 32),
		1/40
	);
	command_set([
		50,
		1,
		function(){
			sound.play(snd_bulletshoot)
			b_golden = bullet_preset_golden2(x, y, 9, 4, b_offset * 30, b_golden, , function(_x, _y, _dir){
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
	b_density = 44
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
				bullet_preset_line2(_x, _y, _dir, b_density, 8, function(_x, _y, _, _i) {
					if _i == 0 return;
					with bullet_shoot(_x, _y) {
						deathBorder = other.b_density * 14;
						glow = cb_blue
						bullet_set_step(, function(){
							if y > HEIGHT + 64 instance_destroy()
						})
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
			["a", [spr_car, 0, -1]],
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
	
	setPhases([
		new AttackPhase(beat_to_time(10 * 4), [0, 1], function(){
			game_background(, 3)
		}),
		new AttackPhase(beat_to_time(16 * 4), [3, 0, 2], function(){
			game_background([3, 4], 5, 0.01)
		}),
		new AttackPhase(beat_to_time(16 * 4), [4, 1], function(){
			game_background([5, 6])
		}),
		new AttackPhase(beat_to_time(16 * 4), [1, 4, 2], function(){
			game_background([7, 8], 6, 0.01)
		}),
	]);
})


// ~~ STAGE ~~

global.counters.flower_x = new Counter(0)
global.counters.y = new Counter(1)

addPause(beat_to_frame(1));

addSection(function(){
	game_background( , 1);
	for (var i = 0; i < 16; i++)
		enemy_delay(
			"basic1", 
			WIDTH / 2 + wave(-196, 196, 7,, i), 
			global.counters.y.rand_irange(32, 96), 
			i * beat_to_frame(2)
		);
});
addPause(beat_to_frame(8 * 4 - 1))

addSection(function(){
	game_background( , 4);
	
	enemy_delay("big1", WIDTH / 2, 100, 60);
})
addPause(beat_to_frame(4 * 4))

addSection(function(){
	for (var i = 0; i < 24; i++)
		enemy_delay(
			"basic1", 
			WIDTH / 2 + global.counters.flower_x.rand_irange(-128, 128), 
			global.counters.y.rand_irange(80, 128),
			i * beat_to_frame(2)
		);
	
	enemy_delay("big1", WIDTH / 2, 90, beat_to_frame(2 * 4));
	enemy_delay("big1", WIDTH / 2 - 100, 90, beat_to_frame(6 * 4));
})
addPause(beat_to_frame(12 * 4));

addSection(function(){
	game_background([1, 2] , 1);
	
	for (var i = 0; i < 8; i += 2) {
		enemy_delay("basic2", WIDTH / 2 + -190, -32, i * (60 * 1), [i]);
		enemy_delay("basic2", WIDTH / 2 +  190, -32, (i + 1) * (60 * 1), [i + 1]);
	}
})
addPause(beat_to_frame(8 * 4));

addSection(function(){
	game_background([3, 4], 4);
		
	enemy_delay("miniboss", 0, 0, 10);
})
addPause(, true);

addPause(beat_to_frame(2 * 4))

addSection(function(){
	game_background([5, 6], 2)
	spawnUpgrade()
})
addPause(beat_to_frame(2 * 4))

addSection(function(){
	for (var i = 0; i < 8; i++)
		enemy_delay(
			"basic1", 
			WIDTH / 2 + global.counters.flower_x.rand_irange(-128, 128), 
			global.counters.y.rand_irange(80, 128), 
			i * beat_to_frame(2)
		);
	for (var i = 0; i < 4; i++)
		enemy_delay(
			"basic1", 
			WIDTH / 2 - 80 + global.counters.flower_x.rand_irange(-100, 100), 
			global.counters.y.rand_irange(80, 128), 
			beat_to_frame(4 * 4) + i * beat_to_frame(4)
		);
	for (var i = 0; i < 6; i++)
		enemy_delay(
			"basic1", 
			WIDTH / 2 + 40 + global.counters.flower_x.rand_irange(-100, 100), 
			global.counters.y.rand_irange(80, 128), 
			beat_to_frame(8 * 4) + i * beat_to_frame(4)
		);
	
	for (var i = 0; i < 4; i += 2) {
		enemy_delay("basic2", WIDTH / 2 + -170, -32, 60 * 3 + i * (60 * 4), [i]);
		enemy_delay("basic2", WIDTH / 2 +  170, -32, 60 * 3 + (i + 1) * (60 * 4), [i + 1]);
	}
	
	enemy_delay("big1", WIDTH / 2 + 120, 70, beat_to_frame(8 * 4));
	enemy_delay("big1", WIDTH / 2 - 160, 70, beat_to_frame(12 * 4));
})
addPause(beat_to_frame(16 * 4 - 3 * 4));

addPause(beat_to_frame(4 * 2));



addSection(function(){
	game_background(, 1);
	
	enemy_delay("boss", 0, 0, 60)
})
addPause(, true);
addPause(60 * 2);

addSection(function(){
	render.look_set_overlay(0.05, c_teal)
	render.look_set_water(#5555bb, #332233)
	spawnUpgrade()
})
addPause(120, true, 60)

addSection(function(){
	print("table")
	game_music(-1)
	game_nextRoom(rm_stage2);
})

