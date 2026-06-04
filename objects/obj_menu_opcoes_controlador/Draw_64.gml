var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.05);

draw_set_alpha(1);
draw_set_color(make_color_rgb(5, 11, 22));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
draw_text_transformed(gui_w * 0.5, 96, "OPÇÕES", 2, 2, 0);

draw_set_alpha(0.82);
draw_set_color(make_color_rgb(9, 23, 42));
draw_roundrect(250, 205, 710, 330, false);

draw_set_alpha(0.55 + pulse * 0.08);
draw_set_color(make_color_rgb(80, 165, 205));
draw_roundrect(250, 205, 710, 330, true);

draw_set_alpha(1);
draw_set_color(make_color_rgb(218, 241, 248));
draw_text(gui_w * 0.5, 240, "Volume geral");

draw_set_alpha(0.65);
draw_set_color(make_color_rgb(30, 65, 92));
draw_rectangle(330, 280, 630, 298, false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(115, 210, 245));
draw_rectangle(330, 280, 330 + 300 * volume_master, 298, false);

draw_set_color(c_white);
draw_text(gui_w * 0.5, 370, "← / → ajusta volume");
draw_text(gui_w * 0.5, 420, "ESC para voltar");

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
