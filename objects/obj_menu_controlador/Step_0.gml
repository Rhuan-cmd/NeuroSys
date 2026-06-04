entrada_bloqueada = max(0, entrada_bloqueada - 1);
menu_timer += 1;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var em_monitor = mx >= monitor_left && mx <= monitor_right && my >= monitor_top && my <= monitor_bottom;
monitor_hover = lerp(monitor_hover, em_monitor ? 1 : 0, 0.18);

if (menu_bg_layer != -1) {
    layer_x(menu_bg_layer, sin(menu_timer * 0.018) * 1.5);
    layer_y(menu_bg_layer, cos(menu_timer * 0.015) * 0.9);
}

if (clique_iniciado) {
    menu_saida_timer -= 1;

    if (menu_saida_timer <= 0) {
        audio_stop_sound(snd_menu_luz);
        audio_stop_sound(snd_menu_natureza);
        room_goto(rm_menu2);
    }

    exit;
}

if (!clique_iniciado && entrada_bloqueada <= 0) {
    if (em_monitor && mouse_check_button_pressed(mb_left)) {
        clique_iniciado = true;
        menu_saida_timer = round(room_speed * 0.45);
        audio_sound_gain(som_luz_id, 0, 650);
        audio_sound_gain(som_natureza_id, 0, 650);
        audio_play_sound(snd_menu_succao, 1, false);
    }
}
