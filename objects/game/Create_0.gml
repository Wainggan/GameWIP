global.delta_target = 1/60;
global.delta_multi = global.delta_target

global.pause = 0;

global.showHitboxes = false;


global.file = undefined;

{ // json save unloading
	{ // format
		/*
		FILENAME
		{
			"save" : {
				"highscore" : 0,
				"leaderboard" : [
					{
						"name" : "example",
						"score" : 69420
					},
					{
						"name" : "example2",
						"score" : 20320
					}
				],
				"recordLevel" : 0
			},
			"settings" : {
			
			}
		}
		*/
	}
	
	global.file = json_readFrom(FILENAME);
	if global.file = undefined {
		global.file = {
			save : {
				highscore : 0,
				leaderboard : [
					{
						name : "Alex",
						score : "-999"
					}
				],
				recordLevel : 0
			},
			settings : {}
		}
		
		json_writeFrom(FILENAME, global.file);
		
	}
	
}

global.score = 0;


instance_create_depth(0,0,depth, render)