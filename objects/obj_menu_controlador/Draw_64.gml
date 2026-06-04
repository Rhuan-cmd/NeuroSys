var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.08);

for (var edge = 0; edge < 18; edge += 1) {
    var a = sqr(edge / 17) * 0.04;
    draw_set_alpha(a);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, 96 - edge * 3, false);
    draw_rectangle(0, gui_h - 96 + edge * 3, gui_w, gui_h, false);
    draw_rectangle(0, 0, 122 - edge * 4, gui_h, false);
    draw_rectangle(gui_w - 122 + edge * 4, 0, gui_w, gui_h, false);
}

for (var corner = 0; corner < 12; corner += 1) {
    var ca = 0.035 + corner * 0.011;
    var r = 190 + corner * 24;
    draw_set_alpha(ca);
    draw_set_color(c_black);
    draw_ellipse(-r * 0.62, -r * 0.44, r * 0.62, r * 0.44, false);
    draw_ellipse(gui_w - r * 0.62, -r * 0.44, gui_w + r * 0.62, r * 0.44, false);
    draw_ellipse(-r * 0.62, gui_h - r * 0.44, r * 0.62, gui_h + r * 0.44, false);
    draw_ellipse(gui_w - r * 0.62, gui_h - r * 0.44, gui_w + r * 0.62, gui_h + r * 0.44, false);
}

draw_set_alpha(0.16);
draw_set_color(make_color_rgb(14, 27, 46));
draw_roundrect(650, 144, 928, 430, false);
draw_set_alpha(0.28 + pulse * 0.06);
draw_set_color(make_color_rgb(64, 144, 190));
draw_roundrect(654, 148, 924, 426, true);

for (var i = 0; i < array_length(botao_sprite); i += 1) {
    var frame = 0;
    var scale = 1;
    if (botao_hover == i) {
        frame = 1;
        scale = 1.04;
    }
    var drift = sin(menu_timer * 0.035 + i) * 1.4;
    draw_sprite_ext(botao_sprite[i], frame, botao_x, botao_y[i] + drift, scale, scale, 0, c_white, 1);
}

if (clique_iniciado) {
    var fade = 1 - clamp(menu_saida_timer / max(1, round(room_speed * 0.45)), 0, 1);
    draw_set_alpha(fade * 0.55);
    draw_set_color(make_color_rgb(115, 196, 255));
    draw_rectangle(0, 0, gui_w, gui_h, false);

    draw_set_alpha(fade * 0.75);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
