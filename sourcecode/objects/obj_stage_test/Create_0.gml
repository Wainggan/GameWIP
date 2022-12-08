event_inherited();

enemies = {
	"test": function(){
		hp = 10000;
		canDie = false;
		
		b_lastTaken = 0;
		b_taken = 0;
		onHit = function(_b){
			b_taken += _b.damage;
		}
		
		command_set([
			60,
			function(){
				show_debug_message(b_taken);
				b_taken = 0;
				b_lastTaken = b_taken;
				commandIndex--;
			}
		])
		
	}
}


stage = [
	function(){
		enemy("test", WIDTH / 2, 120);
		randomize()
		time(360);
	}
]

repeat 60
	array_push(stage, function(){
		spawnUpgrade()
		time(60 * 10);
	})

array_push(stage, function(){
	time(60 * 12)
})
array_push(stage, function(){
	game_nextRoom(rm_stage1)
})

