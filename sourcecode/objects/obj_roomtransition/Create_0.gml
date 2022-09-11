animCurve = new AnimCurve("smooth");
wait = 150;

roomTarget = rm_stage1;
hasSwitched = false;

scoreOld = global.score + 10000;
scoreLivesBonus = obj_player.livesLeft * 10000;
scoreDifficultyBonus = 2;

var _Thing = function(_text = function(){ return "" }, _show = function(){ return "" }, _mod = function(){}, _wait = 12) constructor {
	animCurve = new AnimCurve();
	wait = _wait;
	text = _text;
	show = _show;
	modifier = _mod;
}

scoreAnimWait = 40;
scoreAnimCurve = new AnimCurve();
scoreAnim = [
	new _Thing(function(){
		return "Score: "
	}, function(){
		return scoreOld;
	}, function(){
		global.score = scoreOld;
	}, 40),
	new _Thing(function(){
		return "Life Bonus: ";
	}, function(){
		return scoreLivesBonus;
	}, function(){
		scoreOld += scoreLivesBonus;
	}),
	new _Thing(function(){
		return "Difficulty Bonus";
	}, function(){
		return "x" + string(scoreDifficultyBonus);
	}, function(){
		scoreOld *= scoreDifficultyBonus;
		scoreLivesBonus *= scoreDifficultyBonus;
	}),
	new _Thing( , , , 60)
]

depth = 1000;