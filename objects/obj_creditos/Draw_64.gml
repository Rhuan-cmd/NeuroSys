var _w = display_get_gui_width();
var _h = display_get_gui_height();
var _t = timer / room_speed;

draw_set_color(make_color_rgb(3, 9, 22));
draw_rectangle(0, 0, _w, _h, false);

for (var _i = 0; _i < 10; _i++) {
    var _sx = (_i * 83 + timer * (0.24 + (_i mod 3) * 0.08)) mod (_w + 80) - 40;
    var _sy = 40 + ((_i * 47) mod (_h - 80));
    draw_set_alpha(0.12 + ((_i mod 4) * 0.035));
    draw_set_color(make_color_rgb(87, 225, 255));
    draw_circle(_sx, _sy, 1 + (_i mod 2), false);
}

for (var _m = 0; _m < array_length(memorias); _m += 2) {
    var _fase = _t * 0.46 + _m * 1.22;
    var _alpha = clamp(sin(_fase) * 0.22 + 0.24, 0.04, 0.38);
    var _mx = 124 + _m * 178 + sin(_fase * 0.8) * 28;
    var _my = 112 + ((_m mod 2) * 238) + cos(_fase) * 22;
    var _escala = 0.58 + sin(_fase * 0.7) * 0.05;
    draw_set_alpha(_alpha);
    draw_sprite_ext(memorias[_m], 0, _mx, _my, _escala, _escala, sin(_fase) * 4, c_white, _alpha);
}

draw_set_font(fnt_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if (!etapa_final) {
    var _cy = _h + 80 - creditos_scroll;
    for (var _c = 0; _c < array_length(creditos); _c++) {
        var _credito = creditos[_c];
        if (_cy > -180 && _cy < _h + 180) {
            draw_set_alpha(clamp((timer - creditos_inicio) / (room_speed * 0.8), 0, 1));
            draw_set_color(_credito.cor);
            draw_text_ext_transformed(_w / 2, _cy, _credito.texto, 22, 720, _credito.escala, _credito.escala, 0);
        }
        _cy += _credito.espaco;
    }

    var _hint_alpha = 0.74 + sin(current_time * 0.006) * 0.12;
    var _hint_x1 = _w - 278;
    var _hint_y1 = _h - 92;
    draw_set_alpha(0.78);
    draw_set_color(make_color_rgb(4, 15, 30));
    draw_roundrect(_hint_x1, _hint_y1, _w - 18, _h - 18, false);
    draw_set_alpha(0.48);
    draw_set_color(make_color_rgb(31, 109, 142));
    draw_roundrect(_hint_x1 + 5, _hint_y1 + 5, _w - 23, _h - 23, true);
    draw_set_alpha(_hint_alpha);
    draw_set_color(make_color_rgb(94, 238, 255));
    draw_roundrect(_hint_x1 + 2, _hint_y1 + 2, _w - 20, _h - 20, true);
    draw_set_alpha(0.9);
    draw_set_color(make_color_rgb(94, 238, 255));
    draw_rectangle(_hint_x1 + 14, _hint_y1 + 18, _hint_x1 + 18, _h - 36, false);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_ext(_hint_x1 + 30, _hint_y1 + 18, "SEGURE ENTER\npara acelerar os créditos", 20, 240);
    draw_set_halign(fa_center);
} else {
    var _alpha_final = clamp(timer_final / (room_speed * 1.2), 0, 1);
    draw_set_alpha(_alpha_final);
    draw_set_color(make_color_rgb(94, 238, 255));
    draw_text_transformed(_w / 2, 230, "OBRIGADO POR JOGAR", 1.75, 1.75, 0);
    draw_set_color(c_white);
    draw_text(_w / 2, 286, "Leve essa mensagem para além da tela.");
    if (timer_final > room_speed * 3 && !encerrando) {
        draw_set_alpha(_alpha_final * (0.46 + sin(current_time * 0.008) * 0.34));
        draw_set_color(make_color_rgb(255, 232, 138));
        draw_text(_w / 2, 492, "ENTER ou clique para encerrar");
    }
}

draw_set_alpha(max(fade_entrada, fade_saida));
draw_set_color(c_black);
draw_rectangle(0, 0, _w, _h, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
