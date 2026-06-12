var _room_fase = room == rm_fase1 || room == rm_fase2 || room == rm_fase3 || room == rm_fase4;
var _resultado_aberto = false;
if (room == rm_fase1 && instance_exists(obj_f1_controlador) && obj_f1_controlador.estado >= 3) _resultado_aberto = true;
if (room == rm_fase2 && instance_exists(obj_f2_controlador) && obj_f2_controlador.estado_final != 0) _resultado_aberto = true;
if (room == rm_fase3 && instance_exists(obj_f3_escudo) && obj_f3_escudo.resultado_ativo) _resultado_aberto = true;
if (room == rm_fase4 && instance_exists(obj_f4_fundo) && obj_f4_fundo.resultado_ativo) _resultado_aberto = true;

global.perf_fullscreen_cooldown = max(0, global.perf_fullscreen_cooldown - 1);
if (keyboard_check_pressed(vk_f11) && global.perf_fullscreen_cooldown <= 0) {
    var _res_idx = 0;
    if (variable_global_exists("op_resolucao")) _res_idx = clamp(global.op_resolucao, 0, 3);
    ns_video_aplicar(_res_idx, !window_get_fullscreen());
    global.perf_fullscreen_cooldown = room_speed;
}

if (_room_fase && !_resultado_aberto && !global.transicao_ativa && !global.fase_entrada_bloquear_cursor && !instance_exists(obj_transicao) && !global.jogo_pausado && keyboard_check_pressed(vk_escape)) {
    global.transicao_ativa = false;
    global.fase_entrada_bloquear_cursor = false;
    global.jogo_pausado = true;
    pausa_hover = -1;
    pausa_hover_anterior = -1;
    pausa_saindo = 0;
    pausa_fade = 0;
    audio_pause_all();
    pausa_musica_id = ns_audio_play_music(snd_menu_musica, 0, true, 0.34, 0, 0.92);
    instance_deactivate_all(true);
    window_set_cursor(cr_none);
    cursor_sprite = spr_ui_cursor;
    exit;
}

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

if (global.jogo_pausado) {
    window_set_cursor(cr_none);
    cursor_sprite = spr_ui_cursor;

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);
    var _panel_w = 360;
    var _panel_h = 270;
    var _panel_x = _gui_w * 0.5 - _panel_w * 0.5;
    var _panel_y = _gui_h * 0.5 - _panel_h * 0.5;
    var _btn_x1 = _panel_x + 70;
    var _btn_x2 = _panel_x + _panel_w - 70;
    var _btn_h = 40;
    pausa_hover = -1;

    for (var _p = 0; _p < 3; _p += 1) {
        var _by1 = _panel_y + 94 + _p * 56;
        if (point_in_rectangle(_mx, _my, _btn_x1, _by1, _btn_x2, _by1 + _btn_h)) {
            pausa_hover = _p;
        }
    }

    if (pausa_hover != -1 && pausa_hover != pausa_hover_anterior) {
        ns_audio_play_sfx(snd_f2_selecao, 3, false, 0.42, 0, 1);
    }
    pausa_hover_anterior = pausa_hover;

    if (pausa_saindo == 0 && mouse_check_button_pressed(mb_left) && pausa_hover != -1) {
        ns_audio_play_sfx(snd_f2_botao, 4, false, 0.62, 0, 1);
        if (pausa_hover == 0) {
            if (pausa_musica_id != -1) {
                audio_stop_sound(pausa_musica_id);
                pausa_musica_id = -1;
            }
            audio_resume_all();
            instance_activate_all();
            global.jogo_pausado = false;
            cursor_sprite = room == rm_fase3 ? spr_ui_cursor : cr_none;
        } else if (pausa_hover == 1) {
            pausa_saindo = 3;
        } else {
            pausa_saindo = 2;
        }
    }

    if (pausa_saindo == 0 && keyboard_check_pressed(vk_escape)) {
        if (pausa_musica_id != -1) {
            audio_stop_sound(pausa_musica_id);
            pausa_musica_id = -1;
        }
        audio_resume_all();
        instance_activate_all();
        global.jogo_pausado = false;
        cursor_sprite = room == rm_fase3 ? spr_ui_cursor : cr_none;
    }

    if (pausa_saindo != 0) {
        pausa_fade = min(1, pausa_fade + 0.065);
        if (pausa_fade >= 1) {
            if (pausa_musica_id != -1) {
                audio_stop_sound(pausa_musica_id);
                pausa_musica_id = -1;
            }
            audio_resume_all();
            instance_activate_all();
            global.jogo_pausado = false;
            if (pausa_saindo == 2) {
                if (room == rm_fase1) global.menu_fases_retorno_fase = 0;
                if (room == rm_fase2) global.menu_fases_retorno_fase = 1;
                if (room == rm_fase3) global.menu_fases_retorno_fase = 2;
                if (room == rm_fase4) global.menu_fases_retorno_fase = 3;
                room_goto(rm_menu_fases);
            } else if (pausa_saindo == 3) {
                global.retry_room = room;
                room_restart();
            }
        }
    }
    exit;
}

if (variable_global_exists("op_tela")) {
    global.op_tela = window_get_fullscreen() ? 1 : 0;
}

ns_audio_aplicar_opcoes();

