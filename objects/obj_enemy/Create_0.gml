vision = 100;
rot = 0
max_hp = 20;
hp = max_hp;

damage = 2;

atk_time = 0;
atk_timing = 0;

can_atk = false;

state = "";
state_txt = "";

destiny_x = 0;
destiny_y = 0;

on_go = true;

can_surround = false;

can_change_state = false;
state_time = 0
state_temporizer = choose(60, 120, 240);

state_conditions = function(){
	if(distance_to_object(obj_player) <= vision){
		//ESTADO DE ATACAR O PLAYER
		state = state_atk_player
	
	}else{
		if(can_change_state == false){
			state_time += 1
			if(state_time >= state_temporizer){
				can_change_state = true;
				state_temporizer = choose(60, 120, 240);
				state_time = 0;
			}
		}
		if(can_change_state){
			state = choose(state_stopped, state_navigate, state_navigate)
			can_change_state = false;
		}
		
	}
	
	if(hp <= 0){
		instance_destroy()
	}
	
}

state_stopped = function(){
	state_txt = "stopped"
	speed = 0;
	on_go = true
}

state_navigate = function(){
	state_txt = "navigate";
	
	if(on_go){
		destiny_x = random_range(0, 1500);
		destiny_y = random_range(0, 1000);
		on_go = false
	}
	
	var _dir = point_direction(x,y, destiny_x, destiny_y)
	
	
	
	if(abs(direction - _dir) < 4){
		direction = _dir
	}else{
		direction = lerp(direction, _dir, 0.01);
	}
	
	speed = 1;

	if(x <= destiny_x + 1 and x >= destiny_x -1 and y <= destiny_y + 1 and y >= destiny_y -1){
		state = state_stopped;	
	}
	
}

state_atk_player = function(){
	state_txt = "atack"
	
	rot += 2.5
	
	destiny_x = obj_player.x + cos(rot / 100) * 80;
	destiny_y = obj_player.y + sin(rot / 100) * 80;
	
	var _dir = point_direction(x, y, destiny_x, destiny_y);
	
	direction = _dir;
		
	speed = 1.5;
	
	if(x <= destiny_x + 1 and x >= destiny_x -1 and y <= destiny_y + 1 and y >= destiny_y -1){
		speed = 0;
	}
	
	show_debug_message(direction)
}

aiming = function(){
	if(state == state_atk_player){
		if(can_atk == false){
			//draw the aim
			var _direc = point_direction(x, y, obj_player.x, obj_player.y);
			var _weapon_pos_x = lengthdir_x(125,_direc);
			var _weapon_pos_y = lengthdir_y(125,_direc);
		
			var _x = x + _weapon_pos_x; 
			var _y = y + _weapon_pos_y;
		
			draw_sprite_ext(spr_aim, 0, _x, _y, 7, 2, _direc, c_purple, (atk_time / atk_timing) * 0.2);
		
			atk_time += 1
			atk_timing = 120;
		
			if(atk_time >= atk_timing){
				can_atk = true;
				atk_time = 0;
			}
		}
		if(can_atk){
			var _shot = instance_create_layer(x,y, "balls", obj_enemy_ball);
			var _dir = point_direction(x, y, obj_player.x, obj_player.y);
			_shot.direction = _dir;
			_shot.speed = 4;
			_shot.damage = damage;
			can_atk = false;
		}
	}
}

take_damage = function(){
	if(instance_place(x,y,obj_canon_shot)){
		var _ball = instance_place(x,y,obj_canon_shot)
		hp -= _ball.damage
		var _part = part_system_create(ps_ball_impact)
		part_system_position(_part, x, y)
		part_system_depth(_part, -100);
		instance_destroy(_ball)
		global.shake_length = 10;
		global.shake_time = 0.2;
	}
}

enemy_debug = function(){
	if(global.debug){
		draw_text(x, y - 20, state_txt);
		draw_circle_color(destiny_x, destiny_y, 20, c_yellow, c_yellow, false);
		draw_circle(x, y, vision, true);
		draw_text(x, y -30, hp)
	}

}



state = state_stopped;