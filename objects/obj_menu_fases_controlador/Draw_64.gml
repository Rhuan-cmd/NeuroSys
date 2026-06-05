var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;
var _concluidas = clamp(max(0, _liberada - 1), 0, 4);
var _app_bg = make_color_rgb(6, 15, 29);
var _panel = make_color_rgb(4, 10, 19);
var _side_bg = make_color_rgb(5, 13, 24);
var _header_dark = make_color_rgb(3, 10, 20);
var _cyan = make_color_rgb(93, 233, 255);
var _cyan_soft = make_color_rgb(39, 120, 158);
var _magenta = make_color_rgb(193, 61, 145);
var _side_w = 282;
var _header_h = 70;
var _feed_panel_x = app_x + _side_w;
var _feed_panel_y = app_y + _header_h;
var _feed_panel_r = app_x + app_w;
var _feed_panel_b = app_y + app_h;
var _feed_mask_l = _feed_panel_x;
var _feed_mask_r = _feed_panel_r;
var _scroll_x = _feed_mask_r - 11;
var _divider_x = _feed_panel_x;
var _cover = 18;
var _glitch = true;
var _anim = 0.5 + 0.5 * sin(menu_timer * 0.045);

function _mix_col(_a, _b, _t) {
    return merge_color(_a, _b, clamp(_t, 0, 1));
}

function _grad_rect(_x1, _y1, _x2, _y2, _c1, _c2, _steps) {
    var _h = (_y2 - _y1) / _steps;
    for (var _g = 0; _g < _steps; _g += 1) {
        draw_set_color(_mix_col(_c1, _c2, _g / max(1, _steps - 1)));
        draw_rectangle(_x1, _y1 + _g * _h, _x2, _y1 + (_g + 1) * _h + 1, false);
    }
}

function _glitch_text(_x, _y, _txt, _sx, _sy, _main, _ativo) {
    if (_ativo) {
        draw_set_color(make_color_rgb(174, 54, 144));
        draw_text_transformed(_x - 1, _y, _txt, _sx, _sy, 0);
        draw_set_color(make_color_rgb(58, 215, 238));
        draw_text_transformed(_x + 1, _y + 1, _txt, _sx, _sy, 0);
    }
    draw_set_color(_main);
    draw_text_transformed(_x, _y, _txt, _sx, _sy, 0);
}

draw_set_alpha(1);
_grad_rect(0, 0, gui_w, gui_h, make_color_rgb(3, 8, 18), _app_bg, 20);
draw_set_color(_cyan_soft);
draw_rectangle(app_x, app_y, app_x + app_w, app_y + app_h, true);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(app_x + 4, app_y + 4, app_x + app_w - 4, app_y + app_h - 4, true);

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

// Navbar dividida pela mesma coluna da lateral e do feed.
_grad_rect(app_x, app_y, _divider_x, app_y + _header_h, make_color_rgb(7, 24, 42), make_color_rgb(3, 12, 23), 8);
_grad_rect(_divider_x, app_y, app_x + app_w, app_y + _header_h, make_color_rgb(9, 32, 51), make_color_rgb(4, 13, 25), 8);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(_divider_x - 5, app_y, _divider_x + 5, app_y + app_h, false);
draw_set_color(make_color_rgb(52, 139, 178));
draw_rectangle(_divider_x + 4, app_y, _divider_x + 5, app_y + app_h, false);
draw_set_color(make_color_rgb(28, 91, 128));
draw_rectangle(app_x, app_y + _header_h - 3, app_x + app_w, app_y + _header_h, false);

draw_set_color(make_color_rgb(13, 45, 69));
draw_rectangle(app_x + 14, app_y + 10, _divider_x - 18, app_y + 52, false);
draw_set_color(make_color_rgb(33, 115, 150));
draw_rectangle(app_x + 14, app_y + 10, _divider_x - 18, app_y + 52, true);
_glitch_text(app_x + 26, app_y + 31, "CONECTA", 0.86, 0.86, _cyan, _glitch);
draw_sprite_ext(spr_f2_sino, (menu_timer div 8) mod sprite_get_number(spr_f2_sino), app_x + 135, app_y + 31, 0.28, 0.28, 0, c_white, 0.95);
draw_set_color(make_color_rgb(59, 168, 202));
draw_rectangle(app_x + 156, app_y + 30, app_x + 202, app_y + 32, false);
draw_set_color(make_color_rgb(190, 244, 255));
draw_rectangle(app_x + 204, app_y + 29, app_x + 208, app_y + 33, false);

