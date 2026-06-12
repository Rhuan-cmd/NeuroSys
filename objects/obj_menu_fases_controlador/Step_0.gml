menu_timer += 1;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _side_w = 282;
app_x = 0;
app_y = 0;
app_w = _gui_w;
app_h = _gui_h;
feed_x = _side_w + 22;
feed_w = max(520, _gui_w - feed_x - 20);
feed_top = 70;
feed_bottom = _gui_h - 2;
voltar_x = _side_w * 0.5;
voltar_y = _gui_h - 66;
voltar_w = 132;
voltar_h = 66;
feed_altura = array_length(fase_nome) * (post_h + post_gap) - post_gap;
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

if (negado_timer > 0) negado_timer -= 1;
if (neurosys_shake_timer > 0) neurosys_shake_timer -= 1;

if (retornando_fase) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    global.transicao_ativa = true;
    retorno_timer += 1;

    var _ret_p = clamp(retorno_timer / retorno_dur, 0, 1);
    var _ret_s = _ret_p * _ret_p * (3 - 2 * _ret_p);
    var _tempo_reverso = max(0, lerp(transicao_post_dur, 0, _ret_s));
    var _marca_reversa = -1;
    if (_tempo_reverso <= 167) _marca_reversa = 6;
    if (_tempo_reverso <= 143) _marca_reversa = 5;
    if (_tempo_reverso <= 107) _marca_reversa = 4;
    if (_tempo_reverso <= 83) _marca_reversa = 3;
    if (_tempo_reverso <= 47) _marca_reversa = 2;
    if (_tempo_reverso <= 23) _marca_reversa = 1;
    if (_marca_reversa != transicao_audio_marca) {
        transicao_audio_marca = _marca_reversa;
        if (_marca_reversa == 1 || _marca_reversa == 3 || _marca_reversa == 5) {
            ns_audio_play_sfx(snd_f2_aparecer, 4, false, 0.38, 0, 0.72);
        } else {
            ns_audio_play_sfx(snd_f2_tremor, 4, false, 0.30, 0, 0.58);
        }
    }

    if (retorno_timer >= retorno_dur) {
        retornando_fase = false;
        global.transicao_ativa = false;
        cursor_sprite = spr_ui_cursor;
    }
    exit;
}

if (entrando_fase) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    global.transicao_ativa = true;
    transicao_post_timer += 1;

    var _marca = -1;
    if (transicao_post_timer >= 1) _marca = 0;
    if (transicao_post_timer >= 23) _marca = 1;
    if (transicao_post_timer >= 47) _marca = 2;
    if (transicao_post_timer >= 83) _marca = 3;
    if (transicao_post_timer >= 107) _marca = 4;
    if (transicao_post_timer >= 143) _marca = 5;
    if (transicao_post_timer >= 167) _marca = 6;
    if (_marca != transicao_audio_marca) {
        transicao_audio_marca = _marca;
        if (_marca == 0) {
            ns_audio_play_sfx(snd_f2_sino, 4, false, 0.64, 0, 0.82);
        } else if (_marca == 2 || _marca == 4 || _marca == 6) {
            ns_audio_play_sfx(snd_f2_tremor, 4, false, 0.58, 0, 0.68 + _marca * 0.035);
        } else {
            ns_audio_play_sfx(snd_f2_aparecer, 4, false, 0.62, 0, 0.76 + _marca * 0.07);
        }
    }

    if (transicao_post_timer >= transicao_post_dur) {
        global.fase_entrada_bloquear_cursor = true;
        global.transicao_ativa = true;
        room_goto(fase_room[fase_escolhida]);
    }
    exit;
}

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

var _codigo_tecla = "";
for (var _codigo_k = ord("A"); _codigo_k <= ord("Z"); _codigo_k += 1) {
    if (keyboard_check_pressed(_codigo_k)) {
        _codigo_tecla = chr(_codigo_k);
        break;
    }
}

if (_codigo_tecla != "") {
    var _codigo_esperado = string_char_at(neurosys_codigo, neurosys_indice + 1);
    if (_codigo_tecla == _codigo_esperado) {
        neurosys_indice += 1;
        if (neurosys_indice >= string_length(neurosys_codigo)) {
            neurosys_indice = 0;
            global.fase_liberada = 4;
            global.fase_concluida = 4;
            global.creditos_vistos = true;
            neurosys_shake_timer = neurosys_shake_dur;
            save_marcar_sujo();
            ns_audio_play_sfx(snd_f2_tremor, 6, false, 1.0, 0, 0.68);
            ns_audio_play_sfx(snd_f2_explosao, 6, false, 0.82, 0, 0.92);
            ns_audio_play_sfx(snd_f2_confirmar, 6, false, 0.72, 0, 1.28);
        }
    } else {
        neurosys_indice = 0;
    }
}

