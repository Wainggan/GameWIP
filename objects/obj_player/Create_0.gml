moveSpeed = 5;
slowMoveSpeed = 3;

grazeRadius = 48;

grazeCombo = 0;
tGrazeComboTimer = 90;
grazeComboTimer = 0;

grazeBulletList = [];
grazeBulletListClearTime = 64;

grazeHitboxGraphicShow = 0;
grazeHitboxGraphicShowSpeed = 0.04;


bulletCharge = 0;
bulletChargeSpeed = 0.02;
bulletChargeSpeedSlow = 0.1;
bulletChargeTarget = 2;

tReloadTime = 10;
reloadTime = tReloadTime;

bulletSpread = 28;
bulletSpreadSlow = 8
bulletAmount = 3;
bulletSpeed = 10;


horzMovementPriority = [];
vertMovementPriority = [];

func_inputUpdate = function(kleft = 0, kright = 0, kup = 0, kdown = 0) {
	// horz
	// left = -1, right = 1;
	// up = -1, down = 1;
	var upCheck, downCheck, leftCheck, rightCheck;
	upCheck = 0;
	downCheck = 0;
	leftCheck = 0;
	rightCheck = 0;
	for (var i = 0; i < array_length(horzMovementPriority); i++) {
		
		if horzMovementPriority[i] == -1 {
			leftCheck = 1
		}
		if horzMovementPriority[i] == 1 {
			rightCheck = 1
		}
	}
	for (var i = 0; i < array_length(vertMovementPriority); i++) {
		if vertMovementPriority[i] == -1 {
			upCheck = 1
		}
		if vertMovementPriority[i] == 1 {
			downCheck = 1
		}
	}
	
	if kleft && leftCheck == 0  {
		array_insert(horzMovementPriority, 0, -1)
	}
	if kright && rightCheck == 0  {
		array_insert(horzMovementPriority, 0, 1)
	}
	
	if kup && upCheck == 0 {
		array_insert(vertMovementPriority, 0, -1)
	}
	if kdown && downCheck == 0  {
		array_insert(vertMovementPriority, 0, 1)
	}
	
	for (var i = 0; i < array_length(horzMovementPriority); i++) {

		if !kleft && leftCheck == 1 && horzMovementPriority[i] == -1 {
			array_delete(horzMovementPriority, i, 1)
		}
		if !kright && rightCheck == 1 && horzMovementPriority[i] == 1 {
			array_delete(horzMovementPriority, i, 1)
		}
	}
	for (var i = 0; i < array_length(vertMovementPriority); i++) {

		if !kup && upCheck == 1 && vertMovementPriority[i] == -1 {
			array_delete(vertMovementPriority, i, 1)
		}
		if !kdown && downCheck == 1 && vertMovementPriority[i] == 1 {
			array_delete(vertMovementPriority, i, 1)
		}
	}
}

func_grazeFlavorText = function(_text) {
	var _inst = instance_create_depth(x+16, y-16, depth, obj_flavorText)
	with _inst {
		_inst.accel_y = 0.1;
		_inst.x_vel = 0.3;
		_inst.y_vel = -1.3;
			
		_inst.life = 20;
			
		_inst.text = string(_text)
	}
}



slowHitboxAnim = 0;
slowHitboxAnimSpeed = 0.3;


iFrames = 0;