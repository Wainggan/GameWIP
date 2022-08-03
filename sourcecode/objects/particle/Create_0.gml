particleSystem = part_system_create_layer("Particles", true);

#region bullet explosion

//Effect1
bulletExplode1 = part_type_create();
part_type_shape(bulletExplode1, pt_shape_disk);
part_type_size(bulletExplode1, 0.02, 0.02, 0.40, 0);
part_type_scale(bulletExplode1, 0.30, 0.30);
part_type_orientation(bulletExplode1, 0, 0, 0, 0, 0);
part_type_color3(bulletExplode1, 12615680, 12615935, 16777215);
part_type_alpha3(bulletExplode1, 0.59, 0.50, 0);
part_type_blend(bulletExplode1, 0);
part_type_life(bulletExplode1, 8, 8);
part_type_speed(bulletExplode1, 0, 0, 0, 0);
part_type_direction(bulletExplode1, 0, 360, 0, 0);
part_type_gravity(bulletExplode1, 0, 0);

//Effect2
bulletExplode2 = part_type_create();
part_type_shape(bulletExplode2, pt_shape_line);
part_type_size(bulletExplode2, 1, 1, -0.05, 0);
part_type_scale(bulletExplode2, 0.30, 0.30);
part_type_orientation(bulletExplode2, 0, 0, 0, 0, 1);
part_type_color3(bulletExplode2, 16776960, 4235519, 255);
part_type_alpha3(bulletExplode2, 0.62, 0.23, 0);
part_type_blend(bulletExplode2, 0);
part_type_life(bulletExplode2, 20, 30);
part_type_speed(bulletExplode2, 4, 5, -0.25, 0);
part_type_direction(bulletExplode2, 0, 360, 0, 0);
part_type_gravity(bulletExplode2, 0, 0);

bulletExplode1_PE = part_emitter_create(particleSystem);
bulletExplode2_PE = part_emitter_create(particleSystem);

#endregion

#region Graze

//Effect1
grazeTest_Effect1 = part_type_create();
part_type_shape(grazeTest_Effect1, pt_shape_sphere);
part_type_size(grazeTest_Effect1, 1, 1, 0, 0);
part_type_scale(grazeTest_Effect1, 0.30, 0.30);
part_type_orientation(grazeTest_Effect1, 0, 0, 0, 0, 0);
part_type_color3(grazeTest_Effect1, 65535, 4235519, 255);
part_type_alpha3(grazeTest_Effect1, 1, 1, 1);
part_type_blend(grazeTest_Effect1, 0);
part_type_life(grazeTest_Effect1, 40, 40);
part_type_speed(grazeTest_Effect1, 5, 5, 0, 0);
part_type_direction(grazeTest_Effect1, 0, 360, 6, 0);
part_type_gravity(grazeTest_Effect1, 0, 0);

//NewEffect Emitters
PE_grazeTest_Effect1 = part_emitter_create(particleSystem);

#endregion

#region Player Death

//Circle
playerDeath_Circle = part_type_create();
part_type_shape(playerDeath_Circle, pt_shape_sphere);
part_type_size(playerDeath_Circle, 1, 1, -0.01, 0);
part_type_scale(playerDeath_Circle, 0.30, 0.30);
part_type_orientation(playerDeath_Circle, 0, 0, 0, 0, 0);
part_type_color3(playerDeath_Circle, 12615935, 4427260, 4850671);
part_type_alpha3(playerDeath_Circle, 0.50, 0.44, 0);
part_type_blend(playerDeath_Circle, 0);
part_type_life(playerDeath_Circle, 40, 40);
part_type_speed(playerDeath_Circle, 2, 2, 0, 0);
part_type_direction(playerDeath_Circle, 0, 360, 6, 0);
part_type_gravity(playerDeath_Circle, 0, 0);

//Pop
playerDeath_Pop = part_type_create();
part_type_shape(playerDeath_Pop, pt_shape_line);
part_type_size(playerDeath_Pop, 1, 1, -0.02, 0);
part_type_scale(playerDeath_Pop, 0.50, 0.50);
part_type_orientation(playerDeath_Pop, 0, 0, 0, 0, 1);
part_type_color3(playerDeath_Pop, 65535, 4361469, 3015134);
part_type_alpha3(playerDeath_Pop, 1, 1, 0);
part_type_blend(playerDeath_Pop, 0);
part_type_life(playerDeath_Pop, 60, 60);
part_type_speed(playerDeath_Pop, 3, 3, -0.07, 0);
part_type_direction(playerDeath_Pop, 0, 360, 0, 0);
part_type_gravity(playerDeath_Pop, 0, 0);

//NewEffect Emitters
PE_playerDeath_Circle = part_emitter_create(particleSystem);
PE_playerDeath_Pop = part_emitter_create(particleSystem);

#endregion

#region Enemy Death

//playerdeath Particle Types
//popin
enemyDeath_popin = part_type_create();
part_type_shape(enemyDeath_popin, pt_shape_circle);
part_type_size(enemyDeath_popin, 1.7, 1.7, -0.23, 0);
part_type_scale(enemyDeath_popin, 1, 1);
part_type_orientation(enemyDeath_popin, 0, 0, 0, 0, 0);
part_type_color3(enemyDeath_popin, 65535, 4235519, 255);
part_type_alpha3(enemyDeath_popin, 0, 1, 0);
part_type_blend(enemyDeath_popin, 0);
part_type_life(enemyDeath_popin, 10, 10);
part_type_speed(enemyDeath_popin, 0, 0, 0, 0);
part_type_direction(enemyDeath_popin, 0, 360, 0, 0);
part_type_gravity(enemyDeath_popin, 0, 0);

