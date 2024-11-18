if (global.pause) {
	speed = 0
	exit;
	
}
player_movements();
invencibility_system();
take_damage();
player_limits();
wiggle_effect();