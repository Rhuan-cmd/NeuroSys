menu_timer += 1;

if (voltando_menu) {
    fade_saida_branco = min(1, fade_saida_branco + 0.065);
    if (fade_saida_branco >= 1) {
        global.menu_reverso = true;
        global.menu_destino_room = rm_menu;
        room_goto(rm_menu2);
    }
    exit;
}

hover = -1;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(fase_nome); i += 1) {
    if (mx >= fase_x - 150 && mx <= fase_x + 150 && my >= fase_y[i] - 26 && my <= fase_y[i] + 26) {
        hover = i;
        break;
    }
}

if (hover != hover_anterior && hover != -1) {
    audio_play_sound(snd_f2_selecao, 3, false, 0.42);
}
hover_anterior = hover;

if (hover != -1 && mouse_check_button_pressed(mb_left)) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    room_goto(fase_room[hover]);
}

if (keyboard_check_pressed(vk_escape)) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    voltando_menu = true;
}
