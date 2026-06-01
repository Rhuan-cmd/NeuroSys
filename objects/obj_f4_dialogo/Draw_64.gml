var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

var _largura = 850 * abertura;
var _altura = 176 * abertura;
var _x1 = (_gui_w / 2) - (_largura / 2);
var _y1 = _gui_h - 188;
var _x2 = _x1 + _largura;
var _y2 = _y1 + _altura;

if (abertura > 0) {
    draw_set_color(c_black);
    draw_set_font(fnt_dialogo);
    var _passo = _largura / (pontos_borda / 2);

    for (var i = 0; i < (pontos_borda / 2); i++) {
        var _px = _x1 + (i * _passo);
        var _off_sup = offsets_borda[i];
        var _off_inf = offsets_borda[i + (pontos_borda / 2)];
        draw_rectangle(_px - 1, _y1 + _off_sup, _px + _passo + 1, _y2 + _off_inf, false);
    }

    var _foto_x = _x1 + 50;
    var _foto_y = _y1 + (_altura / 2) - 45;

    if (abertura > 0.5) {
        for (var j = 0; j < 5; j++) {
            var _yy = j * 18;
            var _sh = random_range(-intensidade_glitch / 2, intensidade_glitch / 2);
            draw_sprite_part_ext(sprite_rosto, 0, 0, _yy, 100, 18, _foto_x + _sh, _foto_y + _yy, 0.9, 0.9, c_white, 1);
        }
    }

    if (estado == "ativo") {
        var _txt_x = _foto_x + 120;
        var _txt_y = _y1 + 28;
        var _str = string_copy(textos[pagina_atual], 1, floor(tamanho_texto));

        draw_set_color(c_red);
        draw_text_ext(_txt_x + 1, _txt_y + 1, _str, 22, 650);
        draw_set_color(c_white);
        draw_text_ext(_txt_x, _txt_y, _str, 22, 650);

        if (current_time % 600 < 300) {
            draw_text(_txt_x, _y2 - 34, "ESPAÇO ou ENTER  continuar  _");
        }
    }
}

if (entrada_fade > 0) {
    draw_set_alpha(entrada_fade);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
}

draw_set_color(c_white);
