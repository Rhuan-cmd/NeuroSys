timer++;
fade_entrada = max(0, fade_entrada - 0.025);

if (encerrando) {
    fade_saida = min(1, fade_saida + 0.035);
    if (fade_saida >= 1) game_end();
}

if (timer > room_speed * 22 && (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left))) {
    encerrando = true;
}
