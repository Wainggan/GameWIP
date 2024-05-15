// STAGE 2

event_inherited()

game_music(mus_stage2)


// ~~ ENEMIES ~~

addEnemy("basic1", function(){
	setHp(5);
	setPoints(100, 1);
	
	setSprite(spr_enemy_flower_red);
	
	setHook_Insta();
	
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
			sound.play(snd_bulletshoot_2)
		},
		4,
		function(){
			with bullet_shoot_dir2(x, y, 0, 0.2, 9, b_dir) {
				bullet_set_look(, , cb_pink)
			}
			if b_reload-- > 0 commandIndex--
		},
		20,
		function(){
			b_reload = 10;
			movement_start(clamp(x + irandom_range(-128, 128), 32, WIDTH - 32), irandom_range(30, 200), 1/20);
		},
		20, 
		function(){
			commandIndex = 1;
		}
	]);
	command_add([
		80,
		new CommandBeat(2),
		function(){
			bullet_preset_plate(x, y, 2, 24, 50, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
				bullet_shoot_dir2(_x, _y, 4, 2, 14, _dir).glow = cb_green;
			})
			sound.play(snd_bulletshoot_3)
			commandIndex--;
		},
	])
})

addEnemy("basic2", function(){
	setHp(14)
	setPoints(1000, 2)
	
	setSprite(spr_enemy_fire)
	
	setHook_Insta();
	
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
		4,
		function(){
			b_golden = bullet_preset_golden(x, y, 0, 1, b_golden, function(_x, _y, _dir){
				bullet_shoot_dir(_x, _y, 2, _dir).glow = cb_grey;
			})
			sound.play(snd_bulletshoot, 2)
			commandIndex--
		},
	]);
});

addEnemy("big1", function() {
	setHp(180);
	setPoints(1000, 8);
	
	setSprite(spr_enemy_thing);
	
	startX = x;
	startY = y;
	
	x = x + irandom_range(-96, 96)
	y = -64
	
	setInvincible(true);
	movement_start(startX, startY, 1/120, , function(){ setInvincible(false) });
	
	
	command_timer(60 * 10, function(){
		command_reset()
		movement_start(WIDTH / 2, y + 128, 1/360, , function(){
			instance_destroy();
		})
	})
	
	b_golden = 0;
	
	command_set([
		120,
		2,
		function(){
			b_golden = bullet_preset_golden(x, y, 8, 2, b_golden, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 14, 0.4, 1, _dir) {
					glow = cb_pink;
					//sprite_index = spr_bullet_huge
				}
			})
			sound.play(snd_bulletshoot, 2)
			commandIndex--;
		},
	]);
	
	command_add([
		120 + 60,
		new CommandBeat(8),
		function(){
			with bullet_shoot_dir2(x, y, 1, 0.1, 4.5, point_direction(x, y, obj_player.x, obj_player.y)) {
				glow = cb_teal;
				sprite_index = spr_bullet_inverted;
			}
			sound.play(snd_bulletshoot_2)
			commandIndex--;
		},
	]);
	
});

addEnemy("basic3", function(_rate = 3){
	
	setHp(70)
	setPoints(2000, 4)
	
	setSprite(spr_enemy_cat)
	
	b_angle = irandom_range(0, 360)
	b_count = 0
	b_rate = _rate
	
	command_set([
		30,
		b_rate,
		function(){
			
			bullet_preset_ring(x, y, 5, 16, b_angle, function(_x, _y, _dir, _i){
				with bullet_shoot_dir3(_x, _y, 3.5, 0.2, 0, 1, 4, _dir) {
					glow = _i == 0 ? cb_white : cb_indigo
					sprite_index = _i == 0 ? spr_bullet_spark : spr_bullet_square
				}
			})
			sound.play(snd_bulletshoot)
			b_angle += 360 / 5 / 2 + 3.6
			
			command_repeat(40)
			
		},
		8,
		function(){
			if b_count++ < 2 {
				movement_start(clamp(lerp(x, obj_player.x, 0.4), 96, WIDTH-96), y + 32, 1/20)
				commandIndex = 0;
			}
		},
		60,
		function(){
			movement_start(x, -96, 1/120,,function(){instance_destroy()})
		}
	])
	
})

