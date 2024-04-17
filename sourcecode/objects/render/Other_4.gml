layer_set_visible(layer_get_id("Background"), false);

// fuck meeee
global.currentBackground = 0;
global.currentBackgroundSpeed = 2 // WHY. FUCK.
currentBackground = 0;
newBackground = 0;

backgroundOrder = [];
with obj_backgroundGrouper array_push(other.backgroundOrder, self);
array_sort(backgroundOrder, function(_a, _b) {
	return _b.y - _a.y;
})

// ????
ignore if array_length(backgroundOrder) == 0 {
	array_push(backgroundOrder, instance_create_layer(0, 0, "Instances", obj_backgroundGrouper, {
		image_xscale: 32,
		image_yscale: 30
	}));
}
