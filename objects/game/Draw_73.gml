global.showHitboxes = keyboard_check_pressed(ord("O")) ? !global.showHitboxes : global.showHitboxes;

if global.showHitboxes {
	draw_set_color(c_red)
	with all {
		
		var left = bbox_left
		var right = bbox_right-1
		var up = bbox_top
		var down = bbox_bottom-1
		
		draw_line_width(left, up, right, up, 2)
		draw_line_width(right, up, right, down, 2)
		draw_line_width(right, down, left, down, 2)
		draw_line_width(left, down, left, up, 2)

	}
	
	draw_set_color(c_white)
}