addEnemy("basic4", function(){
	
	setHp(2)
	setPoints(100, 1);
	
	setSprite(spr_enemy_flower_blue);
	
	b_dir = sign(x - WIDTH / 2);
	b_angle = offset * 45
	
	startX = x
	
	x = WIDTH/2 + (WIDTH/2 + 64) * b_dir;
	
	movement_start(startX, y, 1/40)
	
	command_set([
		50,
		function(){
			bullet_preset_poly(x, y, 7, 3, 48, b_angle, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 3, 0.1, 1.5, _dir + 90) {
					bullet_set_look(, spr_bullet_line, cb_grey)
				}
			})
			sound.play(snd_bulletshoot_2)
		},
		50,
		function(){
			movement_start(WIDTH/2 + (WIDTH/2 + 64) * b_dir, y, 1/40,, function(){instance_destroy()})
		}
	])
	
})


pattern_add("stage2-miniboss1-1", function(){
	
	setInvincible(false)
	
	static __b_golden = 0
	b_golden = __b_golden;
	__b_golden += 5
	
	if b_meta
		movement_start(WIDTH/2 + irandom_range(-40, 40), 50, 1/20)
	else
		movement_start(WIDTH/2, 50, 1/20)
	
	command_set([
		18,
		b_meta ? 3 : 1,
		function(){
			if b_meta b_golden += 2
			b_golden = bullet_preset_golden(x, y, 48, b_meta ? 8 : 3, b_golden, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 12, 0.3, 3, _dir + random_range(-1, 1)) {
					bullet_set_look(, spr_bullet_normal, cb_red);
				}
			})
			sound.play(snd_bulletshoot)
			command_repeat(b_meta ? 80 : 100);
		},
		60,
		nextPattern,
	]);
	
	b_count = 0;
	command_add([
		60,
		1,
		function(){
			var _dist = b_meta ? 220 : 232
			with bullet_shoot_dir2(x + (b_count++ % 2 == 0 ? -_dist : _dist) + irandom_range(-128, 128), HEIGHT + 32, 0, 0.2, 9, 90, 1) {
				bullet_set_look(, spr_bullet_large, cb_green);
			}
			sound.play(snd_bulletshoot_3)
			commandIndex--;
		}
	]);
	
});

pattern_add("stage2-miniboss1-2", function(){
	
	b_angle = 0;
	
	b_amount = 11;
	b_change = (360 / b_amount / 2 / 2 / 2) + random_range(-0.025, 0.025)
	if b_meta {
		b_amount = 12
		b_change = (360 / b_amount / 2 / 2 / 2) + random_range(-0.05, 0.05)
	}
	
	static __b_dir = 0
	b_dir = __b_dir++ % 2 == 0 ? 1 : -1;
	
	command_set([
		function() {
			movement_start(clamp(obj_player.x, 128, WIDTH - 128) + wave(-64, 64, 1,, phaseTimer/60), wave(40, 100, 1,1/3, phaseTimer/60), 1/40);
		},
		50,
		function(){
			movement_start(x + sign(x - obj_player.x) * 24, y -16, 1/40, "linear");
		},
		1,
		function(){
			bullet_preset_ring(x, y, b_amount, 8, b_angle, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 8, 0.12, 2, _dir) {
					sprite_index = spr_bullet_small;
				}
			});
			sound.play(snd_bulletshoot)
			b_angle += b_change * b_dir;
			command_repeat(30);
		},
		function(){
			bullet_preset_plate(x, y, b_meta ? 19 : 9, 8, b_meta ? 40 : 16, 0, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 6, 0.1, 2, _dir) {
					sprite_index = spr_bullet_star
					glow = cb_green;
				}
			})
			sound.play(snd_bulletshoot_2)
		},
		120,
		nextPattern,
	]);
	
});

