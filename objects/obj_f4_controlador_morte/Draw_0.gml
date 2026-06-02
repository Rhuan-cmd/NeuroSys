if (desenhar) {
    draw_sprite_ext(spr_f4_vilao_chorando, 0, xboss, yboss, -1, 1, 0, c_white, 1);
}

if (fade_saida > 0) {
    draw_set_alpha(fade_saida);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
