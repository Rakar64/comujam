damage = 2

timing = 0
life_time = 60

ball_smoke = part_system_create(ps_canno_smoke);

life_time = function(){
	timing += 1
	
	if(timing >= life_time){
		instance_destroy();
	}
}