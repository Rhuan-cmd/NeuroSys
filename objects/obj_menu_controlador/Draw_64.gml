var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var pulse = 0.5 + 0.5 * sin(menu_timer * 0.08);

for (var edge = 0; edge < 26; edge += 1) {
    var a = sqr(1 - edge / 26) * 0.035;
    var thick_x = 14 + edge * 7;
    var thick_y = 10 + edge * 5;
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

    draw_set_alpha(0.62);
    draw_set_color(make_color_rgb(8, 18, 31));
    draw_rectangle(botao_x + 108, botao_y[i] - 8 + drift, gui_w + 8, botao_y[i] + 8 + drift, false);

    draw_set_alpha(0.92);
    draw_set_color(make_color_rgb(24, 70, 96));
    draw_rectangle(botao_x + 104, botao_y[i] - 3 + drift, gui_w + 8, botao_y[i] + 3 + drift, false);

    draw_set_alpha(0.8);
    draw_set_color(make_color_rgb(112, 198, 228));
    draw_rectangle(botao_x + 104, botao_y[i] - 6 + drift, botao_x + 114, botao_y[i] + 6 + drift, false);

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
    var flash = 0.5 + 0.5 * sin(menu_timer * 0.72);

    draw_set_alpha(soft * 0.26);
    draw_set_color(make_color_rgb(108, 186, 255));
    draw_rectangle(0, 0, gui_w, gui_h, false);

    draw_set_alpha(clamp((fade - 0.16) / 0.84, 0, 1) * (0.45 + flash * 0.28));
    draw_set_color(c_white);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
