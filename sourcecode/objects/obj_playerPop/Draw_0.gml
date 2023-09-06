
//shader_set(shd_blend_emphasis)
gpu_set_blendmode_ext(bm_dest_color, bm_one)
//gpu_set_blendmode_ext_sepalpha(bm_inv_dest_color, bm_inv_src_alpha, bm_src_alpha, bm_inv_src_alpha)
gpu_set_tex_filter(true)
draw_circle_sprite(x, y, size, false, #888888, 1)
gpu_set_tex_filter(false)
gpu_set_blendmode(bm_normal)
//shader_reset()

//draw_circle(x, y, size, true)