pattern_add("stage2-miniboss1-3", function(){
	
	movement_start(WIDTH / 2, HEIGHT / 4, 1 / 20);
	command_set([
		new CommandBeat(3), 
		function(){
			bullet_shoot_dir2(irandom_range(16, WIDTH-16), -32, 12, 0.2, 3, 270, 1).sprite_index = spr_bullet_star;
			sound.play(snd_bulletshoot)
			commandIndex--;
		}
	]);
	count = 0;
	angle = 0;
	command_add([
		30,
		function(){
			movement_start(clamp(lerp(obj_player.x, WIDTH/2, -0.25), 96, WIDTH - 96), wave(40, 100, 1,1/3, phaseTimer/60), 1/40);
		},
		40,
		function(){
			angle = point_direction(x, y, obj_player.x, obj_player.y);
		},
		16,
		function(){
			bullet_preset_plate(x, y, b_meta ? 4 : 2, 0, b_meta ? 44 : 16, 12, angle, function(_x, _y, _dir){
				with bullet_shoot_dir(_x, _y, 4, _dir) {
					bullet_set_look(, spr_bullet_square, cb_grey)
				}
			})
			sound.play(snd_bulletshoot_2)
			command_repeat(4)
		},
		function(){
			count++;
			if count < 2 {
				commandIndex = 0;
			}
		},
		60,
		nextPattern,
	]);
	
	b_golden1 = 0;
	b_golden2 = 0;
	command_add([
		new CommandBeat(1),
		function(){
			var _amount = b_meta ? 4 : 3
			var _fml = bullet_preset_golden(b_count % 2 == 0 ? -32 : WIDTH+32, wave(32, HEIGHT/2, 4,, phaseTimer/60), 9, _amount, b_count % 2 == 0 ? b_golden1 : b_golden2, function(_x, _y, _dir){
				with bullet_shoot_dir(_x, _y, 2, _dir) {
					bullet_set_look(, spr_bullet_small, cb_green);
				}
			});
			if b_count % 2 == 0 b_golden1 = _fml;
			else b_golden2 = _fml;
			b_count++;
			sound.play(snd_bulletshoot_3)
			
			commandIndex--;
		}
	])
	
})

addEnemy("miniboss1", function(){
	setBoss();
	
	setSprite(spr_boss_red, true);
	setInvincible(true);
	
	x = WIDTH - 74;
	y = -60;
	
	movement_start(WIDTH / 2, 100, 1/120, , startPhase);
	
	b_meta = false
	
	setPatterns([
		new Pattern("stage2-miniboss1-1"),
		new Pattern("stage2-miniboss1-2"),
		new Pattern("stage2-miniboss1-3"),
	]);
		
	setPhases([
		new AttackPhase(beat_to_time(8 * 4), [0, 1]),
		new AttackPhase(beat_to_time(8 * 4), [2, 1]),
	]);
	
})
addEnemy("miniboss2", function(){
	setBoss();
	
	setSprite(spr_boss_red, true);
	setInvincible(true);
	
	x = -50;
	y = -20;
	
	movement_start(WIDTH / 2, 100, 1/100, , startPhase);
	
	b_meta = true
	
	setPatterns([
		new Pattern("stage2-miniboss1-1"),
		new Pattern("stage2-miniboss1-2"),
		new Pattern("stage2-miniboss1-3"),
	]);
		
	setPhases([
		new AttackPhase(beat_to_time(8 * 4), [0, 1]),
		new AttackPhase(beat_to_time(8 * 4), [2, 1]),
	]);
	
})


