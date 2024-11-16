velocity = 0

player_movements = function(){
	var _accel, _right, _left, _dir;
	
	_accel = keyboard_check(ord("W"));
	_right = keyboard_check(ord("D"));
	_left = keyboard_check(ord("A"));
	
	
	
	if(_accel){
		velocity = lerp(velocity, 2, 0.1);
		speed = velocity
	}else{
		velocity = lerp(velocity, 0, 0.1);
		speed = velocity
	}
	
	if(_right){
		image_angle -= 2
		direction -= 2
	}
	
	if(_left){
		image_angle += 2
		direction +=2
	}
}

canon_atk = function(){
	var _dir = point_direction(0, 0, direction / 90, direction / 90);
	var _weapon_pos_x = lengthdir_x(125,_dir);
	var _weapon_pos_y = lengthdir_y(125,_dir);

	var _x = obj_player.x + _weapon_pos_x; 
	var _y = obj_player.y + _weapon_pos_y;
	
	
	draw_sprite_ext(spr_aim, 0, _x, _y,7,2, _dir, c_white, 0.5)
	show_debug_message(direction / 90)
	show_debug_message(_dir)

}