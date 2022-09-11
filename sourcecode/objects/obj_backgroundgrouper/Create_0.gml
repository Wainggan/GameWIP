grid = [];
var layID = layer_get_id("Background");
var tMID = layer_tilemap_get_id(layID);
tileset = tilemap_get_tileset(tMID)
width = 32;
height = max(30, image_yscale);
for (var i = 0; i < width; i++) {
	array_push(grid, []);
	for (var j = 0; j < height; j++) {
		array_push(grid[i], tilemap_get(tMID, i, y / 16 + j));
	}
}

sprite_index = spr_nothing;

draw = function(_y){
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