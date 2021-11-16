global.showHitboxes = keyboard_check_pressed(ord("O")) ? !global.showHitboxes : global.showHitboxes;

if global.showHitboxes {
	draw_set_color(c_red)
	with all {
		
		var left = floor(bbox_left)
		var right = floor(bbox_right)-1
		var up = floor(bbox_top)
		var down = floor(bbox_bottom)-1
		
		draw_rectangle(left, up, right, down, 1)
		
		//draw_line(left, up, right, up)
		//draw_line(right, up, right, down)
		//draw_line(right, down, left, down)
		//draw_line(left, down, left, up)

	}
	
	draw_set_color(c_white)
}