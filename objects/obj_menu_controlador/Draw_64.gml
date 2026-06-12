var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.08);
var _fx_qualidade = variable_global_exists("fx_qualidade") ? global.fx_qualidade : 2;
var _creditos_liberados = variable_global_exists("fase_concluida") && global.fase_concluida >= 4;

var _edge_step = _fx_qualidade <= 0 ? 6 : (_fx_qualidade == 1 ? 4 : 2);
for (var edge = 0; edge < 18; edge += _edge_step) {
    var a = sqr(1 - edge / 18) * 0.045;
    var thick_x = 16 + edge * 8;
    var thick_y = 12 + edge * 6;
    draw_set_alpha(a);
    draw_set_color(c_black);
    draw_rectangle(0, 0, thick_x, gui_h, false);
    draw_rectangle(gui_w - thick_x, 0, gui_w, gui_h, false);
    draw_rectangle(0, 0, gui_w, thick_y, false);
    draw_rectangle(0, gui_h - thick_y, gui_w, gui_h, false);
}

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var titulo_x = botao_x;
var titulo_y = botao_y[0] - 58 + (_fx_qualidade > 0 ? sin(menu_timer * 0.035) * 2.2 : 0);
var titulo_glitch = _fx_qualidade > 0 && ((menu_timer div 5) mod 9) == 0;
var titulo_shift = titulo_glitch ? choose(-3, -2, 2, 3) : (_fx_qualidade > 0 ? sin(menu_timer * 0.13) : 0);
draw_set_alpha(1);
draw_set_alpha(0.68);
draw_set_color(make_color_rgb(242, 74, 124));
draw_text_transformed(titulo_x + titulo_shift + 2, titulo_y - 2, "NeuroSys", 1.52, 1.52, 0);
draw_set_color(make_color_rgb(31, 214, 181));
draw_text_transformed(titulo_x - titulo_shift - 2, titulo_y + 2, "NeuroSys", 1.52, 1.52, 0);
draw_set_alpha(1);
draw_set_color(make_color_rgb(226, 248, 255));
draw_text_transformed(titulo_x, titulo_y + (_fx_qualidade > 0 ? sin(menu_timer * 0.08) * 1.2 : 0), "NeuroSys", 1.52, 1.52, 0);

for (var i = 0; i < array_length(botao_sprite); i += 1) {
    var bloqueado = (i == 2 && !_creditos_liberados);
    var frame = 0;
    var scale = 1;
    var texto_cor = make_color_rgb(218, 241, 248);
    if (botao_hover == i && !bloqueado) {
        frame = 1;
        scale = 1.04;
        texto_cor = c_white;
    }
    if (bloqueado) {
        scale = 0.98;
        texto_cor = make_color_rgb(120, 139, 156);
    }
    var drift = _fx_qualidade > 0 ? sin(menu_timer * 0.035 + i) * 1.4 : 0;
    var lock_shake = (bloqueado && creditos_bloqueado_timer > 0) ? sin(creditos_bloqueado_timer * 2.4) * 4 : 0;
    var draw_y = botao_y[i] + drift + lock_shake;

    draw_set_alpha(0.62);
    draw_set_color(make_color_rgb(8, 18, 31));
    draw_rectangle(botao_x + 108, draw_y - 8, gui_w + 8, draw_y + 8, false);

    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(24, 70, 96));
    draw_rectangle(botao_x + 104, draw_y - 3, gui_w + 8, draw_y + 3, false);

    draw_set_alpha(0.8);
    draw_set_color(make_color_rgb(112, 198, 228));
    draw_rectangle(botao_x + 104, draw_y - 6, botao_x + 114, draw_y + 6, false);

    draw_set_alpha(bloqueado ? 0.42 : 1);
    draw_sprite_ext(botao_sprite[i], frame, botao_x, draw_y, scale, scale, 0, c_white, bloqueado ? 0.42 : 1);
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_text_transformed(botao_x + 2, draw_y + 2, botao_texto[i], 1, 1, 0);
    draw_set_color(texto_cor);
    draw_text_transformed(botao_x, draw_y, botao_texto[i], 1, 1, 0);
    if (bloqueado) {
        draw_set_color(make_color_rgb(255, 216, 132));
        draw_text_transformed(botao_x, draw_y + 25, "BLOQUEADO", 0.52, 0.52, 0);
    }
}

