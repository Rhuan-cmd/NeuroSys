menu_timer += 1;

if (keyboard_check_pressed(vk_left)) {
    volume_master = max(0, volume_master - 0.1);
    audio_master_gain(volume_master);
}

if (keyboard_check_pressed(vk_right)) {
    volume_master = min(1, volume_master + 0.1);
    audio_master_gain(volume_master);
}

if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right)) {
    global.menu_reverso = true;
    global.menu_destino_room = rm_menu;
    room_goto(rm_menu2);
}
