
//gpu_set_tex_filter(true)
render.refreshApplicationSurf()
render.blendmodeSet(shd_blend_invert)

draw_circle_sprite(x, y, size, false, merge_color(#bbbbbb, c_white, alpha), 1)
shader_reset()

render.refreshApplicationSurf()
render.blendmodeSet(shd_blend_invert)
draw_circle_sprite(x, y, size2, false, c_white, 1)

//gpu_set_tex_filter(false)
shader_reset()

//draw_circle(x, y, size, true)
