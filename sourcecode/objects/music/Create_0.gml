playing = -1;
bgm = -1
lastPause = 0;
lastPlaying = playing

introLength = 4;
loopLength = (60 + 4) - introLength;
totalLength = introLength + loopLength;

meta = {
	mus_stage1test: method(self, function(){
		introLength = 3.07;
		loopLength = (60 + 41.53) - introLength;
		totalLength = introLength + loopLength;
	}),
	mus_stage2test: method(self, function(){
		introLength = 19.45;
		loopLength = (60 * 3 + 37.29) - introLength;
		totalLength = introLength + loopLength;
	})
}


/*
// stage 3
introLength = 19.72;
loopLength = (60 + 51.78) - introLength;
totalLength = introLength + loopLength;