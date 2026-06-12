var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var _cyan = make_color_rgb(92, 226, 255);
var _cyan_dark = make_color_rgb(34, 112, 150);
var _muted = make_color_rgb(146, 172, 198);
var _yellow = make_color_rgb(255, 232, 128);
var _green = make_color_rgb(112, 245, 185);
var _pulse = 0.5 + 0.5 * sin(menu_timer * 0.055);

function _grad_rect(_x1, _y1, _x2, _y2, _c1, _c2, _steps, _vertical) {
    _steps = max(1, min(_steps, 6));
    for (var _g = 0; _g < _steps; _g += 1) {
        var _t1 = _g / _steps;
        var _t2 = (_g + 1) / _steps;
        draw_set_color(merge_color(_c1, _c2, _t1));
        if (_vertical) {
            draw_rectangle(_x1, lerp(_y1, _y2, _t1), _x2, lerp(_y1, _y2, _t2) + 1, false);
        } else {
            draw_rectangle(lerp(_x1, _x2, _t1), _y1, lerp(_x1, _x2, _t2) + 1, _y2, false);
        }
    }
}

function _glitch_text(_x, _y, _txt, _sx, _sy, _main, _ativo) {
    if (_ativo) {
        draw_set_color(make_color_rgb(174, 54, 144));
        draw_text_transformed(_x - 1, _y, _txt, _sx, _sy, 0);
        draw_set_color(make_color_rgb(58, 215, 238));
        draw_text_transformed(_x + 1, _y + 1, _txt, _sx, _sy, 0);
    }
    draw_set_color(_main);
    draw_text_transformed(_x, _y, _txt, _sx, _sy, 0);
}

