var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var _cyan = make_color_rgb(92, 226, 255);
var _cyan_dark = make_color_rgb(34, 112, 150);
var _panel = make_color_rgb(7, 21, 36);
var _muted = make_color_rgb(146, 172, 198);
var _yellow = make_color_rgb(255, 232, 128);
var _green = make_color_rgb(112, 245, 185);
var _pulse = 0.5 + 0.5 * sin(menu_timer * 0.055);

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
    draw_set_color(_ativo ? make_color_rgb(12, 55, 78) : make_color_rgb(8, 28, 46));
    draw_roundrect(_x, _y, _x + _w, _y + _h, false);
    draw_set_alpha(_ativo ? 1 : (_hover ? 0.92 : 0.52));
    draw_set_color(_ativo ? make_color_rgb(118, 234, 255) : (_hover ? make_color_rgb(85, 198, 232) : make_color_rgb(39, 116, 154)));
    draw_roundrect(_x, _y, _x + _w, _y + _h, true);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    _glitch_text(_x + _w * 0.5, _y + _h * 0.5, _txt, 0.58, 0.58, _ativo ? _card_yellow : c_white, _ativo || _hover);
    draw_set_halign(fa_left);
}

draw_set_alpha(1);
draw_sprite_stretched(spr_menu_opcoes_fundo, 0, 0, 0, gui_w, gui_h);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

_glitch_text(28, 36, "CONFIGURAÇÕES", 0.78, 0.78, _cyan, true);
draw_set_color(make_color_rgb(137, 175, 202));
draw_text_transformed(238, 36, "painel do sistema // NeuroSys", 0.52, 0.52, 0);
draw_set_halign(fa_right);
draw_set_color(make_color_rgb(130, 206, 232));
draw_text_transformed(gui_w - 34, 36, "perfil customizável", 0.52, 0.52, 0);
draw_set_halign(fa_left);

for (var _a = 0; _a < array_length(abas); _a += 1) {
    var _ay = 112 + _a * 60;
    var _ativo_aba = aba == _a;
    var _hover_aba = hover_aba == _a;
    draw_set_alpha(_ativo_aba ? 0.95 : (_hover_aba ? 0.82 : 0.42));
    draw_set_color(_ativo_aba ? make_color_rgb(10, 55, 80) : make_color_rgb(8, 31, 49));
    draw_rectangle(22, _ay, 230, _ay + 42, false);
    draw_set_alpha(1);
    draw_set_color(_ativo_aba ? _cyan : _cyan_dark);
    draw_rectangle(22, _ay, 230, _ay + 42, true);
    if (_ativo_aba) {
        draw_set_color(_cyan);
        draw_rectangle(28, _ay + 8, 32, _ay + 34, false);
    }
    _glitch_text(46, _ay + 22, abas[_a], 0.56, 0.56, _ativo_aba ? _yellow : c_white, _ativo_aba || _hover_aba);
}

draw_set_valign(fa_top);
_glitch_text(304, 118, abas[aba], 1.0, 1.0, _cyan, true);
draw_set_color(_muted);
var _descricao = "";
if (aba == 0) _descricao = "Escolha uma qualidade visual. Afeta efeitos e densidade visual, sem trocar a arte dos sprites.";
if (aba == 1) _descricao = "Controle o volume geral com predefinições ou ajuste fino no modo CUSTOMIZADO.";
if (aba == 2) _descricao = "Selecione uma resolução base para a janela do jogo.";
if (aba == 3) _descricao = "Alterne entre janela e tela cheia com um clique.";
draw_text_ext_transformed(306, 158, _descricao, 18, 570, 0.58, 0.58, 0);

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
    var _x = 326 + (_i mod 3) * 178;
    var _y = 236 + floor(_i / 3) * 78;
    _option_card(_x, _y, 158, 48, _nomes[_i], _sel == _i, hover_item == _i);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(0.88);
draw_set_color(make_color_rgb(8, 28, 46));
draw_roundrect(326, 414, 864, 470, false);
draw_set_alpha(0.48 + _pulse * 0.16);
draw_set_color(_cyan_dark);
draw_roundrect(326, 414, 864, 470, true);
draw_set_alpha(1);

if (aba == 1) {
    draw_set_color(c_white);
    draw_text_transformed(350, 431, "VOLUME", 0.56, 0.56, 0);
    draw_set_color(make_color_rgb(11, 42, 62));
    draw_rectangle(382, 432, 790, 440, false);
    draw_set_color(_cyan);
    draw_rectangle(382, 432, 382 + 408 * global.op_volume, 440, false);
    draw_set_color(_yellow);
    draw_circle(382 + 408 * global.op_volume, 436, 9, false);
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text_transformed(838, 431, string(round(global.op_volume * 100)) + "%", 0.56, 0.56, 0);
    draw_set_halign(fa_left);
} else if (aba == 0) {
    draw_set_color(_muted);
    draw_text_ext_transformed(350, 428, "BAIXO reduz efeitos. EQUILIBRADO mantém o visual padrão. ALTO libera o máximo de efeitos.", 18, 470, 0.54, 0.54, 0);
} else if (aba == 2) {
    draw_set_color(_muted);
    draw_text_ext_transformed(350, 428, "A resolução muda o tamanho da janela. Em tela cheia, o jogo mantém a escala pela tela.", 18, 470, 0.54, 0.54, 0);
} else {
    draw_set_color(_muted);
    draw_text_ext_transformed(350, 428, "Modo atual: " + (window_get_fullscreen() ? "TELA CHEIA" : "JANELA"), 18, 470, 0.62, 0.62, 0);
}

var _btn_drift = sin(menu_timer * 0.035) * 1.4;
draw_set_alpha(0.62);
draw_set_color(make_color_rgb(8, 18, 31));
draw_rectangle(voltar_x - 8, voltar_y + 36 + _btn_drift, voltar_x + 8, gui_h + 8, false);
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(24, 70, 96));
draw_rectangle(voltar_x - 3, voltar_y + 34 + _btn_drift, voltar_x + 3, gui_h + 8, false);
draw_set_alpha(0.8);
draw_set_color(make_color_rgb(112, 198, 228));
draw_rectangle(voltar_x - 6, voltar_y + 34 + _btn_drift, voltar_x + 6, voltar_y + 44 + _btn_drift, false);
draw_set_alpha(1);
var _voltar_scale_sprite = voltar_hover ? 1.58 : 1.50;
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
