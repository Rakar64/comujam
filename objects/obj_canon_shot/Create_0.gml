timing = 0;
damage = 2;

audio_play_sound(snd_canon,1,0)

ball_smoke = part_system_create(ps_canno_smoke);

life_time = function(){
	timing += 1
	
	if(timing >= obj_player.player_range){
		instance_destroy();
	}
}