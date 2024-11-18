if keyboard_check_pressed(vk_tab) global.debug = !global.debug

if keyboard_check(vk_down) obj_player.hp--

spawn_enemies()
calc_prices()

show_debug_message(instance_number(obj_enemy_par))