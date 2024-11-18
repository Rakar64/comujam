//shake screen effect values
global.shake_length = 0;
global.shake_time	= 0;

audio_play_sound(snd_music, 1, 1)

global.pause = false;

global.debug = false;

global.bottle_map = false;

global.coins = 0;

global.day = 0;

global.last_day = 0

global.shovel = false

global.discover_points = 0

global.gameover = false

global.shop = false

global.buys = 0

global.price_hp = 0

global.price_cannon = 0

global.price_speed = 0

randomize()

show_map = false;

display_set_gui_size(426, 240);

hours = 0;

player_info_draw = function(){
	
	hours += delta_time / 1000000
	
	draw_set_font(fnt_game);
	draw_set_color(c_yellow)
	
	var _sprite_size = sprite_get_width(spr_player_life_bar)
	draw_sprite(spr_player_life_bar, 0, 10, 10);
	draw_sprite_part(spr_player_life_bar, 1, 12, 0, (_sprite_size) * obj_player.hp / obj_player.max_hp, 19, 22, 10)
	//draw_text(120, 20, hours)
	draw_text(360, 20, "Dia: " + string(global.day))
	//coin
	draw_sprite(spr_coin, 0, 15, 50)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(30,50, global.coins)
	draw_sprite(spr_compass,0, 15, 70)
	draw_text(30, 70, global.discover_points)
	
	draw_set_halign(-1)
	draw_set_valign(-1)
	
	//map icon
	if(global.bottle_map != false){
		draw_sprite(spr_bottle_icon,0, 10, 210)
		
		if(keyboard_check_pressed(ord("Q"))){
			show_map = !show_map
		}
		
		if(show_map){
			draw_set_alpha(0.5)
			draw_rectangle_color(0, 0, 426, 240, c_black, c_black, c_black, c_black, false)
			draw_set_alpha(1)
			draw_sprite(global.bottle_map.map, 0, 213, 120)
			show_debug_message(global.bottle_map.map)
		}
		
	}
	
	if(global.shovel == true){
		draw_sprite(spr_shovel_icon,0, 10, 230)
	}
	
	if(global.shop){
		global.pause = true
		draw_rectangle_color(213, 10, 416, 230,c_black, c_black, c_black, c_black, false)
		draw_set_font(fnt_title)
		draw_text(220, 15, "Loja")
		draw_set_font(fnt_game)
		draw_text(220, 90, "[1] - Melhorar casco - " + string(global.price_hp) + "G")
		draw_text(220, 120, "[2] - Comprar Canhões - " + string(global.price_cannon) + "G")
		draw_text(220, 150, "[3] - Melhorar Velas - " + string(global.price_speed) + "G")
		draw_text(220, 200, "[ESC] - SAIR")
		
		if(keyboard_check_pressed(ord("1"))or keyboard_check_pressed(vk_numpad1)){
			if(global.coins >= global.price_hp){
				global.coins -= global.price_hp
				global.shop = !global.shop
				var _msg = instance_create_layer(0,0,"balls", obj_text)
				_msg.msg = "Casco Melhorado - HP + 1"
				obj_player.max_hp += 1
				obj_player.hp = obj_player.max_hp
				global.pause = !global.pause
				global.buys += 1
			}
		}
		if(keyboard_check_pressed(ord("2"))or keyboard_check_pressed(vk_numpad2)){
			if(global.coins >= global.price_cannon){
				global.coins -= global.price_cannon
				global.shop = !global.shop
				var _msg = instance_create_layer(0,0,"balls", obj_text)
				_msg.msg = "Canhão + 1"
				obj_player.cannon_balls += 1
				global.pause = !global.pause
				global.buys += 1
			}
		}
		if(keyboard_check_pressed(ord("3"))or keyboard_check_pressed(vk_numpad3)){
			if(global.coins >= global.price_speed){
				global.coins -= global.price_speed
				global.shop = !global.shop
				var _msg = instance_create_layer(0,0,"balls", obj_text)
				_msg.msg = "Velas Melhoradas - Mais Velocidade"
				obj_player.max_velocity += 0.5
				global.pause = !global.pause
				global.buys += 1
			}
		}
		if(keyboard_check_pressed(vk_escape)){			
			global.shop = !global.shop
			global.pause = !global.pause
			
		}
		
	}
	
	
	draw_set_font(-1)
	draw_set_color(-1)
}

spawn_enemies = function(){
	if(hours > global.day * 60){
		global.day += 1
	}
	
	if(global.gameover){
		instance_create_layer(0,0, "gameover", obj_game_over);
		
		
	}
	
	if(!instance_exists(obj_bottle) and global.bottle_map == false){
		var _x = random_range(10, room_width - 10)
		var _y = random_range(10, room_height - 10)
		
		instance_create_layer(_x, _y, "balls", obj_bottle)
	}
	
	if(instance_number(obj_enemy_par) <= global.day * 2){
		for(var i = instance_number(obj_enemy_par); i <= global.day * 2; i++){
			var _x = random_range(10, room_width - 10)
			var _y = random_range(10, room_height - 10)
			
			var _enemy = choose(obj_enemy, obj_enemy_shark)
			instance_create_layer(_x, _y, "balls", _enemy)
		}
	}
	
}

calc_prices = function(){
	global.price_cannon = 5 + global.buys + global.day div 10
	global.price_hp = 2 + global.buys + global.day div 10
	global.price_speed = 3 + global.buys + global.day div 10
}