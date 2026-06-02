// ===== CURSOR CUSTOMIZADO DESENHADO ACIMA DA INTERFACE =====
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
        cursor_x += sin(current_time * 0.028) * cursor_forca;
        cursor_y += cos(current_time * 0.025) * cursor_forca;
    }

    // ===== IMPACTO VISUAL DO PODER DE REPELAO =====
    if (repel_fx_timer > 0) {
        var repel_t = 1 - repel_fx_timer / 20;
        draw_set_alpha((1 - repel_t) * 0.72);
        draw_set_color(make_color_rgb(82, 218, 255));
        draw_circle(repel_fx_x, repel_fx_y, lerp(14, 92, repel_t), true);
        draw_circle(repel_fx_x, repel_fx_y, lerp(10, 66, repel_t), true);
        draw_set_color(c_white);
    }

    // ===== INVESTIDA DO X ATE O CURSOR =====
    if (poder_ataque_timer > 0) {
        var ataque_t = 1 - poder_ataque_timer / poder_ataque_total;
        var ataque_suave = ataque_t * ataque_t * (3 - 2 * ataque_t);
        var ataque_x = lerp(poder_ataque_x0, poder_ataque_x1, ataque_suave);
        var ataque_y = lerp(poder_ataque_y0, poder_ataque_y1, ataque_suave);
        var ataque_cor = poder_ataque_tipo == 1 ? make_color_rgb(92, 218, 255) : make_color_rgb(255, 104, 118);
        draw_set_color(ataque_cor);
        for (var ataque_i = 1; ataque_i <= 4; ataque_i++) {
            var ataque_rastro_t = max(0, ataque_suave - ataque_i * 0.075);
            draw_set_alpha(0.18 - ataque_i * 0.025);
            draw_sprite_ext(
                spr_f2_fechar,
                0,
                lerp(poder_ataque_x0, poder_ataque_x1, ataque_rastro_t),
                lerp(poder_ataque_y0, poder_ataque_y1, ataque_rastro_t),
                0.86,
                0.86,
                ataque_t * 28,
                ataque_cor,
                0.18 - ataque_i * 0.025
            );
        }
        draw_set_alpha(0.88);
        draw_sprite_ext(spr_f2_fechar, 0, ataque_x, ataque_y, 0.94, 0.94, ataque_t * 28, ataque_cor, 0.88);
        draw_set_alpha(0.3 * ataque_t);
        draw_circle(poder_ataque_x1 + 7, poder_ataque_y1 + 9, lerp(8, 28, ataque_t), true);
        draw_set_color(c_white);
    }

    // ===== CONTORNO E PREENCHIMENTO DO CURSOR CONGELADO =====
    var cursor_cor = congelado_timer > 0 ? make_color_rgb(166, 239, 255) : c_white;
    var cursor_escala = congelado_timer > 0 ? 1 + sin(current_time * 0.018) * 0.035 : 1;
    var cursor_rotacao = sin(current_time * 0.012) * min(7, cursor_forca);
    if (congelado_timer > 0) {
        var contorno_cor = make_color_rgb(12, 62, 116);
        draw_set_alpha(cursor_alpha * 0.96);
        for (var contorno_i = 0; contorno_i < 4; contorno_i++) {
            var contorno_dir = contorno_i * 90;
            draw_sprite_ext(
                spr_f2_cursor,
                0,
                cursor_x + lengthdir_x(2.5, contorno_dir),
                cursor_y + lengthdir_y(2.5, contorno_dir),
                cursor_escala,
                cursor_escala,
                cursor_rotacao,
                contorno_cor,
                cursor_alpha * 0.96
            );
        }
    }
    draw_set_alpha(cursor_alpha);
    draw_sprite_ext(
        spr_f2_cursor,
        0,
        cursor_x,
        cursor_y,
        cursor_escala,
        cursor_escala,
        cursor_rotacao,
        cursor_cor,
        cursor_alpha
    );

    if (congelado_timer > 0) {
        var gelo_t = 1 - congelado_timer / congelado_total;
        var gelo_entrada = clamp(gelo_t / 0.24, 0, 1);
        var gelo_pulso = 1 + sin(current_time * 0.02) * 0.06;
        draw_set_alpha((1 - gelo_t) * 0.24);
        draw_set_color(make_color_rgb(72, 188, 255));
        draw_circle(cursor_x + 7, cursor_y + 9, lerp(34, 24, gelo_entrada) * gelo_pulso, true);
        draw_set_alpha(0.78);
        draw_set_color(make_color_rgb(188, 244, 255));
        draw_circle(cursor_x + 4, cursor_y + 8, 2.2, false);
        draw_circle(cursor_x + 13, cursor_y + 17, 1.8, false);
        draw_circle(cursor_x + 19, cursor_y + 27, 2.0, false);
    }

    // ===== ESTILHACOS AO QUEBRAR O GELO =====
    if (gelo_quebra_timer > 0) {
        var quebra_t = 1 - gelo_quebra_timer / 18;
        draw_set_alpha(1 - quebra_t);
        draw_set_color(make_color_rgb(164, 239, 255));
        for (var gelo_i = 0; gelo_i < 5; gelo_i++) {
            var gelo_dir = gelo_i * 72 + 18;
            var gelo_dist = lerp(8, 42, quebra_t);
            var pedaco_x = cursor_x + lengthdir_x(gelo_dist, gelo_dir);
            var pedaco_y = cursor_y + lengthdir_y(gelo_dist, gelo_dir);
            draw_circle(pedaco_x, pedaco_y, lerp(4, 1, quebra_t), false);
        }
    }
    draw_set_alpha(1);
    draw_set_color(c_white);
}
