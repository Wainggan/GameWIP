life-=global.delta_multi
image_alpha = life / maxlife / 2
image_xscale += sizeSpeed * global.delta_multi
image_yscale += sizeSpeed * global.delta_multi
if life <= 0 {
	instance_destroy()
}