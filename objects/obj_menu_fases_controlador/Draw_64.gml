var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.06);

draw_set_alpha(1);
draw_set_color(make_color_rgb(5, 11, 22));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_text_transformed(gui_w * 0.5, 88, "SELEÇÃO DE FASES", 2, 2, 0);

for (var i = 0; i < array_length(fase_nome); i += 1) {
    var h = hover == i;
    var painel_alpha = 0.66;
    var borda_alpha = 0.36;
    var borda_cor = make_color_rgb(45, 116, 148);
    var texto_cor = make_color_rgb(198, 226, 236);
    var texto_drift = 0;

    if (h) {
        painel_alpha = 0.92;
        borda_alpha = 0.86;
        borda_cor = make_color_rgb(115, 210, 245);
        texto_cor = c_white;
        texto_drift = sin(menu_timer * 0.1) * 1;
    }

    draw_set_alpha(painel_alpha);
    draw_set_color(make_color_rgb(9, 23, 42));
    draw_roundrect(fase_x - 160, fase_y[i] - 28, fase_x + 160, fase_y[i] + 28, false);

    draw_set_alpha(borda_alpha);
    draw_set_color(borda_cor);
    draw_roundrect(fase_x - 160, fase_y[i] - 28, fase_x + 160, fase_y[i] + 28, true);

    draw_set_alpha(1);
    draw_set_color(texto_cor);
    draw_text(fase_x, fase_y[i] + texto_drift, fase_nome[i]);
}

draw_set_alpha(0.72 + pulse * 0.16);
draw_set_color(make_color_rgb(145, 204, 230));
draw_text(gui_w * 0.5, gui_h - 42, "ESC para voltar");

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
