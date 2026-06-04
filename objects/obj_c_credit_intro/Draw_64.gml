if (aparecer && global.intro_phase == 1) {
    var texto_render = string_copy(gm_text, 1, gm_text_index);
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var cx = gui_w * 0.5;
    var cy = gui_h * 0.5;

    var logo_scale = 0.48;
    var logo_w = sprite_get_width(spr_c_gamemaker_logo) * logo_scale;
    var logo_h = sprite_get_height(spr_c_gamemaker_logo) * logo_scale;
    var logo_x = cx - logo_w * 0.5;
    var logo_y = cy - logo_h * 0.5 - 26;
    var alpha = min(gm_logo_alpha, global.intro_phase_alpha);

    draw_set_font(fnt_f2_dialogo);
    draw_set_alpha(alpha);
    draw_sprite_ext(spr_c_gamemaker_logo, 0, logo_x, logo_y, logo_scale, logo_scale, 0, c_white, alpha);

    draw_set_color(make_color_rgb(195, 232, 236));
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_transformed(cx, cy + 86, texto_render, 1, 1, 0);

    draw_set_halign(fa_left);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
