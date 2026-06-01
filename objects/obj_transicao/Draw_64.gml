draw_set_alpha(estado == "indo" ? min(1, timer) : max(0, 1 - timer));
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);
draw_set_color(c_white);
