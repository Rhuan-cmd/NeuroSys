var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

if (introducao_ativa && entrada_fade < 0.86) {
    var _texto = dialogo_textos[dialogo_index];
    var _visivel = string_copy(_texto, 1, floor(dialogo_chars));
    var _pulso = 0.62 + sin(current_time * 0.008) * 0.22;
    var _abre = dialogo_abertura * dialogo_abertura * (3 - 2 * dialogo_abertura);
    var _x1 = lerp(_gui_w / 2, 88, _abre);
    var _x2 = lerp(_gui_w / 2, _gui_w - 88, _abre);
    var _y1 = lerp(405, 324, _abre);
    var _y2 = lerp(405, 486, _abre);

    draw_sprite_ext(spr_f3_instrucao1, 0, _gui_w / 2, 112 + sin(current_time * 0.004) * 4, 2, 2, 0, c_white, 0.82 * _abre);
    draw_set_alpha(0.78 * _abre);
    draw_set_color(make_color_rgb(5, 13, 28));
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    draw_set_alpha(_abre);
    draw_set_color(make_color_rgb(64, 218, 255));
    draw_rectangle(_x1, _y1, _x2, _y1 + 4, false);
    draw_set_font(fnt_dialogo);
    draw_text_transformed(_x1 + 30, _y1 + 22, dialogo_titulos[dialogo_index], 1.08, 1.08, 0);
    draw_set_color(c_white);
    draw_text_ext_transformed(_x1 + 30, _y1 + 60, _visivel, 22, max(0, _x2 - _x1 - 60), 1, 1, 0);
    draw_set_alpha(_pulso * _abre);
    draw_set_color(make_color_rgb(126, 238, 255));
    draw_text(_x1 + 30, _y2 - 28, "ESPAÇO ou ENTER  continuar");
    draw_set_alpha(1);
}

if (entrada_fade > 0) {
    draw_set_alpha(entrada_fade);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);

    var _titulo_t = 1 - entrada_fade;
    draw_set_alpha(sin(_titulo_t * pi));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_dialogo);
    draw_set_color(c_white);
    draw_text_transformed(_gui_w / 2, _gui_h / 2 - 28, "FASE 3", 1.9, 1.9, 0);
    draw_set_color(make_color_rgb(112, 230, 250));
    draw_text_transformed(_gui_w / 2, _gui_h / 2 + 18, "REDE DE APOIO", 1.12, 1.12, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}

draw_set_color(c_white);
