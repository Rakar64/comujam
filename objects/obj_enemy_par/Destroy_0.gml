if(global.shovel == false and global.bottle_map != false){
	var _random = choose(1, 0)
	
	if(_random == 1){
		instance_create_layer(x, y, "balls", obj_shovel)
	}
}