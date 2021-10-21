menuList = []

enum MENUBUTTON {
	UP,
	DOWN,
	SELECT,
	BACK
}


func_menuTest = function(){
	if !instance_exists(obj_menu) {
		var _inst = instance_create_depth(96, 64, depth, obj_menu)
		with _inst {
			func_addOption("submenu", function(){
				var _inst = instance_create_depth(x + 224, y, depth, obj_menu)
				with _inst {
					priority = other.priority+1
					func_addOption("wow", -1)
				}
			});
			func_addOption("another submenu", function(){
				var _inst = instance_create_depth(x + 224, y, depth, obj_menu)
				with _inst {
					priority = other.priority+1
					
					func_addOption("amazing", -1)
					
					func_addOption("more submenu", function(){
						var _inst = instance_create_depth(x + 224, y, depth, obj_menu)
						with _inst {
							priority = other.priority+1
							func_addOption("nice", -1)
						}
					});
				}
			});
			func_addOption("hi", -1);
		}
	} else {
		instance_destroy(obj_menu)
	}
}