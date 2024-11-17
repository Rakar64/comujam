velocity = 0;
accuracy = 4;
cannon_balls = 3;

charge_time = 0;

can_shot = false;

player_range = 30;

damage = 2;

player_movements = function(){
	var _accel, _right, _left, _dir;
	
	_accel = keyboard_check(ord("W"));
	_right = keyboard_check(ord("D"));
	_left = keyboard_check(ord("A"));
	
	if(_accel){
		velocity = lerp(velocity, 2, 0.05);
		speed = velocity;
		var _ship_part = part_system_create(ps_ship_feedback);
		part_system_position(_ship_part, x, y);
		part_system_angle(_ship_part, direction - 90);
		part_system_depth(_ship_part, 100)
	}else{
		velocity = lerp(velocity, 0, 0.05);
		speed = velocity;
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

cannon_shot = function(){
	repeat(cannon_balls){
		var _x = x;
		var _y = y;
		
		var _shot_accu = 2 * random_range(-accuracy, accuracy)
		
		var _shot = instance_create_layer(_x, _y, "balls", obj_canon_shot);
		_shot.speed = 5;
		
		var _shot_dir = point_direction(x,y,mouse_x + _shot_accu, mouse_y + _shot_accu)
		_shot.direction = _shot_dir
		
		_shot.damage = damage
		
	}
	
	can_shot = false

}

canon_atk = function(){
	var _click = mouse_check_button(mb_left);
	var _click_release = mouse_check_button_released(mb_left);
	
	if(_click){	
		//draw the aim
		var _dir = point_direction(x, y, mouse_x, mouse_y);
		var _weapon_pos_x = lengthdir_x(125,_dir);
		var _weapon_pos_y = lengthdir_y(125,_dir);
		
		var _x = obj_player.x + _weapon_pos_x; 
		var _y = obj_player.y + _weapon_pos_y;
		
		accuracy = lerp(accuracy, 2, 0.05);
		draw_sprite_ext(spr_aim, 0, _x, _y, 7, accuracy, _dir, c_white, 0.5);

		//draw bar
		var _bar_x1 = x - 10;
		var _bar_y1 = y - 25;
		
		var _max_bar = sprite_get_width(spr_charge_bar);
		
		charge_time += 0.4;
		
		if(charge_time >= _max_bar){
			charge_time = _max_bar;
			can_shot = true;
		}
		
		draw_sprite_ext(spr_charge_bar,0, _bar_x1, _bar_y1, 1, 1, 0, c_white, 1);
		draw_sprite_part(spr_charge_bar,1, 0, 0, (_max_bar) * charge_time / _max_bar, 5, _bar_x1 - 10, _bar_y1 - 2);
		
	}else{
		accuracy = 4;
		charge_time = 0;
	}
	
	if(_click_release and can_shot){
		cannon_shot();
	}
	
}