//popoutline
enemyDeath_popoutline = part_type_create();
part_type_shape(enemyDeath_popoutline, pt_shape_ring);
part_type_size(enemyDeath_popoutline, 0.20, 0.20, 0.10, 0);
part_type_scale(enemyDeath_popoutline, 1, 1);
part_type_orientation(enemyDeath_popoutline, 0, 0, 0, 0, 0);
part_type_color3(enemyDeath_popoutline, 65408, 4235519, 255);
part_type_alpha3(enemyDeath_popoutline, 1, 1, 0);
part_type_blend(enemyDeath_popoutline, 0);
part_type_life(enemyDeath_popoutline, 10, 10);
part_type_speed(enemyDeath_popoutline, 0, 0, 0, 0);
part_type_direction(enemyDeath_popoutline, 0, 360, 0, 0);
part_type_gravity(enemyDeath_popoutline, 0, 0);

//afterpop
enemyDeath_afterpop = part_type_create();
part_type_shape(enemyDeath_afterpop, pt_shape_flare);
part_type_size(enemyDeath_afterpop, 0.30, 0.35, 0, 0);
part_type_scale(enemyDeath_afterpop, 1, 1);
part_type_orientation(enemyDeath_afterpop, 0, 0, 0, 0, 0);
part_type_color3(enemyDeath_afterpop, 16744448, 4235519, 255);
part_type_alpha3(enemyDeath_afterpop, 0.74, 1, 0);
part_type_blend(enemyDeath_afterpop, 0);
part_type_life(enemyDeath_afterpop, 16, 20);
part_type_speed(enemyDeath_afterpop, 1.50, 1.50, -0.03, 0);
part_type_direction(enemyDeath_afterpop, 0, 360, 0, 0);
part_type_gravity(enemyDeath_afterpop, 0, 0);

//sparks
enemyDeath_sparks = part_type_create();
part_type_shape(enemyDeath_sparks, pt_shape_line);
part_type_size(enemyDeath_sparks, 1, 1, -0.02, 0);
part_type_scale(enemyDeath_sparks, 0.30, 0.30);
part_type_orientation(enemyDeath_sparks, 0, 0, 0, 0, 1);
part_type_color3(enemyDeath_sparks, 8454143, 33023, 4227327);
part_type_alpha3(enemyDeath_sparks, 0.20, 1, 0);
part_type_blend(enemyDeath_sparks, 0);
part_type_life(enemyDeath_sparks, 26, 40);
part_type_speed(enemyDeath_sparks, 2, 3, -0.08, 0);
part_type_direction(enemyDeath_sparks, 0, 360, 0, 0);
part_type_gravity(enemyDeath_sparks, 0, 0);

//playerdeath Emitters
PE_enemyDeath_popin = part_emitter_create(particleSystem);
PE_enemyDeath_popoutline = part_emitter_create(particleSystem);
PE_enemyDeath_afterpop = part_emitter_create(particleSystem);
PE_enemyDeath_sparks = part_emitter_create(particleSystem);



#endregion


burst = function(xp, yp, _name) {
	switch _name {
		case "bulletExplosion":
		var _xv = argument3
		var _yv = argument4
		if _xv != undefined {
			var d = point_direction(0, 0, _xv, _yv)
			part_type_direction(bulletExplode2, d - 120, d + 120, 0, 0);

		}
		part_emitter_region(particleSystem, bulletExplode2, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, bulletExplode2_PE, bulletExplode2, 12);
		part_emitter_region(particleSystem, bulletExplode1, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, bulletExplode1_PE, bulletExplode1, 1);
		part_type_direction(bulletExplode2, 0, 360, 0, 0);
		break;
		case "grazeTest":
		part_emitter_region(particleSystem, PE_grazeTest_Effect1, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_grazeTest_Effect1, grazeTest_Effect1, 20);
		break;
		case "playerDeath":
		part_emitter_region(particleSystem, PE_playerDeath_Pop, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_playerDeath_Pop, playerDeath_Pop, 20);
		part_emitter_region(particleSystem, PE_playerDeath_Circle, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_playerDeath_Circle, playerDeath_Circle, 20);
		break;
		case "enemyDeath":
		part_emitter_region(particleSystem, PE_enemyDeath_sparks, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_enemyDeath_sparks, enemyDeath_sparks, 20);
		part_emitter_region(particleSystem, PE_enemyDeath_afterpop, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_enemyDeath_afterpop, enemyDeath_afterpop, 20);
		part_emitter_region(particleSystem, PE_enemyDeath_popoutline, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_enemyDeath_popoutline, enemyDeath_popoutline, 1);
		part_emitter_region(particleSystem, PE_enemyDeath_popin, xp+0, xp+0, yp+0, yp+0, ps_shape_rectangle, ps_distr_linear);
		part_emitter_burst(particleSystem, PE_enemyDeath_popin, enemyDeath_popin, 1);

		
		break;
	}
}