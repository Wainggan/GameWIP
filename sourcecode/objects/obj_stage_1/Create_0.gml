event_inherited();

enemies = {
	"basic": function(){
		hp = 2;
		
		command_set([
			
		]);
	}
}

stage = [
	function(){
		enemy("basic", WIDTH / 2, 100);
		time = -1;
	}
]