addEnemy("basic5", function(_dir = 1, _amount = 6) {
	
	setHp(30)
	setPoints(1000, 2)
	
	setSprite(spr_enemy_crystal)
	setInvincible(true)
	
	startY = y
	
	y = -50
	
	movement_start(x, startY, 1/50)
	
	
	b_angle = offset * 40
	b_dir = _dir
	
	b_amount = _amount
	
	b_last = offset
	
	command_set([
		60,
		new CommandBeat(2),
		function(){
			setInvincible(false)
			
			b_last++
			
			bullet_preset_ring(x, y, b_amount, 24, b_angle, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 0, 0.04, 4, _dir) {
					if other.b_last % 5 != 0
						bullet_set_look(, spr_bullet_arrow, cb_pink)
					else
						bullet_set_look(, spr_bullet_inverted, cb_teal)
					bullet_set_dir_target(, 1, _dir + 90 * -other.b_dir)
				}
			})
			
			sound.play(snd_bulletshoot)
			
			b_angle += (360 + 45 * b_amount) / b_amount / 8 * b_dir
			
			command_repeat(30)
			
		},
		60,
		function(){
			movement_start(choose(-50, WIDTH + 50), -40, 1/300,,function(){instance_destroy();});
		}
	])
	
	
	
})


pattern_add("stage2-boss-1", function(){
	
	b_density = 30
	if currentPhase > 0 {
		b_density = 40
	}
	
	command_set([
		new CommandBeat(16),
		function(){
			bullet_preset_plate(x, y, 7, 2, 80, 10, point_direction(x, y, obj_player.x, obj_player.y), function(_x, _y, _dir){
				with bullet_shoot_dir3(_x, _y, 10, 0.5, 1, 0.1, 3, _dir) {
					bullet_set_look(, spr_bullet_star, cb_grey)
				}
			})
			sound.play(snd_bulletshoot_2)
			command_repeat(8)
		},
		20,
		nextPattern
	])
	command_add([
		new CommandBeat(8),
		function(){
			bullet_preset_ring(x, y, b_density, 0, irandom(360), function(_x, _y, _dir){
				with bullet_shoot_dir(_x, _y, 2, _dir) {
					bullet_set_look(, spr_bullet_spark, cb_red)
				}
			})
			sound.play(snd_bulletshoot)
			commandIndex--
		}
	])
	
})

global.counters.boss_1_golden = new Counter()
global.counters.boss_1_dir = new Counter()
pattern_add("stage2-boss-2", function(){
	
	b_golden = global.counters.boss_1_golden.next()
	b_dir = global.counters.boss_1_dir.next() % 2 == 0 ? -1 : 1
	b_speed = 1;

	command_set([
		60,
		3,
		function(){
			b_golden = bullet_preset_golden(x, y, 0, 5, b_golden + 2, function(_x, _y, _dir, i) {
				_dir *= b_dir
				with bullet_shoot_dir3(_x, _y, 8, 0.2, 1, 0.05, i % 6 == 0 ? -b_speed * 1 : b_speed * 2, _dir) {
					bullet_set_look(, spr_bullet_small, cb_red)
				}
			})
			sound.play(snd_bulletshoot)
			command_repeat(60 * 6 / 2)
		},
		nextPattern,
	]);
	command_add([
		120,
		function(){
			movement_start(approach(x, obj_player.x + irandom_range(-32, 32), 64), 96 + irandom_range(-8, 64), 1/60);
			commandIndex--;
		}
	])
	
})
pattern_add("stage2-boss-3", function(){
	
	b_golden = global.counters.boss_1_golden.next() * 2
	b_speed = 2.5
	b_density = 3;
	
	command_set([
		50,
		2,
		function(){
			b_golden = bullet_preset_golden(x, y, 0, b_density, b_golden, function(_x, _y, _dir, i) {
				with bullet_shoot_dir3(_x, _y, 1, 0.2, 6, 0.1, b_speed, _dir) {
					bullet_set_look(, spr_bullet_arrow, cb_green)
					bullet_set_dir_target(, 2, _dir + angle_difference(point_direction(x, y, obj_player.x, obj_player.y), _dir) * 0.5)
				}
			});
			sound.play(snd_bulletshoot)
			command_repeat(60 * 1 / 2)
		},
		nextPattern,
	]);
})

