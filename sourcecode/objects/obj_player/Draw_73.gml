//gpu_set_blendmode_ext(bm_inv_dest_color, bm_inv_src_alpha)
//if hook_maybeTarget {
	draw_sprite_ext(spr_playerTarget, 0, hook_ind_xAnim.value, hook_ind_yAnim.value, hook_ind_showAnim.value, hook_ind_showAnim.value, 0, c_white, 1)
//}

draw_set_color(c_white);
var prog = hook_focus_chargeAnim.value / hook_focus_limit;
draw_line_sprite(2, HEIGHT-3, prog*(WIDTH/2-2)+2, HEIGHT-3, 3);
draw_line_sprite(WIDTH-2, HEIGHT-3, WIDTH-prog*(WIDTH/2-2)+2, HEIGHT-3, 3);

//gpu_set_blendmode(bm_normal);