draw_set_color(make_color_rgb(8, 24, 40));
draw_rectangle(_divider_x + 22, app_y + 13, _divider_x + 154, app_y + 51, false);
draw_set_color(make_color_rgb(89, 225, 255));
draw_rectangle(_divider_x + 22, app_y + 13, _divider_x + 154, app_y + 51, true);
_glitch_text(_divider_x + 44, app_y + 32, "FEED", 0.64, 0.64, make_color_rgb(89, 225, 255), _glitch);
draw_set_color(make_color_rgb(14, 42, 62));
draw_rectangle(_divider_x + 166, app_y + 13, _divider_x + 366, app_y + 51, false);
draw_set_color(make_color_rgb(44, 128, 164));
draw_rectangle(_divider_x + 166, app_y + 13, _divider_x + 366, app_y + 51, true);
_glitch_text(_divider_x + 186, app_y + 32, "CASOS DIGITAIS", 0.56, 0.56, make_color_rgb(177, 215, 234), _glitch);

draw_set_halign(fa_right);
_glitch_text(app_x + app_w - 30, app_y + 22, "NeuroSys // rede social", 0.54, 0.54, make_color_rgb(78, 148, 178), _glitch);
_glitch_text(app_x + app_w - 30, app_y + 44, "Casos liberados: " + string(_liberada) + "/4", 0.62, 0.62, make_color_rgb(182, 220, 238), _glitch);
draw_set_halign(fa_left);

_grad_rect(app_x, app_y + _header_h, _divider_x - 5, app_y + app_h, make_color_rgb(5, 16, 30), _side_bg, 16);
_grad_rect(_feed_panel_x + 1, _feed_panel_y, _feed_panel_r, _feed_panel_b, make_color_rgb(5, 14, 26), _panel, 18);
draw_set_color(make_color_rgb(2, 7, 14));
draw_rectangle(_feed_mask_l, feed_top - _cover, _feed_mask_r, feed_top, false);
draw_rectangle(_feed_mask_r - 11, feed_top, _feed_mask_r, feed_bottom, false);
_grad_rect(_feed_mask_l, feed_top, _feed_mask_r, feed_bottom, make_color_rgb(8, 21, 36), make_color_rgb(4, 11, 22), 18);
draw_set_alpha(0.20 + 0.12 * _anim);
draw_set_color(make_color_rgb(48, 166, 203));
draw_rectangle(_feed_mask_l, feed_top, _feed_mask_r, feed_top + 2, false);
draw_set_alpha(1);

