
//shader_set(shd_blend_emphasis)
gpu_set_blendmode_ext(bm_dest_color, bm_one)
draw_circle_sprite(x, y, size, false, #888888, 1)
gpu_set_blendmode(bm_normal)
//shader_reset()

//draw_circle(x, y, size, true)
