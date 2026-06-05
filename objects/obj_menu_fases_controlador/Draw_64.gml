var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;
var _app_bg = make_color_rgb(7, 17, 31);
var _panel = make_color_rgb(4, 10, 19);
var _side_bg = make_color_rgb(5, 13, 24);
var _header = make_color_rgb(10, 31, 50);
var _cyan = make_color_rgb(83, 213, 245);
var _cyan_soft = make_color_rgb(39, 120, 158);
var _side_w = 220;
var _header_h = 58;
var _feed_panel_x = app_x + _side_w;
var _feed_panel_y = app_y + _header_h;
var _feed_panel_r = app_x + app_w;
var _feed_panel_b = app_y + app_h;
var _feed_mask_l = _feed_panel_x + 24;
var _feed_mask_r = _feed_panel_r - 26;
var _scroll_x = _feed_mask_r - 10;
var _divider_x = _feed_panel_x;
var _cover = 18;

draw_set_alpha(1);
draw_set_color(make_color_rgb(2, 6, 14));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_alpha(1);
draw_set_color(_app_bg);
draw_rectangle(app_x, app_y, app_x + app_w, app_y + app_h, false);
draw_set_color(_cyan_soft);
draw_rectangle(app_x, app_y, app_x + app_w, app_y + app_h, true);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(app_x + 4, app_y + 4, app_x + app_w - 4, app_y + app_h - 4, true);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_color(_header);
draw_rectangle(app_x, app_y, app_x + app_w, app_y + _header_h, false);
draw_set_color(make_color_rgb(93, 233, 255));
draw_text_transformed(app_x + 24, app_y + 30, "CONECTA", 0.86, 0.86, 0);
draw_set_color(make_color_rgb(160, 185, 207));
draw_text_transformed(app_x + 164, app_y + 31, "Feed de casos", 0.74, 0.74, 0);
draw_set_color(make_color_rgb(28, 91, 128));
draw_rectangle(app_x, app_y + _header_h - 2, app_x + app_w, app_y + _header_h, false);

draw_set_color(_side_bg);
draw_rectangle(app_x, app_y + _header_h, _divider_x, app_y + app_h, false);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(_divider_x - 4, app_y + _header_h, _divider_x + 4, app_y + app_h, false);
draw_set_color(make_color_rgb(52, 139, 178));
draw_rectangle(_divider_x + 3, app_y + _header_h, _divider_x + 4, app_y + app_h, false);

draw_set_color(_panel);
draw_rectangle(_feed_panel_x + 1, _feed_panel_y, _feed_panel_r, _feed_panel_b, false);
draw_set_color(make_color_rgb(2, 7, 14));
draw_rectangle(_feed_mask_l - _cover, feed_top - _cover, _feed_mask_r + _cover, feed_bottom + _cover, false);
draw_set_color(make_color_rgb(8, 18, 32));
draw_rectangle(_feed_mask_l, feed_top, _feed_mask_r, feed_bottom, false);

