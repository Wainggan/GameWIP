if deathBorder != -1 && (x < -deathBorder || WIDTH + deathBorder < x || y < -deathBorder || HEIGHT + deathBorder < y) 
	instance_destroy();
