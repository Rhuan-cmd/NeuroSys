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
if (!variable_global_exists("easter_conecta_sprite")) global.easter_conecta_sprite = spr_easter_conecta;
if (!variable_global_exists("easter_conecta_timer")) global.easter_conecta_timer = 0;
if (!variable_global_exists("easter_conecta_dur")) global.easter_conecta_dur = room_speed * 5;
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
if (!variable_global_exists("op_pixel_perfect")) {
    global.op_pixel_perfect = true;
}
if (!variable_global_exists("op_auto_config_feita")) {
    global.op_auto_config_feita = false;
}
if (!variable_global_exists("op_resolucao")) {
    global.op_resolucao = 3;
}
if (!variable_global_exists("op_tela")) {
    global.op_tela = 1;
}
if (!variable_global_exists("op_mostrar_save_aviso")) {
    global.op_mostrar_save_aviso = true;
}
if (!variable_global_exists("op_mostrar_cards_dicas")) {
    global.op_mostrar_cards_dicas = true;
}
if (!variable_global_exists("op_pular_dialogo_retry")) {
    global.op_pular_dialogo_retry = false;
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
ns_audio_aplicar_opcoes();

var _save_res_idx = clamp(global.op_resolucao, 0, 3);
ns_video_aplicar(_save_res_idx, global.op_tela == 1);
window_center();
display_set_gui_size(960, 540);
if (surface_exists(application_surface)) surface_resize(application_surface, global.fx_surface_w, global.fx_surface_h);

save_prev_volume = global.op_volume;
save_prev_volume_musica = global.op_volume_musica;
save_prev_volume_efeitos = global.op_volume_efeitos;
save_prev_som_preset = global.op_som_preset;
save_prev_graficos = global.op_graficos;
save_prev_pixel_perfect = global.op_pixel_perfect;
save_prev_auto_config_feita = global.op_auto_config_feita;
save_prev_resolucao = global.op_resolucao;
save_prev_tela = global.op_tela;
save_prev_fase_liberada = global.fase_liberada;
save_prev_fase_concluida = global.fase_concluida;
save_prev_creditos_vistos = global.creditos_vistos;
save_prev_intro_vista = global.intro_vista;
save_prev_mostrar_save_aviso = global.op_mostrar_save_aviso;
save_prev_mostrar_cards_dicas = global.op_mostrar_cards_dicas;
save_prev_pular_dialogo_retry = global.op_pular_dialogo_retry;
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
pausa_botoes = ["Continuar", "Reiniciar", "Sair"];
pausa_saindo = 0;
pausa_fade = 0;
pausa_musica_id = -1;
auto_config_timer = 0;
auto_config_min_fps = 999;

menu_fade_alpha = 0;
if (room == rm_menu) {
    menu_fade_alpha = 1;
}
