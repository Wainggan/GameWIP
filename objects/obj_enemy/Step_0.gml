bulletPatternBuffer += global.delta_multi;
if bulletPatternBuffer >= bulletPattern[bulletPatternTimeline][1] {
	
	bulletPatternBuffer = 0;
	
	bulletPatternTimeline = (bulletPatternTimeline + 1) % (array_length(bulletPattern));
	if bulletPattern[bulletPatternTimeline][0] != -1 {
		bulletPattern[bulletPatternTimeline][0]();
	}
	
}