var _max_scroll = max(0, feed_altura - (feed_bottom - feed_top));
if (mouse_wheel_down()) scroll_alvo = min(_max_scroll, scroll_alvo + 68);
if (mouse_wheel_up()) scroll_alvo = max(0, scroll_alvo - 68);
if (keyboard_check(vk_down)) scroll_alvo = min(_max_scroll, scroll_alvo + 8);
if (keyboard_check(vk_up)) scroll_alvo = max(0, scroll_alvo - 8);
scroll_y = lerp(scroll_y, scroll_alvo, 0.22);

hover = -1;
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;
voltar_hover = mx >= voltar_x - voltar_w * 0.5 && mx <= voltar_x + voltar_w * 0.5 && my >= voltar_y - voltar_h * 0.5 && my <= voltar_y + voltar_h * 0.5;

if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, app_x + 20, app_y + 14, app_x + 116, app_y + 48)) {
        conecta_cliques += 1;
        if (conecta_cliques >= 25) {
            conecta_cliques = 0;
            global.easter_conecta_sprite = spr_easter_conecta;
            global.easter_conecta_dur = room_speed * 4.2;
            global.easter_conecta_timer = global.easter_conecta_dur;
            ns_audio_play_sfx(snd_f2_tremor, 20, false, 6.0, 0, 0.52);
            ns_audio_play_sfx(snd_f2_explosao, 20, false, 5.2, 0, 0.64);
            ns_audio_play_sfx(snd_f3_dano, 20, false, 4.0, 0, 0.72);
        }
        exit;
    }

    var _sino_x = app_x + 135;
    var _sino_y = app_y + 31;
    if (point_in_rectangle(mx, my, _sino_x - 15, _sino_y - 15, _sino_x + 15, _sino_y + 15)) {
        if (_liberada >= 4 && sino_cliques >= 10) {
            global.fase_liberada = 1;
            sino_cliques = 0;
            ns_audio_play_sfx(snd_f2_tremor, 4, false, 0.54, 0, 0.72);
            exit;
        }
        sino_cliques += 1;
        if (sino_cliques >= 10) {
            sino_cliques = 10;
            global.fase_liberada = 4;
            ns_audio_play_sfx(snd_f2_ponto, 4, false, 0.58, 0, 1.34);
            ns_audio_play_sfx(snd_f2_confirmar, 4, false, 0.36, 0, 1.42);
        }
        exit;
    }
}

if (voltar_hover && !voltar_hover_anterior) {
    ns_audio_play_sfx(snd_f2_selecao, 3, false, 0.42, 0, 1);
}
voltar_hover_anterior = voltar_hover;

for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (mx >= feed_x && mx <= feed_x + feed_w && my >= max(_y + 4, feed_top) && my <= min(_y + post_h - 4, feed_bottom)) {
        hover = i;
        break;
    }
}

if (hover != hover_anterior && hover != -1) {
    ns_audio_play_sfx(snd_f2_selecao, 3, false, 0.42, 0, 1);
}
hover_anterior = hover;

if (hover != -1 && mouse_check_button_pressed(mb_left)) {
    if (hover + 1 <= _liberada) {
        ns_audio_play_sfx(snd_f2_botao, 4, false, 0.62, 0, 1);
        ns_audio_play_sfx(snd_f2_aparecer, 4, false, 0.48, 0, 0.82);
        audio_menu_fade(0, 1850);
        fase_escolhida = hover;
        var _card_y_trans = feed_top + hover * (post_h + post_gap) - scroll_y;
        transicao_alvo_x = feed_x + 18 + 53;
        transicao_alvo_y = clamp(_card_y_trans + 62 + 29, feed_top + 29, feed_bottom - 29);
        transicao_post_timer = 0;
        transicao_audio_marca = -1;
        negado_card = hover;
        negado_timer = 22;
        global.fase_entrada_bloquear_cursor = true;
        global.transicao_ativa = true;
        entrando_fase = true;
    } else {
        ns_audio_play_sfx(snd_f1_erro, 4, false, 0.72, 0, 0.86);
        negado_card = hover;
        negado_timer = 18;
    }
}

if (keyboard_check_pressed(vk_escape) || (voltar_hover && mouse_check_button_pressed(mb_left))) {
    ns_audio_play_sfx(snd_f2_botao, 4, false, 0.62, 0, 1);
    voltando_menu = true;
}
