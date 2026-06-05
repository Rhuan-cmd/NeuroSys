if (room == rm_fase4) {
    cursor_sprite = cr_none;
} else {
    cursor_sprite = spr_ui_cursor;
}

window_set_cursor(cr_none);
gpu_set_texfilter(false);
show_debug_overlay(false);

game_set_speed(60, gamespeed_fps);
display_set_timing_method(tm_sleep);
display_set_sleep_margin(10);

display_set_gui_size(960, 540);
if (surface_exists(application_surface)) surface_resize(application_surface, 960, 540);

global.perf_overlay_ativo = false;
global.perf_fullscreen_cooldown = 0;
if (!variable_global_exists("fase_liberada")) {
    global.fase_liberada = 1;
}
if (!variable_global_exists("fase_entrada_bloquear_cursor")) {
    global.fase_entrada_bloquear_cursor = false;
}
if (!variable_global_exists("jogo_pausado")) {
    global.jogo_pausado = false;
}
global.jogo_pausado = false;
global.transicao_ativa = global.fase_entrada_bloquear_cursor;

pausa_hover = -1;
pausa_hover_anterior = -1;
pausa_botoes = ["Retomar", "Menu", "Reiniciar"];
pausa_saindo = 0;
pausa_fade = 0;
pausa_musica_id = -1;

menu_fade_alpha = 0;
if (room == rm_menu) {
    menu_fade_alpha = 1;
}
