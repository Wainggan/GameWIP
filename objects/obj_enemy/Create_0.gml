bulletList = [];

x_vel = 0;
y_vel = 0;

hp = 12;


func_destroyBullets = function(){
	for (var i = 0; i < array_length(bulletList); i++) {
		if instance_exists(bulletList[i]) {
			instance_destroy(bulletList[i])
		}
	}
}


defaultPattern = [
	[-1, 999]
]


bulletPattern = defaultPattern;
bulletPatternTimeline = 0;
bulletPatternBuffer = 0;