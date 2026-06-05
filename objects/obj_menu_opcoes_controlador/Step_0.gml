menu_timer += 1;
anim_brilho = 0.5 + 0.5 * sin(menu_timer * 0.045);
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

function _volume_para_preset(_v) {
    if (_v <= 0.04) return 0;
    if (_v < 0.50) return 1;
    if (_v < 0.82) return 2;
    return 3;
}

function _aplicar_resolucao(_idx) {
    var _was_full = window_get_fullscreen();
    if (_was_full) window_set_fullscreen(false);
    window_set_size(res_w[_idx], res_h[_idx]);
    window_center();
    if (_was_full) window_set_fullscreen(true);

    display_set_gui_size(960, 540);
    if (surface_exists(application_surface)) surface_resize(application_surface, 960, 540);
}

function _card_rect(_aba, _idx) {
    var _cols = 3;
    var _w = 174;
    var _h = 54;
    var _gap = 20;
    var _x0 = 306;
    var _y0 = 226;

    if (_aba == 1) {
        _cols = 4;
        _w = 136;
        _gap = 16;
    } else if (_aba == 2) {
        _cols = 2;
        _w = 258;
        _gap = 24;
    } else if (_aba == 3) {
        _cols = 2;
        _w = 230;
        _gap = 24;
    }

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
if (voltar_hover && !voltar_hover_anterior) audio_play_sound(snd_f2_selecao, 3, false, 0.42);
voltar_hover_anterior = voltar_hover;

hover_aba = -1;
for (var _a = 0; _a < array_length(abas); _a += 1) {
    var _ay = 110 + _a * 62;
    if (point_in_rectangle(_mx, _my, 22, _ay, 236, _ay + 46)) {
        hover_aba = _a;
    }
}
if (hover_aba != -1 && hover_aba != hover_aba_anterior) audio_play_sound(snd_f2_selecao, 3, false, 0.42);
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
if (hover_item != -1 && hover_item != hover_item_anterior) audio_play_sound(snd_f2_selecao, 3, false, 0.42);
hover_item_anterior = hover_item;

var _slider_x1 = 344;
var _slider_x2 = 842;
var _slider_y = 424;
var _slider_hover = aba == 1 && point_in_rectangle(_mx, _my, _slider_x1 - 14, _slider_y - 22, _slider_x2 + 14, _slider_y + 24);
if (mouse_check_button_pressed(mb_left) && _slider_hover) arrastando_volume = true;
if (!mouse_check_button(mb_left)) arrastando_volume = false;
if (arrastando_volume) {
    global.op_volume = clamp((_mx - _slider_x1) / (_slider_x2 - _slider_x1), 0, 1);
    global.op_som_preset = _volume_para_preset(global.op_volume);
    audio_master_gain(global.op_volume);
}

if (mouse_check_button_pressed(mb_left)) {
    if (voltar_hover) {
        audio_play_sound(snd_f2_botao, 4, false, 0.62);
        voltando_menu = true;
        exit;
    }
    if (hover_aba != -1) {
        aba = hover_aba;
        audio_play_sound(snd_f2_botao, 4, false, 0.58);
        exit;
    }
    if (hover_item != -1) {
        audio_play_sound(snd_f2_botao, 4, false, 0.58);
        switch (aba) {
            case 0:
                global.op_graficos = hover_item;
                break;
            case 1:
                global.op_som_preset = hover_item;
                global.op_volume = som_valores[hover_item];
                audio_master_gain(global.op_volume);
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
                if (surface_exists(application_surface)) surface_resize(application_surface, 960, 540);
                break;
        }
    }
}

if (keyboard_check_pressed(vk_escape)) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    voltando_menu = true;
}
