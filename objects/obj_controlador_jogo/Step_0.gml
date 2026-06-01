// Verifica se a tecla F11 foi pressionada
if (keyboard_check_pressed(vk_f11)) {
    // Inverte o estado atual da tela cheia
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}