global.counters.boss_4_move = new Counter()
pattern_add("stage2-boss-4", function() {
	
	b_count = 0
	b_total = 0
	
	command_set([
		40,
		22,
		function(){
			
			bullet_preset_ring(WIDTH / 2, HEIGHT / 2, 12 + (b_count++ % 4), point_distance(0, 0, WIDTH, HEIGHT)/2 + 16, frac(sin(time_phase / 60) * 1000) * 360, function(_x, _y, _dir) {
				static __frac = function(_x, _y, _t) {
					
					
					var _f_x = sin(_x / WIDTH + _t)
					var _f_y = sin(_y / HEIGHT + _t)
					
					_t += (_f_x + _f_y) / 2 * 10
					_t *= 0.5
					
					var _add = 0
					_add += wave(0, 1, 9, 30, _t / 60) * 0.55
					_add += wave(0, 1, 7,, _t / 60) * 0.25
					_add += wave(0, 1, 13,, _t / 60) * 0.10
					
					return _add
					
				}
				
				b_total++
				
				with bullet_shoot(_x, _y) {
					if other.b_total % 7 == 0
						bullet_set_look(, spr_bullet_star, cb_indigo)
					else
						bullet_set_look(, spr_bullet_point, cb_red)
					bullet_set_spd(, 2, 270)
					bullet_set_dborder(, 196)
					b_calc = __frac
					b_other = other
					bullet_set_step(, function(){
						var _c = b_calc(x, y, b_other.time_total / 60)
						spd = (abs(_c - 0.5) * -2 + 1) * 2.5 + 1
						dir = _c * 320 - 320/2 - 90
					})
				}
			})
			// sound.play(snd_bulletshoot_3)
			
			commandIndex-- 
		}
	])

	b_command = 0
	b_dir = 0
	
	command_add([
		70,
		function(){
			movement_start(WIDTH / 2 + (global.counters.boss_4_move.next() % 2 == 0 ? -128 : 128) + irandom_range(-20, 20), irandom_range(60, 120), 1/40)
		},
		40 + 30,
		function(){
			b_dir = point_direction(x, y, obj_player.x, obj_player.y)
		},
		new CommandBeat(4),
		function(){
			bullet_preset_plate(x, y, 6, 12, 40, -16, b_dir, function(_x, _y, _dir){
				with bullet_shoot_dir2(_x, _y, 0.1, 0.04, 2, _dir) {
					bullet_set_look(, spr_bullet_normal, cb_teal)
				}
			})
			sound.play(snd_bulletshoot_2)
			command_repeat(3)
		},
		function(){
			if b_command++ < 2
				commandIndex = 0
		},
		40,
		nextPattern
	])
	
})
pattern_add("stage2-boss-5", function(){
	
	command_set([
		50,
		6,
		function(){
			bullet_preset_ring(x, y, 7, 32, wave(-360, 360, 14,, time_phase / 60), function(_x, _y, _dir){
				with bullet_shoot_dir3(_x, _y, 1, 2, 12, 0.5, 2, _dir) {
					bullet_set_look(, spr_bullet_arrow, cb_red);
				}
				sound.play(snd_bulletshoot)
			})
			command_repeat(floor(60 * 6 / 4))
		},
		60,
		nextPattern
	]);
	
	b_count = 0;
	b_angle = 0;
	command_add([
		30,
		function(){
			movement_start(clamp(obj_player.x, 96, WIDTH - 96) + irandom_range(-64, 64), irandom_range(40, 100), 1/40);
		},
		40,
		function(){
			b_angle = point_direction(x, y, obj_player.x, obj_player.y);
		},
		28,
		function(){
			bullet_preset_plate(x, y, 8, 0, 90, 12, b_angle, function(_x, _y, _dir){
				with bullet_shoot_dir(_x, _y, 3, _dir) {
					bullet_set_look(, spr_bullet_square, cb_black)
				}
				sound.play(snd_bulletshoot_2)
			})
			if b_count++ > 4 {
				b_count = 0;
				commandIndex = 0;
			} else commandIndex--;
		}
	]);
				
	command_add([
		7,
		function(){
			bullet_preset_ring(choose(-32, WIDTH + 32), 20, 5, 0, random_range(0, 360), function(_x, _y, _dir){
				with bullet_shoot_dir(_x, _y, 1, _dir) {
					bullet_set_look(, spr_bullet_small, cb_green)
				}
			});
			commandIndex--;
		}
	]);
})

