timer++;
fade_entrada = max(0, fade_entrada - 1 / (room_speed * 2));

if (!etapa_final) {
    if (timer > creditos_inicio) {
        creditos_scroll += rolagem_velocidade * (keyboard_check(vk_enter) ? 3.6 : 1);
    }
    if (creditos_scroll > creditos_altura + display_get_gui_height() + 80) {
        etapa_final = true;
        timer_final = 0;
    }
} else {
    timer_final++;
    if (timer_final > room_speed * 7) encerrando = true;
}

if (encerrando) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    fade_saida = min(1, fade_saida + 0.022);
    if (fade_saida >= 1) {
        global.menu_reverso = true;
        global.menu_destino_room = rm_menu;
        room_goto(rm_menu2);
    }
}
