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
if (!variable_global_exists("op_volume")) {
    global.op_volume = 1;
}
if (!variable_global_exists("op_volume_musica")) {
    global.op_volume_musica = 1;
}
if (!variable_global_exists("op_volume_efeitos")) {
    global.op_volume_efeitos = 1;
}
if (!variable_global_exists("op_som_preset")) {
    global.op_som_preset = 3;
}
if (!variable_global_exists("op_graficos")) {
    global.op_graficos = 2;
}
if (!variable_global_exists("op_resolucao")) {
    global.op_resolucao = 3;
}
if (!variable_global_exists("op_tela")) {
    global.op_tela = 1;
}
global.fx_qualidade = global.op_graficos;
global.fx_densidade = (global.op_graficos == 0) ? 0.16 : ((global.op_graficos == 1) ? 0.55 : 1);
global.fx_brilho = (global.op_graficos == 0) ? 0.16 : ((global.op_graficos == 1) ? 0.55 : 1);
global.fx_cortar_transicoes = global.op_graficos == 0;
global.fx_surface_w = 960;
global.fx_surface_h = 540;
if (!variable_global_exists("fase_liberada")) {
    global.fase_liberada = 1;
}
if (!variable_global_exists("fase_concluida")) {
    global.fase_concluida = 0;
}
save_init();
save_carregar();
audio_master_gain(global.op_volume);

var _save_res_w = [960, 1280, 1600, 1920];
var _save_res_h = [540, 720, 900, 1080];
var _save_res_idx = clamp(global.op_resolucao, 0, 3);
if (global.op_tela == 0) {
    window_set_fullscreen(false);
    window_set_size(_save_res_w[_save_res_idx], _save_res_h[_save_res_idx]);
    window_center();
} else {
    window_set_size(_save_res_w[_save_res_idx], _save_res_h[_save_res_idx]);
    window_center();
    window_set_fullscreen(true);
}
display_set_gui_size(960, 540);
if (surface_exists(application_surface)) surface_resize(application_surface, global.fx_surface_w, global.fx_surface_h);

save_prev_volume = global.op_volume;
save_prev_volume_musica = global.op_volume_musica;
save_prev_volume_efeitos = global.op_volume_efeitos;
save_prev_som_preset = global.op_som_preset;
save_prev_graficos = global.op_graficos;
save_prev_resolucao = global.op_resolucao;
save_prev_tela = global.op_tela;
save_prev_fase_liberada = global.fase_liberada;
save_prev_fase_concluida = global.fase_concluida;
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
