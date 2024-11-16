//camera target, wil center the screen on him
target = obj_player;
x_to = noone;
y_to = noone;

//screen size values
view_width = camera_get_view_width(view_camera[0]);
view_height = camera_get_view_height(view_camera[0]);

camera_work = function(){
	//setting in center of screen the target
	x_to = target.x - view_width div 2;
	y_to = target.y - view_height div 2;
	
	//slow center camera on target to soft effect
	x_to = clamp(x_to, 0, room_width - view_width);
	y_to = clamp(y_to, 0, room_height - view_height);
	
	//normalizing the shake effect
	if(global.shake_length != 0){
		x_to += random_range(global.shake_length, -global.shake_length);	
		y_to += random_range(global.shake_length, -global.shake_length);
		if(timer(global.shake_time)){
			global.shake_length = 0;
		}
	}
	
	//setting the camera
	var _cx = camera_get_view_x(view_camera[0])
	var _cy = camera_get_view_y(view_camera[0])
	
	_cx = lerp(_cx, x_to, 0.3);
	_cy = lerp(_cy, y_to, 0.3);
	
	camera_set_view_pos(view_camera[0], _cx, _cy);
}