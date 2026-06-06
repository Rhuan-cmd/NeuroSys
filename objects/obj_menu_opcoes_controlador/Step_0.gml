menu_timer += 1;
anim_brilho = 0.5 + 0.5 * sin(menu_timer * 0.045);
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

function _volume_para_preset(_v) {
    if (_v <= 0.04) return 0;
    if (_v < 0.50) return 1;
    if (_v < 0.82) return 2;
    return 3;
}

function _rearmar_cursor_opcoes() {
    window_set_cursor(cr_none);
    cursor_sprite = spr_ui_cursor;
}

function _aplicar_resolucao(_idx) {
    var _was_full = window_get_fullscreen();
    window_set_size(res_w[_idx], res_h[_idx]);
    window_center();
    if (_was_full) window_set_fullscreen(true);

    display_set_gui_size(960, 540);
    if (surface_exists(application_surface)) surface_resize(application_surface, variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960, variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540);
    _rearmar_cursor_opcoes();
}

function _aplicar_mix_audio() {
    audio_aplicar_opcoes();
    if (variable_global_exists("audio_menu_musica") && global.audio_menu_musica != -1 && audio_is_playing(global.audio_menu_musica)) {
        audio_gain_music(global.audio_menu_musica, 0.36, 120);
    }
}

function _restaurar_aba_atual() {
    switch (aba) {
        case 0:
            global.op_graficos = 2;
            break;
        case 1:
            global.op_volume = 1;
            global.op_volume_musica = 1;
            global.op_volume_efeitos = 1;
            global.op_som_preset = 3;
            _aplicar_mix_audio();
            break;
        case 2:
            global.op_resolucao = 3;
            _aplicar_resolucao(3);
            break;
        case 3:
            global.op_tela = 1;
            window_set_size(res_w[global.op_resolucao], res_h[global.op_resolucao]);
            window_center();
            window_set_fullscreen(true);
            display_set_gui_size(960, 540);
            if (surface_exists(application_surface)) surface_resize(application_surface, variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960, variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540);
            _rearmar_cursor_opcoes();
            break;
    }
}

function _restaurar_tudo() {
    global.op_graficos = 2;
    global.op_volume = 1;
    global.op_volume_musica = 1;
    global.op_volume_efeitos = 1;
    global.op_som_preset = 3;
    global.op_resolucao = 3;
    global.op_tela = 1;
    _aplicar_resolucao(3);
    window_set_fullscreen(true);
    _rearmar_cursor_opcoes();
    _aplicar_mix_audio();
}

function _resetar_save_progresso() {
    save_resetar_progresso();
}

function _fx_gain(_v) {
    return _v;
}

function _card_rect(_aba, _idx) {
    var _count = 3;
    if (_aba == 0) _count = array_length(grafico_opcoes);
    if (_aba == 1) _count = array_length(som_opcoes);
    if (_aba == 2) _count = array_length(res_opcoes);
    if (_aba == 3) _count = array_length(tela_opcoes);

    var _cols = _count;
    var _w = 174;
    var _h = 54;
    var _gap = 22;
    var _area_x1 = 306;
    var _area_x2 = 900;
    var _y0 = 232;

    if (_aba == 1) {
        _w = 136;
    } else if (_aba == 2) {
        _w = 142;
        _gap = 14;
    } else if (_aba == 3) {
        _w = 230;
        _gap = 28;
    }

    var _total_w = _count * _w + max(0, _count - 1) * _gap;
    var _x0 = _area_x1 + ((_area_x2 - _area_x1) - _total_w) * 0.5;
    var _x = _x0 + (_idx mod _cols) * (_w + _gap);
    var _y = _y0 + floor(_idx / _cols) * 76;
    return [_x, _y, _w, _h];
}

var _gui_h = display_get_gui_height();
voltar_x = 126;
voltar_y = _gui_h - 62;

global.op_tela = window_get_fullscreen() ? 1 : 0;
global.op_som_preset = _volume_para_preset(global.op_volume);

if (voltando_menu) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    fade_saida_branco = min(1, fade_saida_branco + 0.065);
    if (fade_saida_branco >= 1) {
        global.menu_reverso = true;
        global.menu_destino_room = rm_menu;
        room_goto(rm_menu2);
    }
    exit;
}

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

voltar_hover = point_in_rectangle(_mx, _my, voltar_x - voltar_w * 0.5, voltar_y - voltar_h * 0.5, voltar_x + voltar_w * 0.5, voltar_y + voltar_h * 0.5);
if (voltar_hover && !voltar_hover_anterior) audio_play_sfx(snd_f2_selecao, 3, false, _fx_gain(0.42), 0, 1);
voltar_hover_anterior = voltar_hover;

hover_aba = -1;
for (var _a = 0; _a < array_length(abas); _a += 1) {
    var _ay = 110 + _a * 62;
    if (point_in_rectangle(_mx, _my, 22, _ay, 236, _ay + 46)) {
        hover_aba = _a;
    }
}
if (hover_aba != -1 && hover_aba != hover_aba_anterior) audio_play_sfx(snd_f2_selecao, 3, false, _fx_gain(0.42), 0, 1);
hover_aba_anterior = hover_aba;

