if (room == rm_fase4) {
    cursor_sprite = cr_none;
} else {
    cursor_sprite = spr_ui_cursor;
}

window_set_cursor(cr_none);
gpu_set_texfilter(false);
show_debug_overlay(false);

display_set_gui_size(960, 540);
if (surface_exists(application_surface)) surface_resize(application_surface, 960, 540);

if (!window_get_fullscreen()) {
    window_set_fullscreen(true);
}

global.perf_overlay_ativo = false;
global.perf_fullscreen_cooldown = 0;