draw_set_halign(fa_left);
for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (_y > feed_bottom + 12 || _y + post_h < feed_top - 12) continue;

    var _bloqueado = i + 1 > _liberada;
    var _hover = hover == i;
    var _post_shift = (_hover ? sin(menu_timer * 0.12) * 1.5 : 0);
    var _shake_x = (i == negado_card && negado_timer > 0) ? sin(negado_timer * 2.4) * negado_timer * 0.34 : 0;
    _y += _post_shift;
    var _card_x = feed_x + _shake_x;
    var _cor_post = _bloqueado ? make_color_rgb(11, 15, 22) : make_color_rgb(11, 25, 42);
    var _cor_borda = _bloqueado ? make_color_rgb(58, 67, 82) : (_hover ? make_color_rgb(130, 230, 255) : make_color_rgb(40, 111, 150));

    draw_set_alpha(_bloqueado ? 0.78 : 0.96);
    draw_set_color(_cor_post);
    draw_roundrect(_card_x, _y, _card_x + feed_w, _y + post_h, false);
    draw_set_alpha(_hover ? 0.9 : 0.46);
    draw_set_color(_cor_borda);
    draw_roundrect(_card_x, _y, _card_x + feed_w, _y + post_h, true);

    draw_set_alpha(1);
    draw_set_color(_bloqueado ? make_color_rgb(86, 96, 112) : make_color_rgb(94, 238, 255));
    draw_circle(_card_x + 24, _y + 24, 11, false);
    _glitch_text(_card_x + 44, _y + 20, fase_tag[i], 0.68, 0.68, _bloqueado ? make_color_rgb(132, 142, 158) : c_white, _glitch);
    draw_set_color(make_color_rgb(102, 123, 146));
    draw_text_transformed(_card_x + 44, _y + 40, "postagem #" + string(i + 1), 0.58, 0.58, 0);

    var _foto_x = _card_x + 18;
    var _foto_y = _y + 62;
    var _foto_w = 106;
    var _foto_h = 58;
    draw_set_alpha(_bloqueado ? 0.28 : 1);
    draw_set_color(make_color_rgb(2, 8, 16));
    draw_roundrect(_foto_x, _foto_y, _foto_x + _foto_w, _foto_y + _foto_h, false);
    draw_set_alpha(_bloqueado ? 0.18 : 0.42);
    draw_set_color(make_color_rgb(73, 166, 204));
    draw_roundrect(_foto_x, _foto_y, _foto_x + _foto_w, _foto_y + _foto_h, true);
    if (entrando_fase && fase_escolhida == i) {
        var _trans_t_img = clamp(transicao_post_timer / transicao_post_dur, 0, 1);
        var _luz = _trans_t_img * _trans_t_img * (3 - 2 * _trans_t_img);
        draw_set_alpha(0.22 + _luz * 0.58);
        draw_set_color(make_color_rgb(92, 222, 255));
        draw_rectangle(_foto_x - 12 - _luz * 18, _foto_y - 8 - _luz * 10, _foto_x + _foto_w + 12 + _luz * 18, _foto_y + _foto_h + 8 + _luz * 10, false);
        draw_set_alpha(0.34 + _luz * 0.42);
        draw_set_color(c_white);
        draw_rectangle(_foto_x - 4, _foto_y - 2, _foto_x + _foto_w + 4, _foto_y + _foto_h + 2, false);
    }
    var _spr = fase_foto[i];
    var _sw = sprite_get_width(_spr);
    var _sh = sprite_get_height(_spr);
    var _esc = min((_foto_w - 8) / max(1, _sw), (_foto_h - 8) / max(1, _sh));
    var _dx = _foto_x + (_foto_w - _sw * _esc) * 0.5;
    var _dy = _foto_y + (_foto_h - _sh * _esc) * 0.5;
    draw_set_alpha(_bloqueado ? 0.42 : 1);
    draw_sprite_part_ext(_spr, 0, 0, 0, _sw, _sh, _dx, _dy, _esc, _esc, c_white, _bloqueado ? 0.42 : 1);

    draw_set_alpha(1);
    _glitch_text(_card_x + 142, _y + 64, fase_nome[i], 0.76, 0.76, _bloqueado ? make_color_rgb(132, 142, 158) : c_white, _glitch);
    draw_set_color(_bloqueado ? make_color_rgb(91, 100, 116) : make_color_rgb(185, 205, 224));
    draw_text_ext_transformed(_card_x + 142, _y + 89, fase_desc[i], 16, 260, 0.62, 0.62, 0);

    draw_set_halign(fa_center);
    if (_bloqueado) {
        draw_sprite_ext(spr_ui_cadeado, 0, _card_x + feed_w - 42, _y + 30, 0.95, 0.95, 0, c_white, 0.9);
        draw_set_color(make_color_rgb(142, 153, 171));
        draw_text_transformed(_card_x + feed_w - 42, _y + 58, "bloqueado", 0.58, 0.58, 0);
    } else {
        _glitch_text(_card_x + feed_w - 46, _y + 32, "JOGAR", 0.68, 0.68, _hover ? make_color_rgb(255, 246, 152) : make_color_rgb(116, 231, 255), _glitch);
    }
    draw_set_halign(fa_left);
}

draw_set_alpha(1);
draw_set_color(_panel);
draw_rectangle(_feed_panel_x + 1, _feed_panel_y, _feed_panel_r, feed_top - 1, false);
draw_rectangle(_feed_mask_r - 11, feed_top, _feed_panel_r, feed_bottom, false);

draw_set_color(make_color_rgb(2, 7, 14));
draw_rectangle(_feed_mask_l, feed_top - _cover, _feed_mask_r, feed_top, false);
draw_rectangle(_feed_mask_r - 11, feed_top, _feed_mask_r, feed_bottom, false);
draw_set_color(_cyan_soft);
draw_rectangle(_feed_mask_l - 1, feed_top - 1, _feed_mask_r + 1, feed_top + 2, false);
draw_rectangle(_feed_mask_l - 1, feed_bottom - 2, _feed_mask_r + 1, feed_bottom, false);
draw_rectangle(_feed_mask_l, feed_top - 1, _feed_mask_l + 1, feed_bottom + 1, false);
draw_rectangle(_feed_mask_r - 2, feed_top - 1, _feed_mask_r + 1, feed_bottom + 1, false);