hover_item = -1;
var _count = 0;
if (aba == 0) _count = array_length(grafico_opcoes);
if (aba == 1) _count = array_length(som_opcoes);
if (aba == 2) _count = array_length(res_opcoes);
if (aba == 3) _count = array_length(tela_opcoes);
for (var _i = 0; _i < _count; _i += 1) {
    var _r = _card_rect(aba, _i);
    if (point_in_rectangle(_mx, _my, _r[0], _r[1], _r[0] + _r[2], _r[1] + _r[3])) {
        hover_item = _i;
    }
}
if (hover_item != -1 && hover_item != hover_item_anterior) audio_play_sfx(snd_f2_selecao, 3, false, _fx_gain(0.42), 0, 1);
hover_item_anterior = hover_item;

hover_reset = -1;
if (point_in_rectangle(_mx, _my, 300, 456, 478, 494)) hover_reset = 0;
if (point_in_rectangle(_mx, _my, 492, 456, 670, 494)) hover_reset = 1;
if (point_in_rectangle(_mx, _my, 684, 456, 862, 494)) hover_reset = 2;
if (hover_reset != -1 && hover_reset != hover_reset_anterior) audio_play_sfx(snd_f2_selecao, 3, false, _fx_gain(0.42), 0, 1);
hover_reset_anterior = hover_reset;

var _slider_x1 = 470;
var _slider_x2 = 842;
var _slider_y0 = 338;
var _slider_hover = -1;
if (aba == 1) {
    for (var _s = 0; _s < 3; _s += 1) {
        var _sy = _slider_y0 + _s * 28;
        if (point_in_rectangle(_mx, _my, _slider_x1 - 14, _sy - 12, _slider_x2 + 14, _sy + 18)) {
            _slider_hover = _s;
        }
    }
}
if (mouse_check_button_pressed(mb_left) && _slider_hover != -1) arrastando_audio = _slider_hover;
if (!mouse_check_button(mb_left)) arrastando_audio = -1;
if (arrastando_audio != -1) {
    var _valor_audio = clamp((_mx - _slider_x1) / (_slider_x2 - _slider_x1), 0, 1);
    if (arrastando_audio == 0) {
        global.op_volume = _valor_audio;
        global.op_volume_musica = _valor_audio;
        global.op_volume_efeitos = _valor_audio;
        global.op_som_preset = _volume_para_preset(global.op_volume);
    } else if (arrastando_audio == 1) {
        global.op_volume_musica = _valor_audio;
        if (_valor_audio > 0 && global.op_volume <= 0) global.op_volume = _valor_audio;
    } else {
        global.op_volume_efeitos = _valor_audio;
        if (_valor_audio > 0 && global.op_volume <= 0) global.op_volume = _valor_audio;
    }
    _aplicar_mix_audio();
}

if (mouse_check_button_pressed(mb_left)) {
    if (voltar_hover) {
        audio_play_sfx(snd_f2_botao, 4, false, _fx_gain(0.62), 0, 1);
        voltando_menu = true;
        exit;
    }
    if (hover_aba != -1) {
        aba = hover_aba;
        audio_play_sfx(snd_f2_botao, 4, false, _fx_gain(0.58), 0, 1);
        exit;
    }
    if (hover_item != -1) {
        audio_play_sfx(snd_f2_botao, 4, false, _fx_gain(0.58), 0, 1);
        switch (aba) {
            case 0:
                global.op_graficos = hover_item;
                break;
            case 1:
                global.op_som_preset = hover_item;
                global.op_volume = som_valores[hover_item];
                global.op_volume_musica = global.op_volume;
                global.op_volume_efeitos = global.op_volume;
                _aplicar_mix_audio();
                break;
            case 2:
                global.op_resolucao = hover_item;
                _aplicar_resolucao(hover_item);
                break;
            case 3:
                global.op_tela = hover_item;
                if (hover_item == 0) {
                    window_set_fullscreen(false);
                    window_set_size(res_w[global.op_resolucao], res_h[global.op_resolucao]);
                    window_center();
                } else {
                    window_set_size(res_w[global.op_resolucao], res_h[global.op_resolucao]);
                    window_center();
                    window_set_fullscreen(true);
                }
                display_set_gui_size(960, 540);
                if (surface_exists(application_surface)) surface_resize(application_surface, variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960, variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540);
                break;
        }
    }
    if (hover_reset != -1) {
        audio_play_sfx(snd_f2_botao, 4, false, _fx_gain(0.58), 0, 1);
        if (hover_reset == 0) {
            _restaurar_aba_atual();
        } else if (hover_reset == 1) {
            _restaurar_tudo();
        } else {
            _resetar_save_progresso();
        }
    }
}

if (keyboard_check_pressed(vk_escape)) {
    audio_play_sfx(snd_f2_botao, 4, false, _fx_gain(0.62), 0, 1);
    voltando_menu = true;
}
