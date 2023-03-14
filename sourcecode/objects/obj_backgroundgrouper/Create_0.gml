var layID = layer_get_id("Background");
var tMID = layer_tilemap_get_id(layID);

tileset = tilemap_get_tileset(tMID)

width = 32;
height = max(30, image_yscale);

tilelayer = layer_create(10000);
layer_set_visible(tilelayer, false)
tilemap = layer_tilemap_create(tilelayer, 0, 0, tileset, width, height);

for (var i = 0; i < width; i++) {
	for (var j = 0; j < height; j++) {
		tilemap_set(tilemap, tilemap_get(tMID, i, floor(y / 16 + j)), i, j)
	}
}


sprite_index = spr_nothing;

draw = function(_y){
	draw_tilemap(tilemap, 0, _y)
	
	return;
	for (var i = 0; i < width; i++) {
		for (var j = 0; j < height; j++) {
			//switch grid[i][j] {
			//	case 3:
			//		break;
			//	default:
					draw_tile(tileset, grid[i][j], 0, i * 16, _y + j * 16)
			//}
		}
	}
}