var deathBuffer = 64;

if (x < -deathBuffer || WIDTH+deathBuffer < x) || (y < -deathBuffer || HEIGHT+deathBuffer < y) {
	instance_destroy()
}