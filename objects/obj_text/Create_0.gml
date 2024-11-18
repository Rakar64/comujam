timed = 0

timing = 0

msg = ""

show_msg = function(){
	timing = 160;
	timed += 1
	if(timed >= timing){
		instance_destroy();
	}
	
	draw_set_font(fnt_game)
	draw_set_color(c_yellow)
	draw_set_halign(1)
	draw_set_valign(1)
	
	var _y = 30
	
	draw_text(213, _y, msg);
	
	draw_set_font(-1)
	draw_set_color(-1)
	draw_set_halign(-1)
	draw_set_valign(-1)
}