pattern_add("stage2-boss-6", function(){
	
	b_dir = 1
	b_density = 9
	b_angle = 80
	b_total = 0
	
	command_set([
		40,
		6,
		function(){
			
			// sigh
			command_get(0)[1] = floor(clamp(6 - b_count * 1.5, 2, 5))
			
			with bullet_shoot_dir(x, y, 2, 270 + wave(-10, 10, 12, , time_phase / 60) + (-b_angle / 2 + b_angle * b_total) * b_dir) {
				bullet_set_look(, spr_bullet_square, cb_red)
			}
			sound.play(snd_bulletshoot)
			
			
			b_total += 1 / (b_density + irandom(2))
			if b_total >= 1 {
				b_total = 0
				b_dir = -b_dir
			}
			commandIndex--
			
		}
	])
	
	command_add([
		new CommandBeat(12),
		function(){
			bullet_preset_ring(x, y, 40, 60, random(360), function(_x, _y, _dir) {
				with bullet_shoot_dir2(_x, _y, 0.5, 0.1, 3, _dir) {
					bullet_set_look(, spr_bullet_star, cb_indigo)
				}
			})
			sound.play(snd_bulletshoot_2)
			commandIndex--
		}
	])
	
	b_count = 0
	
	command_add([
		240,
		function(){
			
			movement_start((b_count++ % 2 == 0 ? 128 : WIDTH - 128) + irandom_range(-64, 64), irandom_range(40, 100), 1/240)
			command_repeat(3)
			
		},
		240,
		nextPattern
	])
	
})

addEnemy("boss", function(){
	setBoss()
	
	setSprite(spr_boss_red, true)
	setInvincible(true)
		
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
				//audio_play_sound(mus_boss2, 0, false
				setInvincible(false)
				startPhase()
				//func_nextAttack()
			}],
		]);
	});
		
	//currentAttack = 4;
	
	setPatterns([
		new Pattern("stage2-boss-1"),
		new Pattern("stage2-boss-2"),
		new Pattern("stage2-boss-3"),
		new Pattern("stage2-boss-4"),
		new Pattern("stage2-boss-5"),
		new Pattern("stage2-boss-6"),
	]);
		
	setPhases([
		new AttackPhase(beat_to_time(16 * 4), [0, 1]),
		new AttackPhase(beat_to_time(16 * 4), [4, 0]),
		new AttackPhase(beat_to_time(24 * 4), [2, 4, 0, 1]),
		new AttackPhase(beat_to_time(32 * 4), [3, 1, 3, 0]),
		new AttackPhase(beat_to_time(32 * 4), [5, 0, 2, 0]),
	]);
	
})


// ~~ stage ~~

