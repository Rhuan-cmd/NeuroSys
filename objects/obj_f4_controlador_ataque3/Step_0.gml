timer++;

// --- CONTROLE DE FASES ---
switch (fase) {
    case 0: // AVISO: Piscando na tela mirando no player
        // Faz piscar alternando a transparência a cada 5 frames
        alpha_desenho = (timer div 5) % 2 == 0 ? 0.3 : 0.8;

        if (timer >= 60) { // Após 1 segundo
            fase = 1;
            timer = 0;
            alpha_desenho = 1; // Fica totalmente visível
        }
        break;

    case 1: // ATIVO: Deslizando para o centro da tela
        // A função lerp move o X suavemente da posição atual para o centro
        x = lerp(x, room_width / 2, 0.08);
        y = lerp(y, room_height * 0.70, 0.08);
        
        // Aumentei o tempo para 40 (antes era 20) para dar tempo de chegar no centro
        if (timer >= 40) { 
            fase = 2;
            timer = 0;
        }
        break;

    case 2: // GIRANDO: Gira os graus definidos no centro da tela
        var velocidade_giro = 0.5; // Velocidade do giro por frame
        angulo_base += velocidade_giro * direcao_giro;
        graus_girados += velocidade_giro;
		
        if (graus_girados >= 90) { // Quando completar os 45 graus (como você definiu)
            fase = 3;
            timer = 0;
        }
        break;

    case 3: // SUMINDO: Desaparece suavemente
        alpha_desenho -= 0.05;
        if (alpha_desenho <= 0) {
            instance_destroy(); // Remove o ataque do jogo
        }
        break;
}

// --- SISTEMA DE COLISÃO / DANO ---
// Só dá dano nas fases 1 (Indo pro Centro) e 2 (Girando)
if ((fase == 1 or fase == 2) and instance_exists(obj_f4_nave)) {
    
    // Calcula as extremidades da Linha 1 (/)
    var x1_a = x + lengthdir_x(tamanho_linha, angulo_base);
    var y1_a = y + lengthdir_y(tamanho_linha, angulo_base);
    var x2_a = x + lengthdir_x(tamanho_linha, angulo_base + 180);
    var y2_a = y + lengthdir_y(tamanho_linha, angulo_base + 180);

    // Calcula as extremidades da Linha 2 (\)
    var x1_b = x + lengthdir_x(tamanho_linha, angulo_base + 90);
    var y1_b = y + lengthdir_y(tamanho_linha, angulo_base + 90);
    var x2_b = x + lengthdir_x(tamanho_linha, angulo_base + 270);
    var y2_b = y + lengthdir_y(tamanho_linha, angulo_base + 270);

    // Checa colisão
    var bateu_linha_1 = collision_line(x1_a, y1_a, x2_a, y2_a, obj_f4_nave, false, true);
    var bateu_linha_2 = collision_line(x1_b, y1_b, x2_b, y2_b, obj_f4_nave, false, true);

    if (bateu_linha_1 or bateu_linha_2) {
        obj_f4_nave.tomar_dano();
    }
}