global.delta_target = 1/60;
global.delta_multi = global.delta_target

global.pause = 0;

global.time = 0;

global.showHitboxes = false;

testSlowDown = 0

var gameSurfaceX = (window_get_width()/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16
window_mouse_set(gameSurfaceX, gameSurfaceY)

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
			fileVersion : "0.2.0",
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
				allowScreenShake : false,
				fastBulletGlow : false
			}
		}
	}
	
	{ // changes
		
		changeOrder = [
			"0.1.0",
			"0.2.0"
		]
		
	}
	
	function func_checkKeyExist /*= function*/(_struct, _key, _val) {
		if !variable_struct_exists(_struct, _key) {
			variable_struct_set(_struct, _key, _val)
		}
	}
	
	global.file = json_readFrom(FILENAME);
	
	if global.file != undefined && !variable_struct_exists(global.file, "fileVersion") {
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
			case "0.2.0":
				//variable_struct_remove(global.file.save, "highscore");
				//func_checkKeyExist(global.file.settings, "allowScreenShake", false)
				//func_checkKeyExist(global.file.settings, "fastBulletGlow", false)
				global.file = global.file_default; // reset the file
			break;
			default:
				log("Attempted to update to file version " + checkNewVersion + ", but it does not exist.", LOG_ERROR)
			break
		}
		
		global.file.fileVersion = checkNewVersion
		
	}
	
	
}

global.score = 0;
global.highscore = 0;
global.gameActive = false;


instance_create_layer(0,0, "Instances", render)
instance_create_layer(0,0, "Instances", levelLoader)
instance_create_layer(0,0, "Instances", menu)


room_goto(rm_mainmenu)