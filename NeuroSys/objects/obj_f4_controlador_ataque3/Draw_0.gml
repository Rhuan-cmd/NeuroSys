// Recalcula as pontas apenas para desenhar
var x1_a = x + lengthdir_x(tamanho_linha, angulo_base);
var y1_a = y + lengthdir_y(tamanho_linha, angulo_base);
var x2_a = x + lengthdir_x(tamanho_linha, angulo_base + 180);
var y2_a = y + lengthdir_y(tamanho_linha, angulo_base + 180);

var x1_b = x + lengthdir_x(tamanho_linha, angulo_base + 90);
var y1_b = y + lengthdir_y(tamanho_linha, angulo_base + 90);
var x2_b = x + lengthdir_x(tamanho_linha, angulo_base + 270);
var y2_b = y + lengthdir_y(tamanho_linha, angulo_base + 270);

draw_set_alpha(alpha_desenho);

// Desenha a base vermelha mais grossa
draw_line_width_color(x1_a, y1_a, x2_a, y2_a, espessura, c_red, c_red);
draw_line_width_color(x1_b, y1_b, x2_b, y2_b, espessura, c_red, c_red);

// Só desenha o "núcleo" branco brilhante quando o ataque está ativo (fase 1 e 2)
if (fase >= 1) {
    draw_line_width_color(x1_a, y1_a, x2_a, y2_a, espessura / 2, c_white, c_white);
    draw_line_width_color(x1_b, y1_b, x2_b, y2_b, espessura / 2, c_white, c_white);
}

draw_set_alpha(1); // Reseta a opacidade pro resto do jogo não ficar transparente