var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.06);
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;
var _app_bg = make_color_rgb(8, 18, 32);
var _panel = make_color_rgb(6, 13, 24);
var _side_w = 150;
var _feed_mask_l = app_x + _side_w;
var _feed_mask_r = app_x + app_w - 18;

draw_set_alpha(1);
draw_set_color(make_color_rgb(2, 6, 14));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_sprite_ext(
    spr_pc_interface_rede,
    0,
    app_x,
    app_y,
    app_w / sprite_get_width(spr_pc_interface_rede),
    app_h / sprite_get_height(spr_pc_interface_rede),
    0,
    c_white,
    1
);

draw_set_alpha(0.92);
draw_set_color(_app_bg);
draw_roundrect(app_x, app_y, app_x + app_w, app_y + app_h, false);
draw_set_alpha(0.44);
draw_set_color(make_color_rgb(75, 170, 215));
draw_roundrect(app_x, app_y, app_x + app_w, app_y + app_h, true);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_alpha(1);
draw_set_color(make_color_rgb(10, 31, 50));
draw_rectangle(app_x, app_y, app_x + app_w, app_y + 54, false);
draw_set_color(make_color_rgb(93, 233, 255));
draw_text_transformed(app_x + 24, app_y + 27, "CONECTA", 0.86, 0.86, 0);
draw_set_color(make_color_rgb(160, 185, 207));
draw_text_transformed(app_x + 160, app_y + 28, "Feed de casos", 0.74, 0.74, 0);

draw_set_alpha(0.72);
draw_set_color(make_color_rgb(5, 12, 22));
draw_rectangle(app_x, app_y + 54, app_x + _side_w, app_y + app_h, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(124, 221, 248));
draw_text_transformed(app_x + 20, app_y + 106, "Navegação", 0.78, 0.78, 0);
draw_set_color(make_color_rgb(159, 178, 198));
draw_text_ext_transformed(app_x + 20, app_y + 156, "Role o feed.\nCada post abre\numa fase.\n\nCadeados liberam\nem ordem.", 15, 118, 0.66, 0.66, 0);

draw_set_alpha(0.88);
draw_set_color(make_color_rgb(4, 11, 21));
draw_rectangle(_feed_mask_l, feed_top, _feed_mask_r, feed_bottom, false);
draw_set_alpha(0.35);
draw_set_color(make_color_rgb(43, 118, 154));
draw_rectangle(_feed_mask_l, feed_top, _feed_mask_r, feed_bottom, true);

draw_set_halign(fa_left);
for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (_y > feed_bottom + 20 || _y + post_h < feed_top - 20) continue;

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

    var _foto_x = feed_x + 16;
    var _foto_y = _y + 58;
    var _foto_w = 94;
    var _foto_h = 54;
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
    draw_text_transformed(feed_x + 124, _y + 60, fase_nome[i], 0.75, 0.75, 0);
    draw_set_color(_bloqueado ? make_color_rgb(91, 100, 116) : make_color_rgb(185, 205, 224));
    draw_text_ext_transformed(feed_x + 124, _y + 83, fase_desc[i], 14, 220, 0.62, 0.62, 0);

    draw_set_halign(fa_center);
    if (_bloqueado) {
        draw_sprite_ext(spr_ui_cadeado, 0, feed_x + feed_w - 38, _y + 28, 0.95, 0.95, 0, c_white, 0.9);
        draw_set_color(make_color_rgb(142, 153, 171));
        draw_text_transformed(feed_x + feed_w - 38, _y + 54, "bloqueado", 0.58, 0.58, 0);
    } else {
        draw_set_color(_hover ? make_color_rgb(255, 246, 152) : make_color_rgb(116, 231, 255));
        draw_text_transformed(feed_x + feed_w - 40, _y + 29, "JOGAR", 0.68, 0.68, 0);
    }
    draw_set_halign(fa_left);
}

