vision = 100;
max_hp = 10;
hp = max_hp;

damage = 2;

atk_time = 0;
atk_timing = 0;
atk_cd = false;

can_atk = false;

state = "";
state_txt = "";

destiny_x = 0;
destiny_y = 0;

on_go = true;

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
	
	if(instance_place(x,y,obj_player)){
		atk_cd = true
	}
	
	if(atk_cd){
		speed = 0
		atk_time = 30
		atk_timing += 1
		if(atk_timing >= atk_time){
			atk_cd = false
			atk_timing = 0			
		}
	}
	
	image_angle = direction
	
	if(hp <= 0){
		instance_destroy()
		global.coins += 1;
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
	
	direction = _dir
	
	speed = 1;

	if(x <= destiny_x + 1 and x >= destiny_x -1 and y <= destiny_y + 1 and y >= destiny_y -1){
		state = state_stopped;	
	}
	
}

state_atk_player = function(){
	state_txt = "atack"
		
	destiny_x = obj_player.x
	destiny_y = obj_player.y
	
	var _dir = point_direction(x, y, destiny_x, destiny_y);
	
	direction = _dir;
	
	if(atk_cd == false){
		speed = 1.5;
	}	
	if(x <= destiny_x + 1 and x >= destiny_x -1 and y <= destiny_y + 1 and y >= destiny_y -1){
		speed = 0;
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

state = state_stopped