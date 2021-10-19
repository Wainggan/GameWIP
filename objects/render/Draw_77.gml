var winWidth = window_get_width();
var winHeight = window_get_height();

var gameSurfaceX = (winWidth/2-WIDTH/2)+WIDTH/8;
var gameSurfaceY = 16

draw_surface_stretched(application_surface, gameSurfaceX, gameSurfaceY, WIDTH, HEIGHT)

