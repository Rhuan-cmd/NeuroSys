if (room == rm_menu && menu_fade_alpha > 0) {
    draw_set_alpha(menu_fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}

if (variable_global_exists("save_aviso_timer") && global.save_aviso_timer > 0 && (!variable_global_exists("op_mostrar_save_aviso") || global.op_mostrar_save_aviso)) {
    var _gui_w_save = display_get_gui_width();
    var _alpha_save = min(1, global.save_aviso_timer / 18);
    draw_set_alpha(0.78 * _alpha_save);
    draw_set_color(make_color_rgb(4, 18, 31));
    draw_roundrect(_gui_w_save - 152, 18, _gui_w_save - 26, 50, false);
    draw_set_alpha(_alpha_save);
    draw_set_color(make_color_rgb(92, 226, 255));
    draw_roundrect(_gui_w_save - 152, 18, _gui_w_save - 26, 50, true);
    draw_set_font(fnt_f2_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(_gui_w_save - 89, 34, "SALVO", 0.54, 0.54, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(1);
}

if (variable_global_exists("jogo_pausado") && global.jogo_pausado) {
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _panel_w = 360;
    var _panel_h = 270;
    var _panel_x = _gui_w * 0.5 - _panel_w * 0.5;
    var _panel_y = _gui_h * 0.5 - _panel_h * 0.5;

    draw_set_alpha(0.68);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);

    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(7, 18, 31));
    draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(88, 222, 255));
    draw_roundrect(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);
    draw_set_color(make_color_rgb(18, 62, 88));
    draw_rectangle(_panel_x + 16, _panel_y + 16, _panel_x + _panel_w - 16, _panel_y + 18, false);
    draw_rectangle(_panel_x + 16, _panel_y + _panel_h - 18, _panel_x + _panel_w - 16, _panel_y + _panel_h - 16, false);

    draw_set_font(fnt_f2_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(111, 235, 255));
    draw_text_transformed(_gui_w * 0.5, _panel_y + 48, "PAUSADO", 0.95, 0.95, 0);

    var _btn_x1 = _panel_x + 70;
    var _btn_x2 = _panel_x + _panel_w - 70;
    var _btn_h = 40;
    for (var _p = 0; _p < 3; _p += 1) {
        var _by1 = _panel_y + 94 + _p * 56;
        var _hover = pausa_hover == _p;
        draw_set_alpha(_hover ? 0.98 : 0.84);
        draw_set_color(_hover ? make_color_rgb(18, 67, 94) : make_color_rgb(9, 31, 49));
        draw_roundrect(_btn_x1, _by1, _btn_x2, _by1 + _btn_h, false);
        draw_set_alpha(1);
        draw_set_color(_hover ? make_color_rgb(255, 246, 152) : make_color_rgb(136, 222, 246));
        draw_roundrect(_btn_x1, _by1, _btn_x2, _by1 + _btn_h, true);
        draw_text_transformed(_gui_w * 0.5, _by1 + _btn_h * 0.5, pausa_botoes[_p], 0.68, 0.68, 0);
    }

    if (pausa_fade > 0) {
        draw_set_alpha(pausa_fade);
        draw_set_color(c_black);
        draw_rectangle(0, 0, _gui_w, _gui_h, false);
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