// Reaplica navbar/lateral para encobrir qualquer postagem que role por baixo.
_grad_rect(app_x, app_y, _divider_x, app_y + _header_h, make_color_rgb(7, 24, 42), make_color_rgb(3, 12, 23), 8);
_grad_rect(_divider_x, app_y, app_x + app_w, app_y + _header_h, make_color_rgb(9, 32, 51), make_color_rgb(4, 13, 25), 8);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(_divider_x - 5, app_y, _divider_x + 5, app_y + app_h, false);
draw_set_color(make_color_rgb(52, 139, 178));
draw_rectangle(_divider_x + 4, app_y, _divider_x + 5, app_y + app_h, false);
draw_set_color(make_color_rgb(28, 91, 128));
draw_rectangle(app_x, app_y + _header_h - 3, app_x + app_w, app_y + _header_h, false);

draw_set_color(make_color_rgb(13, 45, 69));
draw_rectangle(app_x + 14, app_y + 10, _divider_x - 18, app_y + 52, false);
draw_set_color(make_color_rgb(33, 115, 150));
draw_rectangle(app_x + 14, app_y + 10, _divider_x - 18, app_y + 52, true);
_glitch_text(app_x + 26, app_y + 31, "CONECTA", 0.86, 0.86, _cyan, _glitch);
draw_sprite_ext(spr_f2_sino, (menu_timer div 8) mod sprite_get_number(spr_f2_sino), app_x + 135, app_y + 31, 0.28, 0.28, 0, c_white, 0.95);
draw_set_color(make_color_rgb(59, 168, 202));
draw_rectangle(app_x + 156, app_y + 30, app_x + 202, app_y + 32, false);
draw_set_color(make_color_rgb(190, 244, 255));
draw_rectangle(app_x + 204, app_y + 29, app_x + 208, app_y + 33, false);
draw_set_color(make_color_rgb(8, 24, 40));
draw_rectangle(_divider_x + 22, app_y + 13, _divider_x + 154, app_y + 51, false);
draw_set_color(make_color_rgb(89, 225, 255));
draw_rectangle(_divider_x + 22, app_y + 13, _divider_x + 154, app_y + 51, true);
_glitch_text(_divider_x + 44, app_y + 32, "FEED", 0.64, 0.64, make_color_rgb(89, 225, 255), _glitch);
draw_set_color(make_color_rgb(14, 42, 62));
draw_rectangle(_divider_x + 166, app_y + 13, _divider_x + 366, app_y + 51, false);
draw_set_color(make_color_rgb(44, 128, 164));
draw_rectangle(_divider_x + 166, app_y + 13, _divider_x + 366, app_y + 51, true);
_glitch_text(_divider_x + 186, app_y + 32, "CASOS DIGITAIS", 0.56, 0.56, make_color_rgb(177, 215, 234), _glitch);
draw_set_halign(fa_right);
_glitch_text(app_x + app_w - 30, app_y + 22, "NeuroSys // rede social", 0.54, 0.54, make_color_rgb(78, 148, 178), _glitch);
_glitch_text(app_x + app_w - 30, app_y + 44, "Casos liberados: " + string(_liberada) + "/4", 0.62, 0.62, make_color_rgb(182, 220, 238), _glitch);
draw_set_halign(fa_left);

_grad_rect(app_x, app_y + _header_h, _divider_x - 5, app_y + app_h, make_color_rgb(5, 16, 30), _side_bg, 16);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
_glitch_text(app_x + 24, app_y + 90, "Painel de casos", 0.78, 0.78, make_color_rgb(124, 221, 248), _glitch);

