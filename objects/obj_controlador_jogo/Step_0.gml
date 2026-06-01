// Verifica se a tecla F11 foi pressionada
if (keyboard_check_pressed(vk_f11)) {
    // Inverte o estado atual da tela cheia
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}

// Mantem o custo interno igual em janela e tela cheia.
if (surface_exists(application_surface) && (surface_get_width(application_surface) != 960 || surface_get_height(application_surface) != 540)) {
    surface_resize(application_surface, 960, 540);
}