if (confirmar_sair) {
    var _confirm_p = clamp(confirmar_sair_timer / max(1, room_speed * 0.22), 0, 1);
    var _confirm_s = _confirm_p * _confirm_p * (3 - 2 * _confirm_p);
    var _confirm_scale = lerp(0.92, 1, _confirm_s);
    var _confirm_cx = 505;
    var _confirm_cy = 312;
    var _confirm_w = 490 * _confirm_scale;
    var _confirm_h = 230 * _confirm_scale;
    var _confirm_x1 = _confirm_cx - _confirm_w * 0.5;
    var _confirm_y1 = _confirm_cy - _confirm_h * 0.5;
    var _confirm_x2 = _confirm_cx + _confirm_w * 0.5;
    var _confirm_y2 = _confirm_cy + _confirm_h * 0.5;
    var _confirm_pulse = 0.5 + 0.5 * sin(menu_timer * 0.12);

    draw_set_alpha(0.68 * _confirm_s);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);

    draw_set_alpha(0.42 * _confirm_s);
    draw_set_color(c_black);
    draw_roundrect(_confirm_x1 + 8, _confirm_y1 + 10, _confirm_x2 + 10, _confirm_y2 + 12, false);

    draw_set_alpha(_confirm_s);
    draw_set_color(make_color_rgb(5, 20, 37));
    draw_roundrect(_confirm_x1, _confirm_y1, _confirm_x2, _confirm_y2, false);
    draw_set_color(make_color_rgb(9, 44, 67));
    draw_rectangle(_confirm_x1 + 8, _confirm_y1 + 8, _confirm_x2 - 8, _confirm_y1 + 62, false);
    draw_set_color(make_color_rgb(4, 12, 23));
    draw_rectangle(_confirm_x1 + 12, _confirm_y1 + 82, _confirm_x2 - 12, _confirm_y2 - 18, false);
    draw_set_color(make_color_rgb(90 + _confirm_pulse * 25, 225, 255));
    draw_roundrect(_confirm_x1, _confirm_y1, _confirm_x2, _confirm_y2, true);
    draw_set_alpha(0.55 * _confirm_s);
    draw_set_color(make_color_rgb(80, 227, 255));
    draw_line_width(_confirm_x1 + 32, _confirm_y1 + 70, _confirm_x2 - 32, _confirm_y1 + 70, 2);
    draw_set_alpha(_confirm_s);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(0.75 * _confirm_s);
    draw_set_color(make_color_rgb(242, 74, 124));
    draw_text_transformed(508, 238, "CONFIRMAR SAÍDA", 1.02, 1.02, 0);
    draw_set_color(make_color_rgb(31, 214, 181));
    draw_text_transformed(502, 242, "CONFIRMAR SAÍDA", 1.02, 1.02, 0);
    draw_set_alpha(_confirm_s);
    draw_set_color(make_color_rgb(226, 248, 255));
    draw_text_transformed(505, 240, "CONFIRMAR SAÍDA", 1.02, 1.02, 0);
    draw_set_color(make_color_rgb(165, 187, 206));
    draw_text_ext_transformed(505, 295, "Tem certeza que deseja fechar o NeuroSys?\nSeu progresso salvo será mantido.", 20, 410, 0.64, 0.64, 0);

    var _confirm_txt = ["SAIR", "VOLTAR"];
    for (var _c = 0; _c < 2; _c += 1) {
        var _x1 = _c == 0 ? 334 : 526;
        var _y1 = 346;
        var _x2 = _x1 + 150;
        var _y2 = 404;
        var _hover = hover_confirmar_sair == _c;
        var _btn_col = _c == 0 ? make_color_rgb(86, 24, 42) : make_color_rgb(7, 38, 56);
        var _btn_hover = _c == 0 ? make_color_rgb(132, 36, 58) : make_color_rgb(20, 83, 109);
        draw_set_color(_hover ? _btn_hover : _btn_col);
        draw_roundrect(_x1, _y1, _x2, _y2, false);
        draw_set_alpha((_hover ? 0.95 : 0.62) * _confirm_s);
        draw_set_color(_hover ? make_color_rgb(120, 236, 255) : make_color_rgb(46, 129, 163));
        draw_roundrect(_x1, _y1, _x2, _y2, true);
        draw_set_alpha(0.45 * _confirm_s);
        draw_set_color(c_white);
        draw_rectangle(_x1 + 10, _y1 + 8, _x2 - 10, _y1 + 15, false);
        draw_set_alpha(_confirm_s);
        draw_set_color(_hover ? make_color_rgb(255, 232, 138) : c_white);
        draw_text_transformed((_x1 + _x2) * 0.5, (_y1 + _y2) * 0.5 + 2, _confirm_txt[_c], 0.78, 0.78, 0);
    }
}

if (clique_iniciado) {
    var fade = 1 - clamp(menu_saida_timer / max(1, round(room_speed * 0.82)), 0, 1);
    var soft = fade * fade * (3 - 2 * fade);
    var flash = 0.5 + 0.5 * sin(menu_timer * 0.72);

    if (menu_saindo_jogo) {
        draw_set_alpha(soft);
        draw_set_color(c_black);
        draw_rectangle(0, 0, gui_w, gui_h, false);
    } else {
        draw_set_alpha(soft * 0.26);
        draw_set_color(make_color_rgb(108, 186, 255));
        draw_rectangle(0, 0, gui_w, gui_h, false);

        draw_set_alpha(clamp((fade - 0.16) / 0.84, 0, 1) * (0.45 + flash * 0.28));
        draw_set_color(c_white);
        draw_rectangle(0, 0, gui_w, gui_h, false);
    }
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
