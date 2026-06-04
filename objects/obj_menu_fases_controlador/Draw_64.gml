var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.06);
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;

draw_set_alpha(1);
draw_set_color(make_color_rgb(4, 9, 19));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_alpha(0.94);
draw_set_color(make_color_rgb(8, 19, 35));
draw_roundrect(188, 42, 772, 510, false);
draw_set_alpha(0.5);
draw_set_color(make_color_rgb(70, 158, 202));
draw_roundrect(188, 42, 772, 510, true);

draw_set_alpha(1);
draw_set_color(make_color_rgb(112, 218, 246));
draw_text_transformed(gui_w * 0.5, 70, "CONECTA", 1.25, 1.25, 0);
draw_set_color(make_color_rgb(174, 194, 216));
draw_text(gui_w * 0.5, 96, "role o feed e escolha uma postagem liberada");

draw_set_halign(fa_left);
for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (_y > feed_bottom + 40 || _y + post_h < feed_top - 40) continue;

    var _bloqueado = i + 1 > _liberada;
    var _hover = hover == i;
    var _cor_borda = _bloqueado ? make_color_rgb(65, 75, 92) : (_hover ? make_color_rgb(132, 229, 255) : make_color_rgb(37, 104, 142));
    var _cor_post = _bloqueado ? make_color_rgb(12, 17, 25) : make_color_rgb(10, 24, 42);

    draw_set_alpha(_bloqueado ? 0.78 : 0.94);
    draw_set_color(_cor_post);
    draw_roundrect(post_x, _y, post_x + post_w, _y + post_h, false);
    draw_set_alpha(_hover ? 0.92 : 0.48);
    draw_set_color(_cor_borda);
    draw_roundrect(post_x, _y, post_x + post_w, _y + post_h, true);

    draw_set_alpha(1);
    draw_set_color(_bloqueado ? make_color_rgb(94, 105, 124) : make_color_rgb(94, 238, 255));
    draw_circle(post_x + 32, _y + 31, 15, false);
    draw_set_color(_bloqueado ? make_color_rgb(138, 148, 162) : c_white);
    draw_text(post_x + 58, _y + 24, fase_tag[i]);
    draw_set_color(make_color_rgb(108, 126, 148));
    draw_text(post_x + 58, _y + 46, "postagem #" + string(i + 1));

    var _foto_x = post_x + 24;
    var _foto_y = _y + 72;
    draw_set_alpha(_bloqueado ? 0.28 : 0.92);
    draw_set_color(make_color_rgb(3, 8, 16));
    draw_rectangle(_foto_x, _foto_y, _foto_x + 116, _foto_y + 78, false);
    var _spr = fase_foto[i];
    var _sw = sprite_get_width(_spr);
    var _sh = sprite_get_height(_spr);
    var _esc = min(104 / max(1, _sw), 66 / max(1, _sh));
    draw_sprite_ext(_spr, 0, _foto_x + 58, _foto_y + 39, _esc, _esc, 0, c_white, _bloqueado ? 0.38 : 1);

    draw_set_alpha(1);
    draw_set_color(_bloqueado ? make_color_rgb(132, 142, 158) : c_white);
    draw_text(post_x + 158, _y + 80, fase_nome[i]);
    draw_set_color(_bloqueado ? make_color_rgb(91, 100, 116) : make_color_rgb(185, 205, 224));
    draw_text_ext(post_x + 158, _y + 108, fase_desc[i], 18, 260);

    draw_set_halign(fa_center);
    if (_bloqueado) {
        draw_set_color(make_color_rgb(255, 213, 122));
        draw_text(post_x + post_w - 52, _y + 86, "CADEADO");
        draw_set_color(make_color_rgb(158, 166, 181));
        draw_text(post_x + post_w - 52, _y + 114, "passe o post anterior");
    } else {
        draw_set_color(_hover ? make_color_rgb(255, 246, 152) : make_color_rgb(116, 231, 255));
        draw_text(post_x + post_w - 54, _y + 96, "JOGAR");
    }
    draw_set_halign(fa_left);
}

var _max_scroll = max(1, feed_altura - (feed_bottom - feed_top));
var _bar_h = max(34, (feed_bottom - feed_top) * ((feed_bottom - feed_top) / feed_altura));
var _bar_y = feed_top + (feed_bottom - feed_top - _bar_h) * clamp(scroll_y / _max_scroll, 0, 1);
draw_set_alpha(0.42);
draw_set_color(make_color_rgb(21, 45, 66));
draw_rectangle(742, feed_top, 750, feed_bottom, false);
draw_set_alpha(0.86);
draw_set_color(make_color_rgb(105, 211, 244));
draw_rectangle(742, _bar_y, 750, _bar_y + _bar_h, false);

draw_set_halign(fa_center);
draw_set_alpha(0.72 + pulse * 0.16);
draw_set_color(make_color_rgb(145, 204, 230));
draw_text(gui_w * 0.5, gui_h - 24, "ESC para voltar");

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
