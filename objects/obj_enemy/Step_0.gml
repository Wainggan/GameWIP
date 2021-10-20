bulletPatternBuffer += global.delta_multi;
if bulletPatternBuffer >= bulletPattern[bulletPatternTimeline][1] {
	
	bulletPatternBuffer = 0;
	
	bulletPatternTimeline = (bulletPatternTimeline + 1) % (array_length(bulletPattern));
	if bulletPattern[bulletPatternTimeline][0] != -1 {
		
		var _inst = bulletPattern[bulletPatternTimeline][0]();
		if _inst != undefined && instance_exists(_inst) {
			array_push(bulletList, _inst)
		}
	}
	
}

