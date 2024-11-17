//shake screen effect values
global.shake_length = 0;
global.shake_time	= 0;

global.pause = false;

global.debug = false;

display_set_gui_size(426, 240);

player_life_draw = function(){
	var _sprite_size = sprite_get_width(spr_player_life_bar)
	draw_sprite(spr_player_life_bar, 0, 10, 10);
	draw_sprite_part(spr_player_life_bar, 1, 12, 0, (_sprite_size) * obj_player.hp / obj_player.max_hp, 19, 22, 10)
}