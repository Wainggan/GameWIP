/// @description Insert description here

showDirection = false
switch sprite_index {
	case spr_bullet_point:
		showDirection = true
}

// Inherit the parent event
event_inherited();

image_alpha = approach(image_alpha, 1, 0.12 * global.delta_multi);
image_xscale = approach(image_xscale, 1, 0.15 * global.delta_multi);
image_yscale = approach(image_yscale, 1, 0.15 * global.delta_multi);
