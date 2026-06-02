if (keyboard_check_pressed(vk_f10)) {
    global.perf_overlay_ativo = !global.perf_overlay_ativo;
    show_debug_overlay(global.perf_overlay_ativo);
}

global.perf_fullscreen_cooldown = max(0, global.perf_fullscreen_cooldown - 1);
if (keyboard_check_pressed(vk_f11) && global.perf_fullscreen_cooldown <= 0) {
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
        window_set_size(960, 540);
        window_center();
    } else {
        window_set_fullscreen(true);
    }

    display_set_gui_size(960, 540);
    if (surface_exists(application_surface)) application_surface_resize(960, 540);
    global.perf_fullscreen_cooldown = room_speed;
}

if (surface_exists(application_surface)) {
    if (surface_get_width(application_surface) != 960 || surface_get_height(application_surface) != 540) {
        application_surface_resize(960, 540);
    }
}
