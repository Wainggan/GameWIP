if deathBorder != -1 && (x < -deathBorder || WIDTH + deathBorder < x || y < -deathBorder || HEIGHT + deathBorder / 2 < y) 
	instance_destroy();