render.look_set_overlay(0.1, c_teal, false)
render.look_set_water(#5555bb, #112233, true)
render.look_set_water_mix(#cc99ff, #bbbbaa, true)
render.look_set_water_bullets(#4488bb, 0.7, true)

//stageIndex = 10

ignore addSection(function(){
	enemy("boss", 0, 0);
});
ignore addPause(, true)

addPause(beat_to_frame(2))

addSection(function(){
	game_background( , 3);
	
	enemy("big1", WIDTH / 2, 80);
})
addPause(beat_to_frame(8 * 4 - 2))

addSection(function(){
	enemy("basic1", WIDTH/4, 90)
	enemy("basic1", WIDTH-WIDTH/4, 90)
})
addPause(beat_to_frame(4))

addSection(function(){
	for (var i = 0; i < 38; i++) {
		enemy_delay("basic1", (i % 2 == 0 ? 96 : WIDTH - 96) + irandom_range(-24, 24), irandom_range(80, 120), i * beat_to_frame(2))
	}
	for (var i = 0; i < 14; i++) {
		enemy_delay("basic2", WIDTH / 2 + irandom_range(-32, 32), irandom_range(100, 140), beat_to_frame(8 * 4) + i * beat_to_frame(4))
	}
})
addPause(beat_to_frame(24 * 4 - 4))

addSection(function(){
	game_background([1, 2] , 2);
	render.look_set_atmosphere(0.12)
	
	for (var i = 0; i < 4; i++) {
		enemy_delay("basic3", WIDTH / 2 + irandom_range(-64, 64), 100 + i * 16, beat_to_frame(16) * i);
	}
	
	for (var i = 0; i < 8 * 4 - 4; i++) {
		enemy_delay("basic4", 96 + irandom_range(-32, 32), 128 + irandom_range(-64, 96), beat_to_frame(2) * i);
		enemy_delay("basic4", WIDTH - 96 + irandom_range(-32, 32), 128 + irandom_range(-64, 96), beat_to_frame(2) * i);
	}
})
addPause(beat_to_frame(16 * 4))

addSection(function(){
	game_background(, 3);
	render.look_set_atmosphere(0.05)
	render.look_set_overlay(0.2, #99aaff)
	
	enemy("miniboss1", 0, 0);
});
addPause(, true)

addPause(beat_to_frame(2 * 4))
addSection(function(){
	render.look_set_overlay(0.1, #443344)
	game_background(, 2)
	spawnUpgrade()
});
addPause(beat_to_frame(2 * 4))


addSection(function(){
	game_background([3, 4])
	enemy("basic5", WIDTH / 2, 120)
})
addPause(beat_to_frame(2 * 4))

addSection(function(){
	for (var i = 0; i < 14; i++) {
		enemy_delay("basic5", WIDTH / 2 + (i % 2 == 0 ? -1 : 1) * i * (160 / 14), irandom_range(100, 140), i * beat_to_frame(4), [i % 2 == 0 ? -1 : 1, 2 + floor(i / 2)])
	}
})
addPause(beat_to_frame(16 * 4 - 2 * 4))

addPause(beat_to_frame(2 * 4))

addSection(function(){
	enemy("big1", WIDTH / 2, 100);
})
addPause(beat_to_frame(8 * 4 - 2 * 4))

addSection(function(){
	for (var i = 0; i < 16; i++) {
		enemy_delay("basic1", (i % 2 == 0 ? 96 : WIDTH - 96) + irandom_range(-24, 24), irandom_range(80, 120), i * beat_to_frame(2))
	}
	for (var i = 0; i < 2; i++) {
		enemy_delay("basic5", WIDTH / 2 + irandom_range(-32, 32), irandom_range(120, 160), beat_to_frame(4 * 4) + i * beat_to_frame(8), [i == 0 ? -1 : 1])
	}
})
addPause(beat_to_frame(8 * 4))

addSection(function(){
	for (var i = 0; i < 20; i++) {
		enemy_delay("basic1", (i % 2 == 0 ? 140 : WIDTH - 140) + irandom_range(-24, 24), irandom_range(80, 120), i * beat_to_frame(3))
	}
	for (var i = 0; i < 3; i++) {
		enemy_delay("basic3", WIDTH / 2 + irandom_range(-64, 64), 100 + i * 16, beat_to_frame(16) + beat_to_frame(16) * i, [4]);
	}
})
addPause(beat_to_frame(16 * 4))

addPause(beat_to_frame(2))
addSection(function(){
	enemy("miniboss2", 0, 0);
});
addPause(, true)

addPause(beat_to_frame(2 * 4))
addSection(function(){
	spawnUpgrade()
});
addPause(beat_to_frame(2 * 4))

addPause(, true)

addPause(beat_to_frame(2 * 4))

addSection(function(){
	enemy("boss", 0, 0);
});
addPause(, true)

addPause(beat_to_frame(60 * 2))
addSection(function(){
	spawnUpgrade()
});

addPause(120, true, 60)

addSection(function(){
	game_music(-1)
	game_nextRoom(rm_stage3);
})