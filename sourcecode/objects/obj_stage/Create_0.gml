enemies = {
	"stage1-basic": function(_spd = 6){
		hp = 4;
		maxhp = 4;
		spd = _spd;
		polarity = sign(x - WIDTH / 2);
		movement_start(WIDTH / 2 + (WIDTH / 2 + 64) * -polarity, y, 1 / abs(x - (WIDTH / 2 + (WIDTH / 2 + 64) * -polarity)) * spd, "linear",function(){instance_destroy()});
		command_set([
			4,
			function(){
				if instance_exists(obj_player)
					bullet_shoot_dir2(x, y, 0.5, 0.3, 15, point_direction(x, y, obj_player.x, obj_player.y));
				commandIndex = 0;
			}
		])
	},
	"stage1-miniboss1": function(){
		hp = 120;
		maxhp = 120;
		startY = y;
		y = -50;
		command_set([
			function(){
				movement_start(x, startY, 1 / 20);
				command_timer(60 * 6, function(){
					command_reset()
				})
				command_timer(60 * 7, function(){
					movement_start(x, HEIGHT + 128, 1 / abs(y - HEIGHT + 128) * 0.6, "smoothStart");
				})
			},
			16,
			function(){
				var dir = random_range(0, 359);
				for (var i = 0; i < 64; i++) {
					bullet_shoot_dir2(x, y, 6, 0.2, 4, dir + random_range(-1, 1));
					dir += 360 / 64
				}
				commandIndex--;
			}
		]);
	},
}
enemy = function(_type, _x, _y){
	var _args = [];
	for (var i = 0; i < argument_count; i++)
		array_push(_args, argument[i]);
	
	var inst = instance_create_layer(_x, _y, "Instances", obj_enemy);
	var func = method_get_index(method(inst, enemies[$ _type]));
	with inst {
		script_execute_ext(func, _args, 3);
	}
	
	return inst;
}

time = 60 * 2;
stageIndex = -1;

stage = [
	function(){
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 60);
			
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", -64 - i * 44, 90);
		
		time = 180;
	},
	function(){
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 40, 3);
			
		for (var i = 0; i < 8; i++)
			enemy("stage1-basic", -64 - i * 44, 60, 3);
			
		time = 60;
	},
	function(){
		for (var i = 0; i < 7; i++)
			enemy("stage1-basic", WIDTH + 64 + i * 44, 80, 2);
			
		for (var i = 0; i < 7; i++)
			enemy("stage1-basic", -64 - i * 44, 100, 2);
			
		time = 180;
	},
	function(){
		enemy("stage1-miniboss1", WIDTH / 2, 60)
		
		time = 200;
	},
]

