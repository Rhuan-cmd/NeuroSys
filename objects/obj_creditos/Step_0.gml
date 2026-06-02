timer++;
fade_entrada = max(0, fade_entrada - 0.025);

if (!etapa_final) {
    var _scroll = max(0, timer - creditos_inicio) * rolagem_velocidade;
    if (_scroll > creditos_altura + display_get_gui_height() + 80) {
        etapa_final = true;
        timer_final = 0;
    }
} else {
    timer_final++;
    if (timer_final > room_speed * 3 && (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left))) {
        encerrando = true;
    }
    if (timer_final > room_speed * 7) encerrando = true;
}

if (encerrando) {
    fade_saida = min(1, fade_saida + 0.022);
    if (fade_saida >= 1) game_end();
}
