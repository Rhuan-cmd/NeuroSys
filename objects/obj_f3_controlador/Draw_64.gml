var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (introducao_ativa && entrada_fade < 0.86) {
    var _texto = dialogo_textos[dialogo_index];
    var _visivel = string_copy(_texto, 1, floor(dialogo_chars));
    var _pulso = 0.62 + sin(current_time * 0.008) * 0.22;

    draw_sprite_ext(spr_f3_instrucao1, 0, _gui_w / 2, 112 + sin(current_time * 0.004) * 4, 2, 2, 0, c_white, 0.82);
    draw_set_alpha(0.78);
    draw_set_color(make_color_rgb(5, 13, 28));
    draw_rectangle(88, 324, _gui_w - 88, 486, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(64, 218, 255));
    draw_rectangle(88, 324, _gui_w - 88, 328, false);
    draw_set_font(fnt_dialogo);
    draw_text_transformed(118, 346, dialogo_titulos[dialogo_index], 1.08, 1.08, 0);
    draw_set_color(c_white);
    draw_text_ext_transformed(118, 384, _visivel, 22, 700, 1, 1, 0);
    draw_set_alpha(_pulso);
    draw_set_color(make_color_rgb(126, 238, 255));
    draw_text(118, 458, "ESPAÇO ou ENTER  continuar");
    draw_set_alpha(1);
}

if (entrada_fade > 0) {
    draw_set_alpha(entrada_fade);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1);
}

draw_set_color(c_white);