if (variable_global_exists("op_graficos")) {
    global.fx_qualidade = clamp(global.op_graficos, 0, 2);
    global.fx_densidade = (global.fx_qualidade == 0) ? 0.16 : ((global.fx_qualidade == 1) ? 0.55 : 1);
    global.fx_brilho = (global.fx_qualidade == 0) ? 0.16 : ((global.fx_qualidade == 1) ? 0.55 : 1);
    global.fx_cortar_transicoes = global.fx_qualidade == 0;
    var _res_fx = variable_global_exists("op_resolucao") ? clamp(global.op_resolucao, 0, 3) : 3;
    var _pixel_nivel = variable_global_exists("op_pixel_perfect_nivel") ? clamp(global.op_pixel_perfect_nivel, 0, 2) : (variable_global_exists("op_pixel_perfect") && global.op_pixel_perfect ? 1 : 0);
    global.op_pixel_perfect = _pixel_nivel > 0;
    global.fx_pixel_perfect = _pixel_nivel > 0;
    global.fx_pixel_perfect_nivel = _pixel_nivel;
    // Mantem a surface base fixa para nao cortar GUI/dialogos; o nivel controla a filtragem visual.
    global.fx_surface_w = 960;
    global.fx_surface_h = 540;
    gpu_set_texfilter(_pixel_nivel <= 0);
    display_set_sleep_margin(global.fx_qualidade == 0 ? 4 : 10);
}

var _auto_config_pode_rodar = !variable_global_exists("auto_config_aguardar_reinicio") || !global.auto_config_aguardar_reinicio;
if (_auto_config_pode_rodar && variable_global_exists("op_auto_config_feita") && !global.op_auto_config_feita && room_speed > 0) {
    auto_config_timer++;
    auto_config_min_fps = min(auto_config_min_fps, fps_real);
    if (auto_config_timer >= room_speed * 4) {
        if (auto_config_min_fps < 45) {
            global.op_graficos = 0;
            global.op_resolucao = 0;
            global.op_pixel_perfect_nivel = 2;
            global.op_pixel_perfect = true;
        } else if (auto_config_min_fps < 56) {
            global.op_graficos = 1;
            global.op_resolucao = min(global.op_resolucao, 1);
            global.op_pixel_perfect_nivel = 1;
            global.op_pixel_perfect = true;
        } else {
            global.op_graficos = 2;
            global.op_pixel_perfect_nivel = 1;
            global.op_pixel_perfect = true;
        }
        global.op_auto_config_feita = true;
        ns_video_aplicar(global.op_resolucao, global.op_tela == 1);
        global.save_sujo = true;
    }
}

if (variable_global_exists("save_aviso_timer")) {
    global.save_aviso_timer = max(0, global.save_aviso_timer - 1);
}
if (variable_global_exists("easter_conecta_timer")) {
    global.easter_conecta_timer = max(0, global.easter_conecta_timer - 1);
}

global.save_timer += 1;
var _save_mudou = false;
_save_mudou = _save_mudou || save_prev_volume != global.op_volume;
_save_mudou = _save_mudou || save_prev_volume_musica != global.op_volume_musica;
_save_mudou = _save_mudou || save_prev_volume_efeitos != global.op_volume_efeitos;
_save_mudou = _save_mudou || save_prev_som_preset != global.op_som_preset;
_save_mudou = _save_mudou || save_prev_graficos != global.op_graficos;
_save_mudou = _save_mudou || save_prev_pixel_perfect != global.op_pixel_perfect;
_save_mudou = _save_mudou || save_prev_pixel_perfect_nivel != global.op_pixel_perfect_nivel;
_save_mudou = _save_mudou || save_prev_auto_config_feita != global.op_auto_config_feita;
_save_mudou = _save_mudou || save_prev_resolucao != global.op_resolucao;
_save_mudou = _save_mudou || save_prev_tela != global.op_tela;
_save_mudou = _save_mudou || save_prev_fase_liberada != global.fase_liberada;
_save_mudou = _save_mudou || save_prev_fase_concluida != global.fase_concluida;
_save_mudou = _save_mudou || save_prev_creditos_vistos != global.creditos_vistos;
_save_mudou = _save_mudou || save_prev_intro_vista != global.intro_vista;
_save_mudou = _save_mudou || save_prev_mostrar_save_aviso != global.op_mostrar_save_aviso;
_save_mudou = _save_mudou || save_prev_mostrar_cards_dicas != global.op_mostrar_cards_dicas;
_save_mudou = _save_mudou || save_prev_pular_dialogo_retry != global.op_pular_dialogo_retry;

if (_save_mudou || global.save_timer >= room_speed * 60 || global.save_sujo) {
    save_escrever();
    global.save_timer = 0;
    save_prev_volume = global.op_volume;
    save_prev_volume_musica = global.op_volume_musica;
    save_prev_volume_efeitos = global.op_volume_efeitos;
    save_prev_som_preset = global.op_som_preset;
    save_prev_graficos = global.op_graficos;
    save_prev_pixel_perfect = global.op_pixel_perfect;
    save_prev_pixel_perfect_nivel = global.op_pixel_perfect_nivel;
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
}

if (surface_exists(application_surface)) {
    var _surface_w = variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960;
    var _surface_h = variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540;
    if (surface_get_width(application_surface) != _surface_w || surface_get_height(application_surface) != _surface_h) {
        surface_resize(application_surface, _surface_w, _surface_h);
    }
}

if (room == rm_menu && menu_fade_alpha > 0) {
    menu_fade_alpha = max(0, menu_fade_alpha - 1 / room_speed);
}
