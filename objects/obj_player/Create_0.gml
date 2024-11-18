velocity = 0;
max_velocity = 2
accuracy = 4;
cannon_balls = 3;

max_hp = 6;
hp = max_hp;

invencible = false
invencible_timer = 0

charge_time = 0;

can_shot = false;

player_range = 30;

damage = 2;

timed = 0

player_movements = function(){
	var _accel, _right, _left, _dir;
	
	_accel = keyboard_check(ord("W"));
	_right = keyboard_check(ord("D"));
	_left = keyboard_check(ord("A"));
	
	if(_accel){
		velocity = lerp(velocity, max_velocity, 0.05);
		speed = velocity;
		var _ship_part = part_system_create(ps_ship_feedback);
		part_system_position(_ship_part, x, y);
		part_system_angle(_ship_part, direction - 90);
		part_system_depth(_ship_part, 200)
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
		
		var _shot_accu = 4 * random_range(-accuracy, accuracy)
		
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

take_damage = function(){
	var _ball_touch = instance_place(x,y,obj_enemy_ball)
	var _enemy_touch = instance_place(x,y,obj_enemy_par)
	var _shark_touch = instance_place(x,y, obj_enemy_shark)
	
	if(invencible == false){
		
		if(_enemy_touch){
			hp -= _enemy_touch.damage
			_enemy_touch.hp -= damage
		}
		if(_ball_touch){
			hp -= _ball_touch.damage
			instance_destroy(_ball_touch)
		}
		if(_shark_touch){
			hp -= _shark_touch.damage
		}
	
	
		if(_ball_touch or _enemy_touch or _shark_touch){
			invencible = true;
			invencible_timer = 160;
			global.shake_length = 20
			global.shake_time = 0.2
			var _part = part_system_create(ps_ball_impact)
			part_system_position(_part, x, y)
		}
	}
	
	if(hp <= 0){
		global.gameover = true;
	}
}

player_limits = function(){
	if(x <= -20){
		x += 50
		invencible = true
		invencible_timer = 60
	}
	if(x >= room_width + 20){
		x -= 50
		invencible = true
		invencible_timer = 60
	}
	if(y <= -20){
		y += 50
		invencible = true
		invencible_timer = 60		
	}
	if(y >= room_height + 20){
		y -= 50
		invencible = true
		invencible_timer = 60
	}
}

invencibility_system = function(){
	
	//se o timer de invencibilidade gor menor ou igual a zero a invencibilidade está desativada
	if (invencible_timer <= 0){
		invencible = false
		
		//setando o alpha da imagem para o valor original quando deixar de ficar invencivel
		image_alpha = 1;
		
	}else{
		//reduzindo o timer SOMENTE quando for maior que zero
		invencible_timer --;
		invencible = true;
		
		//Aumentando o valor do alpha pra cair na condicional
		image_alpha += 0.05;
		
			//fazendo o player piscar quando toma dano
			if (image_alpha < 0 or image_alpha > 1){
				image_alpha *= -1;
			}
	}
}

wiggle_effect = function(){
	var _frequency = 0.1;
	var _amplitude = 0.1;
	
	image_xscale = 1 + cos(timed*_frequency)*_amplitude;
	image_yscale = 1 + sin(timed*_frequency)*_amplitude;
	timed++;
}

map_interaction = function(){
	draw_set_font(fnt_game)
	if(distance_to_object(obj_city) <= 20){
		draw_rectangle_color(x + 24, y, x + 100, y + 15, c_black, c_black, c_black, c_black, false);
		draw_text(x + 25, y, "[E] Comprar")
		
		if(keyboard_check_pressed(ord("E"))){
			global.shop = true;
			
		}
	}
	
	if(distance_to_object(obj_island_par) <= 20 and global.shovel){
		draw_rectangle_color(x + 24, y, x + 180, y + 15, c_black, c_black, c_black, c_black, false);
		draw_text(x + 25, y, "[E] Cavar Tesouro");
		
		if(keyboard_check_pressed(ord("E"))){
			global.shovel = false
			var _island = instance_nearest(x,y, obj_island_par)
			
			if(_island.code == global.bottle_map.code){
				global.discover_points += 1
				var _msg = instance_create_layer(0,0, "balls", obj_text)
				_msg.msg = "Você descobriu um tesouro"
				global.bottle_map = false;
			}else{
				var _msg = instance_create_layer(0,0, "balls", obj_text)
				_msg.msg = "Não encontrou nada :("
			}
		}
	}
	
	draw_set_font(-1)

}

player_debug = function(){
	if(global.debug){
		draw_text(x, y - 20, "HP: " + string(hp))
	
	
	}

}