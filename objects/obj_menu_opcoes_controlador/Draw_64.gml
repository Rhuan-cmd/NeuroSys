var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var _cyan = make_color_rgb(92, 226, 255);
var _cyan_dark = make_color_rgb(34, 112, 150);
var _panel = make_color_rgb(7, 21, 36);
var _muted = make_color_rgb(146, 172, 198);
var _yellow = make_color_rgb(255, 232, 128);
var _green = make_color_rgb(112, 245, 185);
var _pulse = 0.5 + 0.5 * sin(menu_timer * 0.055);

function _grad_rect(_x1, _y1, _x2, _y2, _c1, _c2, _steps, _vertical) {
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
for (var _gx = _content_x + 18; _gx < gui_w; _gx += 24) draw_line(_gx, _top_h, _gx, gui_h);
for (var _gy = _top_h + 20; _gy < gui_h; _gy += 24) draw_line(_content_x, _gy, gui_w, _gy);
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
draw_text_transformed(_content_x + 24, 37, "painel do sistema // NeuroSys", 0.52, 0.52, 0);
draw_set_halign(fa_right);
draw_set_color(make_color_rgb(130, 206, 232));
draw_text_transformed(gui_w - 26, 37, "perfil ajustável", 0.52, 0.52, 0);
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
draw_set_alpha(0.78);
_grad_rect(18, 384, 242, 506, make_color_rgb(5, 23, 40), make_color_rgb(9, 47, 70), 12, true);
draw_set_alpha(1);
draw_set_color(_cyan_dark);
draw_rectangle(18, 384, 242, 506, true);
draw_set_color(_muted);
draw_text_ext_transformed(34, 404, "Ajustes aplicados no jogo inteiro. Use F11 em qualquer tela para alternar o modo de tela.", 16, 176, 0.50, 0.50, 0);

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
if (aba == 0) _descricao = "Escolha a qualidade visual geral. Ela controla densidade de efeitos, brilho e detalhes extras sem trocar a arte dos sprites.";
if (aba == 1) _descricao = "Ajuste o volume pela barra. O preset MUDO, BAIXO, MÉDIO ou ALTO se atualiza automaticamente conforme o valor.";
if (aba == 2) _descricao = "Selecione a resolução base. Ela também é aplicada antes de entrar em tela cheia.";
if (aba == 3) _descricao = "Alterne entre janela e tela cheia clicando nos botões ou usando F11.";
draw_text_ext_transformed(306, 160, _descricao, 18, 590, 0.56, 0.56, 0);

draw_set_alpha(0.86);
_grad_rect(282, 218, gui_w - 36, 374, make_color_rgb(4, 17, 31), make_color_rgb(8, 37, 57), 18, true);
draw_set_alpha(1);
draw_set_color(_cyan_dark);
draw_rectangle(282, 218, gui_w - 36, 374, true);

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
} else {
    _nomes = tela_opcoes;
    _sel = global.op_tela;
}

for (var _i = 0; _i < array_length(_nomes); _i += 1) {
    var _r = _card_rect(aba, _i);
    _option_card(_r[0], _r[1], _r[2], _r[3], _nomes[_i], _sel == _i, hover_item == _i);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(0.90);
_grad_rect(282, 394, gui_w - 36, 500, make_color_rgb(5, 21, 37), make_color_rgb(9, 44, 66), 14, false);
draw_set_alpha(1);
draw_set_color(_cyan_dark);
draw_roundrect(282, 394, gui_w - 36, 500, true);

if (aba == 1) {
    var _slider_x1 = 344;
    var _slider_x2 = 842;
    var _slider_y = 424;
    draw_set_color(c_white);
    draw_text_transformed(312, 412, "VOLUME GERAL", 0.56, 0.56, 0);
    draw_set_color(make_color_rgb(5, 18, 32));
    draw_rectangle(_slider_x1, _slider_y, _slider_x2, _slider_y + 10, false);
    draw_set_color(make_color_rgb(23, 86, 112));
    draw_rectangle(_slider_x1, _slider_y, _slider_x2, _slider_y + 10, true);
    draw_set_color(_cyan);
    draw_rectangle(_slider_x1, _slider_y, _slider_x1 + (_slider_x2 - _slider_x1) * global.op_volume, _slider_y + 10, false);
    draw_set_color(_yellow);
    draw_circle(_slider_x1 + (_slider_x2 - _slider_x1) * global.op_volume, _slider_y + 5, 10, false);
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text_transformed(gui_w - 70, 411, string(round(global.op_volume * 100)) + "%", 0.58, 0.58, 0);
    draw_set_halign(fa_left);
    draw_set_color(_muted);
    draw_text_ext_transformed(312, 452, "Arraste a barra para personalizar. O jogo escolhe o preset mais próximo sozinho.", 16, 560, 0.50, 0.50, 0);
} else if (aba == 0) {
    draw_set_color(_muted);
    draw_text_ext_transformed(312, 420, "BAIXO reduz efeitos globais. EQUILIBRADO mantém a proposta visual. ALTO libera a densidade máxima de efeitos.", 18, 590, 0.54, 0.54, 0);
} else if (aba == 2) {
    draw_set_color(_muted);
    draw_text_ext_transformed(312, 420, "A resolução escolhida é preparada mesmo quando a próxima troca for para tela cheia.", 18, 590, 0.54, 0.54, 0);
} else {
    draw_set_color(_muted);
    draw_text_ext_transformed(312, 420, "Modo atual: " + (window_get_fullscreen() ? "TELA CHEIA" : "JANELA") + ". F11 também alterna e os botões acompanham automaticamente.", 18, 590, 0.54, 0.54, 0);
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
