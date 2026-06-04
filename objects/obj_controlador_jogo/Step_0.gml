if (keyboard_check_pressed(vk_f3)) {
    global.perf_overlay_ativo = !global.perf_overlay_ativo;
    show_debug_overlay(global.perf_overlay_ativo);

    if (global.perf_overlay_ativo) {
        window_set_cursor(cr_default);
    } else {
        window_set_cursor(cr_none);
    }
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
    if (surface_exists(application_surface)) surface_resize(application_surface, 960, 540);
    global.perf_fullscreen_cooldown = room_speed;
}

if (surface_exists(application_surface)) {
    if (surface_get_width(application_surface) != 960 || surface_get_height(application_surface) != 540) {
        surface_resize(application_surface, 960, 540);
    }
}

if (room == rm_menu && menu_fade_alpha > 0) {
    menu_fade_alpha = max(0, menu_fade_alpha - 1 / room_speed);
}
