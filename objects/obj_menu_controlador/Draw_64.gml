var gui_w = display_get_gui_width();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.08);
var cx = (monitor_left + monitor_right) * 0.5;

draw_set_alpha(0.82 + pulse * 0.14 + monitor_hover * 0.04);
draw_set_color(make_color_rgb(231, 246, 255));
draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(cx, monitor_bottom + 42 + pulse * 2, "clique na luz do computador");

draw_set_alpha(0.28);
draw_set_color(make_color_rgb(31, 214, 181));
draw_line(cx, monitor_bottom + 12, cx, monitor_bottom + 28);
draw_line(cx - 8, monitor_bottom + 20, cx, monitor_bottom + 28);
draw_line(cx + 8, monitor_bottom + 20, cx, monitor_bottom + 28);

draw_set_alpha(0.48);
draw_set_color(make_color_rgb(7, 14, 26));
draw_rectangle(0, 0, gui_w, 16, false);
draw_rectangle(0, display_get_gui_height() - 16, gui_w, display_get_gui_height(), false);
draw_rectangle(0, 0, 16, display_get_gui_height(), false);
draw_rectangle(gui_w - 16, 0, gui_w, display_get_gui_height(), false);

draw_set_alpha(0.32 + pulse * 0.06);
draw_set_color(make_color_rgb(84, 147, 218));
draw_rectangle(10, 10, gui_w - 10, display_get_gui_height() - 10, true);

draw_set_alpha(0.05);
draw_set_color(c_white);
draw_rectangle(24 + sin(menu_timer * 0.025) * 3, 24, gui_w - 24, display_get_gui_height() - 24, true);

if (clique_iniciado) {
    var fade = 1 - clamp(menu_saida_timer / max(1, round(room_speed * 0.45)), 0, 1);
    draw_set_alpha(fade * 0.55);
    draw_set_color(make_color_rgb(115, 196, 255));
    draw_rectangle(0, 0, gui_w, display_get_gui_height(), false);

    draw_set_alpha(fade * 0.75);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, display_get_gui_height(), false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