// Mascara o feed para os posts nao vazarem para fora da interface.
draw_set_alpha(1);
draw_set_color(_app_bg);
draw_rectangle(_feed_mask_l, app_y + 54, _feed_mask_r, feed_top - 1, false);
draw_rectangle(_feed_mask_l, feed_bottom + 1, _feed_mask_r, app_y + app_h - 1, false);
draw_rectangle(app_x, app_y + 54, _feed_mask_l - 1, app_y + app_h, false);
draw_rectangle(_feed_mask_r + 1, app_y + 54, app_x + app_w, app_y + app_h, false);

draw_set_alpha(1);
draw_set_color(make_color_rgb(10, 31, 50));
draw_rectangle(app_x, app_y, app_x + app_w, app_y + 54, false);
draw_set_color(make_color_rgb(93, 233, 255));
draw_text_transformed(app_x + 24, app_y + 27, "CONECTA", 0.86, 0.86, 0);
draw_set_color(make_color_rgb(160, 185, 207));
draw_text_transformed(app_x + 160, app_y + 28, "Feed de casos", 0.74, 0.74, 0);

draw_set_alpha(0.72);
draw_set_color(make_color_rgb(5, 12, 22));
draw_rectangle(app_x, app_y + 54, app_x + _side_w, app_y + app_h, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(124, 221, 248));
draw_text_transformed(app_x + 20, app_y + 106, "Navegação", 0.78, 0.78, 0);
draw_set_color(make_color_rgb(159, 178, 198));
draw_text_ext_transformed(app_x + 20, app_y + 156, "Role o feed.\nCada post abre\numa fase.\n\nCadeados liberam\nem ordem.", 15, 118, 0.66, 0.66, 0);

var _voltar_scale = voltar_hover ? 1.06 : 1;
draw_set_alpha(0.95);
draw_set_color(voltar_hover ? make_color_rgb(22, 64, 88) : make_color_rgb(8, 25, 42));
draw_roundrect(voltar_x - voltar_w * 0.5 * _voltar_scale, voltar_y - voltar_h * 0.5 * _voltar_scale, voltar_x + voltar_w * 0.5 * _voltar_scale, voltar_y + voltar_h * 0.5 * _voltar_scale, false);
draw_set_alpha(voltar_hover ? 0.86 : 0.52);
draw_set_color(make_color_rgb(105, 211, 244));
draw_roundrect(voltar_x - voltar_w * 0.5 * _voltar_scale, voltar_y - voltar_h * 0.5 * _voltar_scale, voltar_x + voltar_w * 0.5 * _voltar_scale, voltar_y + voltar_h * 0.5 * _voltar_scale, true);
draw_set_alpha(1);
draw_set_color(make_color_rgb(220, 247, 255));
draw_triangle(voltar_x - 16, voltar_y, voltar_x + 5, voltar_y - 13, voltar_x + 5, voltar_y + 13, false);
draw_rectangle(voltar_x + 2, voltar_y - 5, voltar_x + 22, voltar_y + 5, false);

draw_set_halign(fa_center);
draw_set_color(make_color_rgb(174, 194, 216));
draw_text_transformed((feed_x + feed_w * 0.5), app_y + 70, "Escolha uma postagem liberada", 0.68, 0.68, 0);

var _max_scroll = max(1, feed_altura - (feed_bottom - feed_top));
var _bar_h = max(34, (feed_bottom - feed_top) * ((feed_bottom - feed_top) / max(feed_altura, feed_bottom - feed_top)));
var _bar_y = feed_top + (feed_bottom - feed_top - _bar_h) * clamp(scroll_y / _max_scroll, 0, 1);
draw_set_alpha(0.42);
draw_set_color(make_color_rgb(21, 45, 66));
draw_rectangle(feed_x + feed_w + 18, feed_top, feed_x + feed_w + 26, feed_bottom, false);
draw_set_alpha(0.86);
draw_set_color(make_color_rgb(105, 211, 244));
draw_rectangle(feed_x + feed_w + 18, _bar_y, feed_x + feed_w + 26, _bar_y + _bar_h, false);

draw_set_alpha(0.72 + pulse * 0.16);
draw_set_color(make_color_rgb(145, 204, 230));
draw_text_transformed(gui_w * 0.5, gui_h - 24, "use a roda do mouse para rolar", 0.62, 0.62, 0);

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
