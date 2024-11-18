alpha = 0

global.last_day = global.day

game_over_screen = function(){
	alpha = lerp(alpha, 1, 0.1)
	draw_set_alpha(alpha)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_set_font(fnt_title)
	draw_set_color(c_black)
	draw_rectangle(0, 0, 600, 400, false)
	draw_set_color(-1)
	
	if(alpha >= 0.95){
		
		draw_text(213, 50, "Seu Navio Afundou")
		draw_set_font(fnt_game)
		draw_text(213, 120, "Pressione [ENTER] para Recomeçar")
		draw_set_color(c_yellow)
		draw_text(213, 170, "Você descobriu " + string(global.discover_points) + " Tesouros")
		draw_text(213, 200, "Você navegou por " + string(global.last_day) + " Dias")
		draw_set_color(-1)
		
		if(keyboard_check_pressed(vk_enter))room_restart();
		
	}
	draw_set_font(-1)
	draw_set_alpha(1)
	draw_set_halign(-1)
	draw_set_valign(-1)
	draw_set_color(c_white)
	
}