menu_timer += 1;
anim_brilho = 0.5 + 0.5 * sin(menu_timer * 0.045);
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

var _gui_h = display_get_gui_height();
voltar_x = 141;
voltar_y = _gui_h - 66;

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
    var _ay = 112 + _a * 60;
    if (point_in_rectangle(_mx, _my, 22, _ay, 230, _ay + 42)) {
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
    var _x1 = 326 + (_i mod 3) * 178;
    var _y1 = 236 + floor(_i / 3) * 78;
    if (point_in_rectangle(_mx, _my, _x1, _y1, _x1 + 158, _y1 + 48)) {
        hover_item = _i;
    }
}
if (hover_item != -1 && hover_item != hover_item_anterior) audio_play_sound(snd_f2_selecao, 3, false, 0.42);
hover_item_anterior = hover_item;

var _slider_x1 = 382;
var _slider_x2 = 790;
var _slider_y = 432;
var _slider_hover = aba == 1 && global.op_som_preset == 4 && point_in_rectangle(_mx, _my, _slider_x1 - 10, _slider_y - 18, _slider_x2 + 10, _slider_y + 18);
if (mouse_check_button_pressed(mb_left) && _slider_hover) arrastando_volume = true;
if (!mouse_check_button(mb_left)) arrastando_volume = false;
if (arrastando_volume) {
    global.op_volume = clamp((_mx - _slider_x1) / (_slider_x2 - _slider_x1), 0, 1);
    global.op_som_preset = 4;
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
                if (hover_item < 4) {
                    global.op_volume = som_valores[hover_item];
                    audio_master_gain(global.op_volume);
                }
                break;
            case 2:
                global.op_resolucao = hover_item;
                if (!window_get_fullscreen()) {
                    window_set_size(res_w[hover_item], res_h[hover_item]);
                    window_center();
                }
                break;
            case 3:
                global.op_tela = hover_item;
                if (hover_item == 0) {
                    window_set_fullscreen(false);
                    window_set_size(res_w[global.op_resolucao], res_h[global.op_resolucao]);
                    window_center();
                } else {
                    window_set_fullscreen(true);
                }
                break;
        }
    }
}

if (keyboard_check_pressed(vk_escape)) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    voltando_menu = true;
}
