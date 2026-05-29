draw_set_alpha(1);

var cursor_visivel = estado_final == 0 || final_painel;
if (cursor_visivel) {
    var fade_alpha = max(0, 1 - cutscene_timer / fade_duracao);
    var cursor_alpha = 1;
    if (estado_final == 0) {
        cursor_alpha = 1 - fade_alpha * 0.72;
    } else {
        cursor_alpha = final_transition;
    }
    
    var cursor_forca = 0;
    if (estado_final == 0) {
        cursor_forca = max(0, shake_impacto * 0.12 + shake_inicio * 0.5 + (vidas_max - vidas) * 0.75);
    }
    
    var cursor_x = cursor_draw_x;
    var cursor_y = cursor_draw_y;
    if (estado_final == 0) {
        cursor_x += sin(current_time * 0.015) * (1.1 + cursor_forca * 0.16);
        cursor_y += cos(current_time * 0.017) * (0.9 + cursor_forca * 0.14);
    }
    if (estado_final == 0 && cursor_forca > 0) {
        cursor_x += random_range(-cursor_forca, cursor_forca);
        cursor_y += random_range(-cursor_forca, cursor_forca);
    }
    
    draw_set_alpha(cursor_alpha);
    draw_sprite_ext(
        spr_f2_cursor,
        0,
        cursor_x,
        cursor_y,
        1,
        1,
        sin(current_time * 0.012) * min(7, cursor_forca),
        c_white,
        cursor_alpha
    );
    draw_set_alpha(1);
}