draw_set_alpha(1);
_grad_rect(app_x + 18, app_y + 128, _divider_x - 18, app_y + 244, make_color_rgb(8, 28, 47), make_color_rgb(5, 16, 30), 8);
draw_set_color(make_color_rgb(32, 108, 145));
draw_rectangle(app_x + 18, app_y + 128, _divider_x - 18, app_y + 244, true);
_glitch_text(app_x + 30, app_y + 144, "Progresso", 0.62, 0.62, make_color_rgb(96, 226, 255), _glitch);
draw_set_color(make_color_rgb(151, 179, 202));
draw_text_ext_transformed(app_x + 30, app_y + 170, "Complete uma postagem para liberar a próxima.", 20, 190, 0.55, 0.55, 0);
draw_set_color(make_color_rgb(2, 8, 17));
draw_rectangle(app_x + 30, app_y + 222, _divider_x - 30, app_y + 230, false);
var _prog_w = (_divider_x - app_x - 60) * clamp(_concluidas / 4, 0, 1);
if (_prog_w > 0) {
    draw_set_color(make_color_rgb(89, 225, 255));
    draw_rectangle(app_x + 30, app_y + 222, app_x + 30 + _prog_w, app_y + 230, false);
}

_grad_rect(app_x + 18, app_y + 264, _divider_x - 18, app_y + 420, make_color_rgb(8, 28, 47), make_color_rgb(4, 13, 25), 10);
draw_set_color(make_color_rgb(32, 108, 145));
draw_rectangle(app_x + 18, app_y + 264, _divider_x - 18, app_y + 420, true);
_glitch_text(app_x + 30, app_y + 280, "Missão", 0.62, 0.62, make_color_rgb(96, 226, 255), _glitch);
draw_set_color(make_color_rgb(159, 178, 198));
draw_text_ext_transformed(app_x + 30, app_y + 306, "Role o feed e escolha o caso disponível. Os cadeados mostram o que ainda falta desbloquear.", 20, 190, 0.55, 0.55, 0);
draw_set_color(make_color_rgb(76, 143, 173));
draw_rectangle(app_x + 30, app_y + 392, _divider_x - 30, app_y + 394, false);
_glitch_text(app_x + 30, app_y + 398, "Clique em JOGAR para iniciar", 0.46, 0.46, make_color_rgb(151, 179, 202), _glitch);

var _btn_drift = sin(menu_timer * 0.035) * 1.4;
draw_set_alpha(0.62);
draw_set_color(make_color_rgb(8, 18, 31));
draw_rectangle(voltar_x - 8, voltar_y + 36 + _btn_drift, voltar_x + 8, gui_h + 8, false);
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(24, 70, 96));
draw_rectangle(voltar_x - 3, voltar_y + 34 + _btn_drift, voltar_x + 3, gui_h + 8, false);
draw_set_alpha(0.8);
draw_set_color(make_color_rgb(112, 198, 228));
draw_rectangle(voltar_x - 6, voltar_y + 34 + _btn_drift, voltar_x + 6, voltar_y + 44 + _btn_drift, false);
draw_set_alpha(1);
var _voltar_scale_sprite = voltar_hover ? 1.58 : 1.50;
draw_sprite_ext(voltar_sprite, voltar_hover ? 1 : 0, voltar_x, voltar_y + _btn_drift, _voltar_scale_sprite, _voltar_scale_sprite, 0, c_white, 1);

var _max_scroll = max(1, feed_altura - (feed_bottom - feed_top));
var _bar_h = max(42, (feed_bottom - feed_top) * ((feed_bottom - feed_top) / max(feed_altura, feed_bottom - feed_top)));
var _bar_y = feed_top + (feed_bottom - feed_top - _bar_h) * clamp(scroll_y / _max_scroll, 0, 1);
draw_set_alpha(1);
draw_set_color(make_color_rgb(14, 37, 57));
draw_rectangle(_scroll_x, feed_top + 3, _scroll_x + 9, feed_bottom - 3, false);
draw_set_color(make_color_rgb(105, 211, 244));
draw_rectangle(_scroll_x, max(feed_top + 3, _bar_y), _scroll_x + 9, min(feed_bottom - 3, _bar_y + _bar_h), false);

if (entrando_fase) {
    var _trans_t = clamp(transicao_post_timer / transicao_post_dur, 0, 1);
    var _soft = _trans_t * _trans_t * (3 - 2 * _trans_t);
    var _flash = 0.5 + 0.5 * sin(menu_timer * 0.55);
    draw_set_alpha(_soft * 0.72);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(clamp((_trans_t - 0.12) / 0.62, 0, 1) * (0.18 + _flash * 0.18));
    draw_set_color(make_color_rgb(77, 205, 255));
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(clamp((_trans_t - 0.42) / 0.58, 0, 1) * (0.18 + _flash * 0.16));
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

if (fade_saida_branco > 0) {
    draw_set_alpha(fade_saida_branco);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
