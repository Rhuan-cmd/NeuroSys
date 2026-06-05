menu_timer += 1;
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

if (voltando_menu) {
    fade_saida_branco = min(1, fade_saida_branco + 0.065);
    if (fade_saida_branco >= 1) {
        global.menu_reverso = true;
        global.menu_destino_room = rm_menu;
        room_goto(rm_menu2);
    }
    exit;
}

if (keyboard_check_pressed(vk_left)) {
    volume_master = max(0, volume_master - 0.1);
    audio_master_gain(volume_master);
}

if (keyboard_check_pressed(vk_right)) {
    volume_master = min(1, volume_master + 0.1);
    audio_master_gain(volume_master);
}

if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right)) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    voltando_menu = true;
}
