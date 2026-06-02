var _w = display_get_gui_width();
var _h = display_get_gui_height();
var _t = timer / room_speed;

draw_set_color(make_color_rgb(3, 9, 22));
draw_rectangle(0, 0, _w, _h, false);

for (var _i = 0; _i < 34; _i++) {
    var _sx = (_i * 83 + timer * (0.24 + (_i mod 3) * 0.08)) mod (_w + 80) - 40;
    var _sy = 40 + ((_i * 47) mod (_h - 80));
    draw_set_alpha(0.12 + ((_i mod 4) * 0.035));
    draw_set_color(make_color_rgb(87, 225, 255));
    draw_circle(_sx, _sy, 1 + (_i mod 2), false);
}

for (var _m = 0; _m < array_length(memorias); _m++) {
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
draw_set_valign(fa_middle);

if (timer < creditos_inicio) {
    var _abre = clamp(timer / (room_speed * 0.9), 0, 1);
    var _some = clamp((creditos_inicio - timer) / (room_speed * 0.85), 0, 1);
    var _alpha_parabens = min(_abre, _some);
    draw_set_alpha(_alpha_parabens);
    draw_set_color(make_color_rgb(94, 238, 255));
    draw_text_transformed(_w / 2, 214, "PARABÉNS!", 2.1, 2.1, 0);
    draw_set_color(c_white);
    draw_text_transformed(_w / 2, 276, "Você interrompeu o ciclo de cyberbullying.", 1.08, 1.08, 0);
    draw_set_color(make_color_rgb(172, 199, 230));
    draw_text(_w / 2, 314, "Cada atitude responsável ajuda a tornar a rede mais segura.");
} else {
    var _entrada = clamp((timer - creditos_inicio) / (room_speed * 0.8), 0, 1);
    var _scroll = max(0, (timer - creditos_inicio) * 0.34);
    draw_set_alpha(_entrada);
    draw_set_color(make_color_rgb(94, 238, 255));
    draw_text_transformed(_w / 2, 92 - _scroll * 0.08, "CYBERBULLYING GAME 2.0", 1.45, 1.45, 0);
    draw_set_color(c_white);
    draw_text(_w / 2, 160 - _scroll * 0.08, "Uma experiência sobre respeito, apoio e responsabilidade digital.");

    draw_set_color(make_color_rgb(255, 232, 138));
    draw_text(_w / 2, 242 - _scroll * 0.18, "AGRADECIMENTOS");
    draw_set_color(c_white);
    draw_text(_w / 2, 282 - _scroll * 0.18, "IFMA Campus Açailândia");
    draw_text(_w / 2, 316 - _scroll * 0.18, "Orientador: Valter dos Santos Mendonça Neto");

    draw_set_color(make_color_rgb(255, 232, 138));
    draw_text(_w / 2, 404 - _scroll * 0.28, "CRIADORES");
    draw_set_color(c_white);
    draw_text(_w / 2, 444 - _scroll * 0.28, "Hugo Oliveira Silva");
    draw_text(_w / 2, 478 - _scroll * 0.28, "Rhuan Gabriel Moura Brasilino");

    if (timer > room_speed * 18) {
        draw_set_alpha(clamp((timer - room_speed * 18) / (room_speed * 1.2), 0, 1));
        draw_set_color(make_color_rgb(94, 238, 255));
        draw_text_transformed(_w / 2, 214, "OBRIGADO POR JOGAR", 1.6, 1.6, 0);
        draw_set_color(c_white);
        draw_text(_w / 2, 268, "Leve essa mensagem para além da tela.");
    }
    if (timer > room_speed * 22) {
        draw_set_alpha(0.46 + sin(current_time * 0.008) * 0.34);
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