draw_set_halign(fa_left);
for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (_y > feed_bottom + 12 || _y + post_h < feed_top - 12) continue;

    var _bloqueado = i + 1 > _liberada;
    var _hover = hover == i;
    var _cor_post = _bloqueado ? make_color_rgb(11, 15, 22) : make_color_rgb(11, 25, 42);
    var _cor_borda = _bloqueado ? make_color_rgb(58, 67, 82) : (_hover ? make_color_rgb(130, 230, 255) : make_color_rgb(40, 111, 150));

    draw_set_alpha(_bloqueado ? 0.78 : 0.96);
    draw_set_color(_cor_post);
    draw_roundrect(feed_x, _y, feed_x + feed_w, _y + post_h, false);
    draw_set_alpha(_hover ? 0.9 : 0.46);
    draw_set_color(_cor_borda);
    draw_roundrect(feed_x, _y, feed_x + feed_w, _y + post_h, true);

    draw_set_alpha(1);
    draw_set_color(_bloqueado ? make_color_rgb(86, 96, 112) : make_color_rgb(94, 238, 255));
    draw_circle(feed_x + 24, _y + 24, 11, false);
    draw_set_color(_bloqueado ? make_color_rgb(132, 142, 158) : c_white);
    draw_text_transformed(feed_x + 44, _y + 20, fase_tag[i], 0.68, 0.68, 0);
    draw_set_color(make_color_rgb(102, 123, 146));
    draw_text_transformed(feed_x + 44, _y + 40, "postagem #" + string(i + 1), 0.58, 0.58, 0);

    var _foto_x = feed_x + 18;
    var _foto_y = _y + 62;
    var _foto_w = 106;
    var _foto_h = 58;
    draw_set_alpha(_bloqueado ? 0.28 : 1);
    draw_set_color(make_color_rgb(2, 8, 16));
    draw_roundrect(_foto_x, _foto_y, _foto_x + _foto_w, _foto_y + _foto_h, false);
    draw_set_alpha(_bloqueado ? 0.18 : 0.42);
    draw_set_color(make_color_rgb(73, 166, 204));
    draw_roundrect(_foto_x, _foto_y, _foto_x + _foto_w, _foto_y + _foto_h, true);
    var _spr = fase_foto[i];
    var _sw = sprite_get_width(_spr);
    var _sh = sprite_get_height(_spr);
    var _esc = min((_foto_w - 8) / max(1, _sw), (_foto_h - 8) / max(1, _sh));
    var _dx = _foto_x + (_foto_w - _sw * _esc) * 0.5;
    var _dy = _foto_y + (_foto_h - _sh * _esc) * 0.5;
    draw_set_alpha(_bloqueado ? 0.42 : 1);
    draw_sprite_part_ext(_spr, 0, 0, 0, _sw, _sh, _dx, _dy, _esc, _esc, c_white, _bloqueado ? 0.42 : 1);

    draw_set_alpha(1);
    draw_set_color(_bloqueado ? make_color_rgb(132, 142, 158) : c_white);
    draw_text_transformed(feed_x + 142, _y + 64, fase_nome[i], 0.76, 0.76, 0);
    draw_set_color(_bloqueado ? make_color_rgb(91, 100, 116) : make_color_rgb(185, 205, 224));
    draw_text_ext_transformed(feed_x + 142, _y + 89, fase_desc[i], 16, 260, 0.62, 0.62, 0);

    draw_set_halign(fa_center);
    if (_bloqueado) {
        draw_sprite_ext(spr_ui_cadeado, 0, feed_x + feed_w - 42, _y + 30, 0.95, 0.95, 0, c_white, 0.9);
        draw_set_color(make_color_rgb(142, 153, 171));
        draw_text_transformed(feed_x + feed_w - 42, _y + 58, "bloqueado", 0.58, 0.58, 0);
    } else {
        draw_set_color(_hover ? make_color_rgb(255, 246, 152) : make_color_rgb(116, 231, 255));
        draw_text_transformed(feed_x + feed_w - 46, _y + 32, "JOGAR", 0.68, 0.68, 0);
    }
    draw_set_halign(fa_left);
}

// Tampa tudo que sair da janela do feed. A area visivel fica apenas entre feed_top e feed_bottom.
draw_set_alpha(1);
draw_set_color(_panel);
draw_rectangle(_feed_panel_x + 1, _feed_panel_y, _feed_panel_r, feed_top - 1, false);
draw_rectangle(_feed_panel_x + 1, feed_bottom + 1, _feed_panel_r, _feed_panel_b, false);
draw_rectangle(_feed_panel_x + 1, _feed_panel_y, _feed_mask_l - 1, _feed_panel_b, false);
draw_rectangle(_feed_mask_r + 1, _feed_panel_y, _feed_panel_r, _feed_panel_b, false);
draw_rectangle(0, 0, gui_w, app_y - 1, false);
draw_rectangle(0, app_y + app_h + 1, gui_w, gui_h, false);
draw_rectangle(0, 0, app_x - 1, gui_h, false);
draw_rectangle(app_x + app_w + 1, 0, gui_w, gui_h, false);

