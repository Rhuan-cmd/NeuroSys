if (keyboard_check_pressed(vk_f3)) {
    global.perf_overlay_ativo = !global.perf_overlay_ativo;
    show_debug_overlay(global.perf_overlay_ativo);

    if (global.perf_overlay_ativo) {
        window_set_cursor(cr_default);
    } else {
        window_set_cursor(cr_none);
    }
}

if (global.fase_entrada_bloquear_cursor) {
    if ((room == rm_fase1 && instance_exists(obj_f1_controlador) && obj_f1_controlador.cutscene_timer >= obj_f1_controlador.fade_duracao)
    || (room == rm_fase2 && instance_exists(obj_f2_controlador) && obj_f2_controlador.cutscene_timer >= obj_f2_controlador.fade_duracao)
    || (room == rm_fase3 && instance_exists(obj_f3_controlador) && obj_f3_controlador.entrada_fade <= 0)
    || (room == rm_fase4 && instance_exists(obj_f4_dialogo) && obj_f4_dialogo.entrada_fade <= 0)) {
        global.fase_entrada_bloquear_cursor = false;
        global.transicao_ativa = false;
    }
}

if (global.transicao_ativa || global.fase_entrada_bloquear_cursor || instance_exists(obj_transicao)) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
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
