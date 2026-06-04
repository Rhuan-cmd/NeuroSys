var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.08);

for (var edge = 0; edge < 22; edge += 1) {
    var a = sqr(edge / 21) * 0.034;
    var margin_x = edge * 7;
    var margin_y = edge * 5;
    draw_set_alpha(a);
    draw_set_color(c_black);
    draw_roundrect(margin_x, margin_y, gui_w - margin_x, gui_h - margin_y, true);
}

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(botao_sprite); i += 1) {
    var frame = 0;
    var scale = 1;
    var texto_cor = make_color_rgb(218, 241, 248);
    if (botao_hover == i) {
        frame = 1;
        scale = 1.04;
        texto_cor = c_white;
    }
    var drift = sin(menu_timer * 0.035 + i) * 1.4;
    draw_sprite_ext(botao_sprite[i], frame, botao_x, botao_y[i] + drift, scale, scale, 0, c_white, 1);
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_text_transformed(botao_x + 2, botao_y[i] + drift + 2, botao_texto[i], 1, 1, 0);
    draw_set_color(texto_cor);
    draw_text_transformed(botao_x, botao_y[i] + drift, botao_texto[i], 1, 1, 0);
}

if (clique_iniciado) {
    var fade = 1 - clamp(menu_saida_timer / max(1, round(room_speed * 0.82)), 0, 1);
    var soft = fade * fade * (3 - 2 * fade);
    draw_set_alpha(soft * 0.34);
    draw_set_color(make_color_rgb(108, 186, 255));
    draw_rectangle(0, 0, gui_w, gui_h, false);

    draw_set_alpha(clamp((fade - 0.34) / 0.66, 0, 1) * 0.82);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