function _option_card(_x, _y, _w, _h, _txt, _ativo, _hover) {
    var _card_yellow = make_color_rgb(255, 232, 128);
    draw_set_alpha(_ativo ? 0.98 : 0.78);
    draw_set_color(_ativo ? make_color_rgb(12, 60, 86) : make_color_rgb(8, 30, 49));
    draw_roundrect(_x, _y, _x + _w, _y + _h, false);
    draw_set_alpha(_ativo ? 1 : (_hover ? 0.92 : 0.52));
    draw_set_color(_ativo ? make_color_rgb(118, 234, 255) : (_hover ? make_color_rgb(85, 198, 232) : make_color_rgb(39, 116, 154)));
    draw_roundrect(_x, _y, _x + _w, _y + _h, true);
    draw_set_alpha(_ativo ? 0.18 : (_hover ? 0.12 : 0.05));
    draw_set_color(c_white);
    draw_rectangle(_x + 5, _y + 5, _x + _w - 5, _y + 14, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    _glitch_text(_x + _w * 0.5, _y + _h * 0.5, _txt, 0.55, 0.55, _ativo ? _card_yellow : c_white, _ativo || _hover);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

function _reset_button(_x, _y, _w, _h, _txt, _hover, _danger) {
    draw_set_alpha(_hover ? 0.96 : 0.78);
    _grad_rect(_x, _y, _x + _w, _y + _h, _danger ? make_color_rgb(78, 24, 38) : make_color_rgb(8, 46, 68), make_color_rgb(5, 20, 34), 8, false);
    draw_set_alpha(1);
    draw_set_color(_hover ? (_danger ? make_color_rgb(255, 136, 154) : make_color_rgb(118, 234, 255)) : (_danger ? make_color_rgb(164, 70, 90) : make_color_rgb(39, 116, 154)));
    draw_roundrect(_x, _y, _x + _w, _y + _h, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    _glitch_text(_x + _w * 0.5, _y + _h * 0.5, _txt, 0.50, 0.50, _hover ? c_white : make_color_rgb(204, 225, 238), _hover);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

function _card_rect(_aba, _idx) {
    var _count = 3;
    if (_aba == 0) _count = array_length(grafico_opcoes);
    if (_aba == 1) _count = array_length(som_opcoes);
    if (_aba == 2) _count = array_length(res_opcoes);
    if (_aba == 3) _count = array_length(tela_opcoes);
    if (_aba == 4) _count = 6;

    if (_aba == 4) {
        var _row = _idx div 2;
        var _col = _idx mod 2;
        var _w_sis = 112;
        var _h_sis = 40;
        var _gap_sis = 20;
        var _x_sis = 642 + _col * (_w_sis + _gap_sis);
        var _y_sis = 250 + _row * 62;
        return [_x_sis, _y_sis, _w_sis, _h_sis];
    }

    var _w = 174;
    var _h = 54;
    var _gap = 22;
    var _area_x1 = 306;
    var _area_x2 = 900;
    var _y = 232;

    if (_aba == 1) {
        _w = 136;
    } else if (_aba == 2) {
        _w = 142;
        _gap = 14;
    } else if (_aba == 3) {
        _w = 230;
        _gap = 28;
    } else if (_aba == 4) {
        _w = 154;
        _gap = 14;
    }

    var _total_w = _count * _w + max(0, _count - 1) * _gap;
    var _x0 = _area_x1 + ((_area_x2 - _area_x1) - _total_w) * 0.5;
    var _x = _x0 + _idx * (_w + _gap);
    return [_x, _y, _w, _h];
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_stretched(spr_menu_opcoes_fundo, 0, 0, 0, gui_w, gui_h);

_grad_rect(0, 0, gui_w, gui_h, make_color_rgb(3, 10, 20), make_color_rgb(10, 42, 66), 28, true);
draw_set_alpha(0.42);
_grad_rect(0, 0, gui_w, gui_h, make_color_rgb(4, 25, 43), make_color_rgb(3, 9, 18), 24, false);
draw_set_alpha(1);

var _side_w = 260;
var _top_h = 78;
var _content_x = _side_w;

_grad_rect(0, 0, _side_w, gui_h, make_color_rgb(4, 18, 32), make_color_rgb(8, 37, 58), 18, false);
_grad_rect(_content_x, 0, gui_w, gui_h, make_color_rgb(4, 12, 24), make_color_rgb(8, 31, 51), 22, true);
_grad_rect(0, 0, gui_w, _top_h, make_color_rgb(8, 44, 69), make_color_rgb(4, 14, 27), 18, true);

draw_set_alpha(0.38);
draw_set_color(make_color_rgb(28, 111, 150));
for (var _gx = _content_x + 18; _gx < gui_w; _gx += 48) draw_line(_gx, _top_h, _gx, gui_h);
for (var _gy = _top_h + 20; _gy < gui_h; _gy += 48) draw_line(_content_x, _gy, gui_w, _gy);
draw_set_alpha(1);

draw_set_color(_cyan);
draw_rectangle(_side_w - 2, 0, _side_w + 2, gui_h, false);
draw_rectangle(0, _top_h - 2, gui_w, _top_h + 2, false);
draw_rectangle(0, 0, gui_w - 1, gui_h - 1, true);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

_glitch_text(24, 37, "CONFIGURAÇÕES", 0.74, 0.74, _cyan, true);
draw_set_color(make_color_rgb(137, 175, 202));
draw_text_transformed(_content_x + 24, 37, "PAINEL DE CONFIGURAÇÕES // NEUROSYS", 0.52, 0.52, 0);
draw_set_halign(fa_right);
draw_set_color(make_color_rgb(130, 206, 232));
draw_text_transformed(gui_w - 26, 37, "PERFIL AJUSTÁVEL", 0.52, 0.52, 0);
draw_set_halign(fa_left);

for (var _a = 0; _a < array_length(abas); _a += 1) {
    var _ay = 110 + _a * 62;
    var _ativo_aba = aba == _a;
    var _hover_aba = hover_aba == _a;
    draw_set_alpha(_ativo_aba ? 0.96 : (_hover_aba ? 0.82 : 0.54));
    _grad_rect(22, _ay, 236, _ay + 46, make_color_rgb(8, 52, 76), make_color_rgb(6, 26, 44), 10, false);
    draw_set_alpha(1);
    draw_set_color(_ativo_aba ? _cyan : (_hover_aba ? make_color_rgb(72, 190, 226) : _cyan_dark));
    draw_rectangle(22, _ay, 236, _ay + 46, true);
    if (_ativo_aba) {
        draw_set_color(_cyan);
        draw_rectangle(28, _ay + 8, 32, _ay + 38, false);
    }
    _glitch_text(46, _ay + 24, abas[_a], 0.56, 0.56, _ativo_aba ? _yellow : c_white, _ativo_aba || _hover_aba);
}

draw_set_valign(fa_top);
draw_set_alpha(0.93);
_grad_rect(282, 102, gui_w - 36, 204, make_color_rgb(7, 28, 46), make_color_rgb(10, 47, 70), 16, false);
draw_set_alpha(1);
draw_set_color(_cyan);
draw_rectangle(282, 102, gui_w - 36, 204, true);
draw_set_alpha(0.22 + _pulse * 0.16);
draw_set_color(c_white);
draw_rectangle(310, 112, gui_w - 64, 116, false);
draw_set_alpha(1);

_glitch_text(304, 122, abas[aba], 1.0, 1.0, _cyan, true);
draw_set_color(_muted);
var _descricao = "";
if (aba == 0) _descricao = "BAIXO corta efeitos pesados e transições.\nEQUILIBRADO reduz efeitos leves.\nALTO deixa tudo completo.";
if (aba == 1) _descricao = "Ajuste o volume geral, música e efeitos.\nO preset MUDO, BAIXO, MÉDIO ou ALTO acompanha o volume geral.";
if (aba == 2) _descricao = "Selecione a resolução base.\nEla também é aplicada antes de entrar em tela cheia.";
if (aba == 3) _descricao = "Alterne entre janela e tela cheia clicando nos botões ou usando F11.";
if (aba == 4) _descricao = "Controle avisos, dicas visuais e diálogos já vistos.\nEssas opções afetam intro, créditos e retry das fases.";
draw_text_ext_transformed(306, 158, _descricao, 12, 590, 0.56, 0.56, 0);

if (aba != 4) {
    draw_set_alpha(0.86);
    _grad_rect(282, 218, gui_w - 36, 302, make_color_rgb(4, 17, 31), make_color_rgb(8, 37, 57), 12, true);
    draw_set_alpha(1);
    draw_set_color(_cyan_dark);
    draw_rectangle(282, 218, gui_w - 36, 302, true);
}

var _nomes = [];
var _sel = 0;
if (aba == 0) {
    _nomes = grafico_opcoes;
    _sel = global.op_graficos;
} else if (aba == 1) {
    _nomes = som_opcoes;
    _sel = global.op_som_preset;
} else if (aba == 2) {
    _nomes = res_opcoes;
    _sel = global.op_resolucao;
} else if (aba == 3) {
    _nomes = tela_opcoes;
    _sel = global.op_tela;
} else {
    _nomes = ["SIM", "NÃO", "SIM", "NÃO", "SIM", "NÃO"];
    _sel = -1;
}

if (aba != 4) for (var _i = 0; _i < array_length(_nomes); _i += 1) {
    var _r = _card_rect(aba, _i);
    var _ativo_item = _sel == _i;
    _option_card(_r[0], _r[1], _r[2], _r[3], _nomes[_i], _ativo_item, hover_item == _i);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(0.90);
var _content_y1 = aba == 4 ? 218 : 318;
_grad_rect(282, _content_y1, gui_w - 36, 510, make_color_rgb(5, 21, 37), make_color_rgb(9, 44, 66), 18, false);
draw_set_alpha(1);
draw_set_color(_cyan_dark);
draw_roundrect(282, _content_y1, gui_w - 36, 510, true);

if (aba == 1) {
    var _slider_x1 = 470;
    var _slider_x2 = 842;
    var _slider_y0 = 338;
    var _labels = ["VOLUME GERAL", "MÚSICA", "EFEITOS"];
    var _values = [global.op_volume, global.op_volume_musica, global.op_volume_efeitos];
    for (var _s = 0; _s < 3; _s += 1) {
        var _slider_y = _slider_y0 + _s * 28;
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_text_transformed(312, _slider_y - 1, _labels[_s], 0.52, 0.52, 0);
        draw_set_color(make_color_rgb(5, 18, 32));
        draw_rectangle(_slider_x1, _slider_y, _slider_x2, _slider_y + 8, false);
        draw_set_color(make_color_rgb(23, 86, 112));
        draw_rectangle(_slider_x1, _slider_y, _slider_x2, _slider_y + 8, true);
        draw_set_color(_s == 0 ? _cyan : (_s == 1 ? _green : _yellow));
        draw_rectangle(_slider_x1, _slider_y, _slider_x1 + (_slider_x2 - _slider_x1) * _values[_s], _slider_y + 8, false);
        draw_circle(_slider_x1 + (_slider_x2 - _slider_x1) * _values[_s], _slider_y + 4, 8, false);
        draw_set_halign(fa_right);
        draw_set_color(c_white);
        draw_text_transformed(gui_w - 70, _slider_y - 2, string(round(_values[_s] * 100)) + "%", 0.52, 0.52, 0);
    }
    draw_set_halign(fa_left);
    draw_set_color(_muted);
    draw_text_transformed(312, 430, "O preset acompanha o VOLUME GERAL.", 0.46, 0.46, 0);
} else if (aba == 0) {
    draw_set_color(_cyan);
    draw_text_transformed(314, 330, "QUALIDADE ATUAL", 0.56, 0.56, 0);
    draw_set_color(_muted);
    draw_text_transformed(314, 358, "Efeitos globais", 0.50, 0.50, 0);
    var _bar_x = 470;
    var _bar_w = 350;
    draw_set_color(_cyan_dark);
    draw_rectangle(_bar_x, 362, _bar_x + _bar_w, 372, false);
    draw_set_color(_green);
    draw_rectangle(_bar_x, 362, _bar_x + _bar_w * ((global.op_graficos + 1) / 3), 372, false);
    draw_set_color(c_white);
    draw_text_transformed(836, 353, grafico_opcoes[global.op_graficos], 0.54, 0.54, 0);
    draw_set_color(_cyan);
    draw_text_transformed(314, 398, "PIXEL PERFECT", 0.48, 0.48, 0);
    draw_set_color(_muted);
    draw_text_ext_transformed(314, 418, "BAIXO desliga.\nMÉDIO preserva textos.\nALTO aplica na tela toda.", 10, 300, 0.40, 0.40, 0);
    var _pixel_sel = variable_global_exists("op_pixel_perfect_nivel") ? global.op_pixel_perfect_nivel : (global.op_pixel_perfect ? 1 : 0);
    for (var _px = 0; _px < 3; _px += 1) {
        _option_card(542 + _px * 128, 412, 112, 36, pixel_opcoes[_px], _pixel_sel == _px, hover_pixel == _px);
    }
} else if (aba == 2) {
    draw_set_color(_cyan);
    draw_text_transformed(314, 340, "RESOLUÇÃO ATIVA", 0.56, 0.56, 0);
    draw_set_color(c_white);
    draw_text_transformed(314, 372, res_opcoes[global.op_resolucao], 0.74, 0.74, 0);
    draw_set_color(_muted);
    draw_text_transformed(314, 406, window_get_fullscreen() ? "Modo de tela: tela cheia" : "Modo de tela: janela", 0.50, 0.50, 0);
} else if (aba == 3) {
    draw_set_color(_cyan);
    draw_text_transformed(314, 340, "MODO DE TELA", 0.56, 0.56, 0);
    draw_set_color(c_white);
    draw_text_transformed(314, 372, window_get_fullscreen() ? "TELA CHEIA" : "JANELA", 0.74, 0.74, 0);
    draw_set_color(_muted);
    draw_text_transformed(314, 406, "F11 alterna e os botões acompanham.", 0.50, 0.50, 0);
 } else {
    draw_set_color(_cyan);
    draw_text_transformed(314, 232, "SISTEMA VISUAL", 0.58, 0.58, 0);
    var _sis_desc = [
        "Mostra o aviso pequeno quando o jogo salva.",
        "Exibe cards de ajuda para pular intro, vídeo e créditos.",
        "Depois da primeira tentativa, pula diálogos/cutscenes da fase."
    ];
    for (var _sis = 0; _sis < 3; _sis += 1) {
        var _base_y = 250 + _sis * 62;
        draw_set_color(c_white);
        _glitch_text(314, _base_y + 4, sistema_linhas[_sis], 0.55, 0.55, c_white, false);
        draw_set_color(_muted);
        draw_text_ext_transformed(314, _base_y + 27, _sis_desc[_sis], 10, 306, 0.43, 0.43, 0);
        for (var _op = 0; _op < 2; _op += 1) {
            var _idx_sis = _sis * 2 + _op;
            var _r_sis = _card_rect(4, _idx_sis);
            var _valor_sis = _op == 0;
            var _ativo_sis = false;
            if (_sis == 0) _ativo_sis = global.op_mostrar_save_aviso == _valor_sis;
            if (_sis == 1) _ativo_sis = global.op_mostrar_cards_dicas == _valor_sis;
            if (_sis == 2) _ativo_sis = global.op_pular_dialogo_retry == _valor_sis;
            _option_card(_r_sis[0], _r_sis[1], _r_sis[2], _r_sis[3], _valor_sis ? "SIM" : "NÃO", _ativo_sis, hover_item == _idx_sis);
        }
    }
}

draw_set_alpha(0.28 + _pulse * 0.18);
draw_set_color(_cyan);
draw_line(312, 445, gui_w - 72, 445);
draw_set_alpha(1);
_reset_button(300, 456, 178, 38, "RESTAURAR ABA", hover_reset == 0, false);
_reset_button(492, 456, 178, 38, "RESTAURAR TUDO", hover_reset == 1, false);
_reset_button(684, 456, 178, 38, "RESETAR SAVE", hover_reset == 2, true);

if (reset_feedback_timer > 0) {
    var _fb_alpha = min(1, min(reset_feedback_timer / 18, (room_speed * 1.8 - reset_feedback_timer) / 12));
    draw_set_alpha(_fb_alpha);
    _grad_rect(gui_w - 292, 86, gui_w - 34, 126, make_color_rgb(8, 50, 68), make_color_rgb(3, 18, 32), 5, false);
    draw_set_color(make_color_rgb(98, 234, 255));
    draw_roundrect(gui_w - 292, 86, gui_w - 34, 126, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    _glitch_text(gui_w - 163, 106, reset_feedback_texto, 0.50, 0.50, c_white, true);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}

if (confirmar_reset != -1) {
    draw_set_alpha(0.62);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
    _grad_rect(298, 226, 712, 394, make_color_rgb(8, 35, 55), make_color_rgb(4, 13, 25), 6, true);
    draw_set_color(make_color_rgb(98, 234, 255));
    draw_roundrect(298, 226, 712, 394, true);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var _msg_reset = confirmar_reset == 0 ? "restaurar esta aba?" : (confirmar_reset == 1 ? "restaurar tudo?" : "resetar progresso?");
    _glitch_text(505, 266, "CONFIRMAR RESET", 0.72, 0.72, _cyan, true);
    draw_set_color(_muted);
    draw_text_ext_transformed(505, 298, "Tem certeza que deseja " + _msg_reset, 18, 330, 0.50, 0.50, 0);
    _option_card(386, 330, 110, 44, "SIM", false, hover_confirmar_reset == 0);
    _option_card(514, 330, 110, 44, "NÃO", false, hover_confirmar_reset == 1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

var _btn_drift = sin(menu_timer * 0.035) * 1.4;
draw_set_alpha(0.62);
draw_set_color(make_color_rgb(8, 18, 31));
draw_rectangle(voltar_x - 8, voltar_y + 38 + _btn_drift, voltar_x + 8, gui_h + 8, false);
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(24, 70, 96));
draw_rectangle(voltar_x - 3, voltar_y + 36 + _btn_drift, voltar_x + 3, gui_h + 8, false);
draw_set_alpha(0.8);
draw_set_color(make_color_rgb(112, 198, 228));
draw_rectangle(voltar_x - 6, voltar_y + 36 + _btn_drift, voltar_x + 6, voltar_y + 48 + _btn_drift, false);
draw_set_alpha(1);
var _voltar_scale_sprite = voltar_hover ? 1.66 : 1.58;
draw_sprite_ext(spr_menu_btn_voltar, voltar_hover ? 1 : 0, voltar_x, voltar_y + _btn_drift, _voltar_scale_sprite, _voltar_scale_sprite, 0, c_white, 1);

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

if (fade_entrada_branco > 0) {
    draw_set_alpha(fade_entrada_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
