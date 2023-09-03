tilemaps = []

width = 32;
height = max(30, image_yscale);

// set up background layers

// if background issues happen again, blame this
var _layers = layer_get_all()

array_sort(_layers, true)

for (var i = 0; i < array_length(_layers); i++) {
	var layID = _layers[i];
	if !string_starts_with(layer_get_name(layID), "Background")
		continue
		
	layer_set_visible(layID, false)
	
	var _tMID = layer_tilemap_get_id(layID);
	
	var _data = {}
	_data.tileset = tilemap_get_tileset(_tMID)
	_data.tilelayer = layer_create(10000)
	layer_set_visible(_data.tilelayer, false)
	_data.tilemap = layer_tilemap_create(
		_data.tilelayer, 0, 0, 
		_data.tileset, width, height
	);
	_data.water = string_starts_with(layer_get_name(layID), "BackgroundWater")
	
	for (var _x = 0; _x < width; _x++) {
		for (var _y = 0; _y < height; _y++) {
			tilemap_set(_data.tilemap, 
				tilemap_get(_tMID, _x, floor(y / 16 + _y)), 
				_x, _y
			);
		}
	}
	
	array_push(tilemaps, _data)
	
}



sprite_index = spr_nothing;



draw = function(_y){
	for (var i = array_length(tilemaps) - 1; i >= 0; i--) {
		if tilemaps[i].water continue
		draw_tilemap(tilemaps[i].tilemap, 0, _y)
	}
}

draw_water = function(_y){
	for (var i = array_length(tilemaps) - 1; i >= 0; i--) {
		if !tilemaps[i].water continue
		draw_tilemap(tilemaps[i].tilemap, 0, _y)
	}
}
