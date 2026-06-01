var num_linhas = 15;
var espacamento = room_height / num_linhas;

// Atualiza a posição do loop
pos_y += velocidade_chao;
if (pos_y >= 1) pos_y -= 1;

draw_set_color(c_blue); // Cor da grade

for (var i = 0; i < num_linhas; i++) {
    // A mágica: usamos uma função exponencial ou poder para criar perspectiva
    // Quanto mais longe do ponto de fuga, mais espaçadas as linhas ficam
    var linha_t = (i + pos_y) / num_linhas;
    var yy = lerp(ponto_fuga_y, room_height, power(linha_t, 2)); 
    
    draw_line(0, yy, room_width, yy);
}