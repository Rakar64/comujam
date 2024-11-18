map = ""
bottle_part = part_system_create(ps_bottle_part);
timed = 0;

put_a_map = function(){
	map = choose(obj_island_1,obj_island_2,obj_island_3,obj_island_4,obj_island_5,obj_island_6,obj_island_7);
}

player_catch = function(){
	if(distance_to_object(obj_player) <= 20){
		var _dir = point_direction(x,y, obj_player.x, obj_player.y)		
		direction = _dir
		speed = 2;
	}
	
	if(instance_place(x,y,obj_player)){
		global.bottle_map = map;
		instance_destroy();
		var _msg = instance_create_layer(0,0, "balls", obj_text)
		_msg.msg = "Pressione [Q] Para Abrir o Mapa"
	}
	
}

bottle_feedback = function(){
	part_system_position(bottle_part,x,y);
	var _frequency = 0.1;
	var _amplitude = 0.1;
	
	image_xscale = 1 + cos(timed*_frequency)*_amplitude;
	image_yscale = 1 + sin(timed*_frequency)*_amplitude;
	timed++;
}

put_a_map();