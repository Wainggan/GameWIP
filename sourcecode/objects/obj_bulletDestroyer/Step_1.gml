currentSize += sizeSpeed * global.delta_multi;
if (currentSize > targetSize) {
	instance_destroy()
} else {
	var list = ds_list_create()
	collision_circle_list(x, y, currentSize, obj_bullet, 0, 1, list, 0)
	for (var i = 0; i < ds_list_size(list); i++) {
		instance_destroy(list[| i])
	}
	ds_list_destroy(list)
}