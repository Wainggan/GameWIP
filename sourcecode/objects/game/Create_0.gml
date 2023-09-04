targetFrame = 60;
global.slowdownTime = 0;

global.delta_target = 1/targetFrame;

global.delta_multi = 1;
global.delta_multiNP = 1; // NP stands for "No Pause"
global.delta_milli = global.delta_target
global.delta_milliP = global.delta_target // Now take a guess
// im extremely stupid

global.pause = 0;
pause = 0;
musicPause = false;

global.time = 0;

game.textboxes_onEnd = function(){};

global.showHitboxes = false;
global.screenShake = 0;
global.screenShakeDamp = 0.2;

global.focus = false;
global.currentBackground = 0;
global.currentBackgroundSpeed = 2;

global.lastTime = 0;

global.shotSound = false;

testSlowDown = 0

var gameSurfaceX = (window_get_width()/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16

global.file = undefined;

{ // json save unloading
	{ // format
		/*
		FILENAME
		{
			"save" : {
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
		log("File time! :D")
		
		global.file_default = { // latest version of the file
			gameVersion : "0.1.0",
			fileVersion : "0.1.0",
			save : {
				leaderboard : [
					{
						name : "Alex",
						score : -7000
					},
					{
						name : "Lych",
						score : -3839000
					}
				],
				recordLevel : 0
			},
			settings : {
				sound : {
					globalVolume : 1,
					musicVolume : 0.8,
					sfxVolume : 0.9,
				},
				graphics : {
					screenShake : 2,
					warping : 1
				}
			}
		}
	}
	
	{ // changes
		
		changeOrder = [
			"0.1.0",
		]
		
	}
	
	function func_checkKeyExist /*= function*/(_struct, _key, _val) {
		if !variable_struct_exists(_struct, _key) {
			variable_struct_set(_struct, _key, _val)
		}
	}
	
	global.file = json_readFrom(FILENAME);
	
	if true || global.file != undefined && !variable_struct_exists(global.file, "fileVersion") {
		global.file = undefined
	}
	
	
	
	if global.file = undefined { // first time creating a file
		json_writeFrom(FILENAME, global.file_default);
		
		global.file = global.file_default;
		
	}
	
	var currentArrayCheckLocation = 0;
	// find where the current file version is in the array
	for (var i = 0; i < array_length(changeOrder); i++) {
		if changeOrder[i] = global.file.fileVersion {
			currentArrayCheckLocation = i;
			break
		}
	}
	
	// loop through all new version changes
	for (var i = currentArrayCheckLocation+1; i < array_length(changeOrder); i++) {
		
		var checkNewVersion = changeOrder[i]
		log("New file version detected, " + checkNewVersion + ", updating...")
		
		switch checkNewVersion {
			default:
				log("Attempted to update to file version " + checkNewVersion + ", but it does not exist.", Log.Error)
			break
		}
		
		global.file.fileVersion = checkNewVersion
		
	}
	
	
}

global.score = 0;
global.highscore = 0;
global.gameActive = false;

instance_create_layer(0,0, "Instances", input)
instance_create_layer(0,0, "Instances", render)
instance_create_layer(0,0, "Instances", sound)
instance_create_layer(0,0, "Instances", menu)
instance_create_layer(0,0, "Instances", particle)
instance_create_layer(0,0, "Instances", music)

room_goto(rm_mainmenu)