draw_set_color(make_color_rgb(2, 7, 14));
draw_rectangle(_feed_mask_l - _cover, feed_top - _cover, _feed_mask_r + _cover, feed_top, false);
draw_rectangle(_feed_mask_l - _cover, feed_bottom, _feed_mask_r + _cover, feed_bottom + _cover, false);
draw_rectangle(_feed_mask_l - _cover, feed_top - _cover, _feed_mask_l + _cover, feed_bottom + _cover, false);
draw_rectangle(_feed_mask_r - _cover, feed_top - _cover, _feed_mask_r + _cover, feed_bottom + _cover, false);
draw_set_color(_cyan_soft);
draw_rectangle(_feed_mask_l - 1, feed_top - 1, _feed_mask_r + 1, feed_top + 2, false);
draw_rectangle(_feed_mask_l - 1, feed_bottom - 2, _feed_mask_r + 1, feed_bottom + 1, false);
draw_rectangle(_feed_mask_l - 1, feed_top - 1, _feed_mask_l + 2, feed_bottom + 1, false);
draw_rectangle(_feed_mask_r - 2, feed_top - 1, _feed_mask_r + 1, feed_bottom + 1, false);

draw_set_color(_header);
draw_rectangle(app_x, app_y, app_x + app_w, app_y + _header_h, false);
draw_set_color(make_color_rgb(93, 233, 255));
draw_text_transformed(app_x + 24, app_y + 30, "CONECTA", 0.86, 0.86, 0);
draw_set_color(make_color_rgb(160, 185, 207));
draw_text_transformed(app_x + 164, app_y + 31, "Feed de casos", 0.74, 0.74, 0);

draw_set_color(_side_bg);
draw_rectangle(app_x, app_y + _header_h, _divider_x, app_y + app_h, false);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(_divider_x - 4, app_y + _header_h, _divider_x + 4, app_y + app_h, false);
draw_set_color(make_color_rgb(52, 139, 178));
draw_rectangle(_divider_x + 3, app_y + _header_h, _divider_x + 4, app_y + app_h, false);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(124, 221, 248));
draw_text_transformed(app_x + 24, app_y + 116, "Navegação", 0.78, 0.78, 0);
draw_set_color(make_color_rgb(159, 178, 198));
draw_text_ext_transformed(app_x + 24, app_y + 156, "Role o feed.\n\nCada post abre uma fase.\n\nCadeados liberam em ordem.", 22, 134, 0.66, 0.66, 0);

if (voltar_sprite != -1) {
    var _voltar_scale_sprite = voltar_hover ? 1.18 : 1.14;
    draw_sprite_ext(voltar_sprite, voltar_hover ? 1 : 0, voltar_x, voltar_y, _voltar_scale_sprite, _voltar_scale_sprite, 0, c_white, 1);
} else {
    var _voltar_scale = voltar_hover ? 1.04 : 1;
    draw_set_alpha(0.95);
    draw_set_color(voltar_hover ? make_color_rgb(22, 64, 88) : make_color_rgb(8, 25, 42));
    draw_roundrect(voltar_x - voltar_w * 0.5 * _voltar_scale, voltar_y - voltar_h * 0.5 * _voltar_scale, voltar_x + voltar_w * 0.5 * _voltar_scale, voltar_y + voltar_h * 0.5 * _voltar_scale, false);
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(220, 247, 255));
    draw_triangle(voltar_x - 16, voltar_y, voltar_x + 5, voltar_y - 13, voltar_x + 5, voltar_y + 13, false);
    draw_rectangle(voltar_x + 2, voltar_y - 5, voltar_x + 22, voltar_y + 5, false);
}

var _max_scroll = max(1, feed_altura - (feed_bottom - feed_top));
var _bar_h = max(42, (feed_bottom - feed_top) * ((feed_bottom - feed_top) / max(feed_altura, feed_bottom - feed_top)));
var _bar_y = feed_top + (feed_bottom - feed_top - _bar_h) * clamp(scroll_y / _max_scroll, 0, 1);
draw_set_alpha(1);
draw_set_color(make_color_rgb(14, 37, 57));
draw_rectangle(_scroll_x, feed_top, _scroll_x + 9, feed_bottom, false);
draw_set_color(make_color_rgb(105, 211, 244));
draw_rectangle(_scroll_x, _bar_y, _scroll_x + 9, _bar_y + _bar_h, false);

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
