timer++;

// --- CONTROLE DE FASES ---
switch (fase) {
    case 0: // AVISO: Piscando na tela
        // Faz piscar alternando a transparência a cada 5 frames
        alpha_desenho = (timer div 5) % 2 == 0 ? 0.3 : 0.8;

        if (timer >= 60) { // Após 1 segundo (considerando 60 FPS)
            fase = 1;
            timer = 0;
            alpha_desenho = 1; // Fica totalmente visível
        }
        break;

    case 1: // ATIVO: Parado por um breve momento
        if (timer >= 20) { // Espera um terço de segundo antes de começar a girar
            fase = 2;
            timer = 0;
        }
        break;

    case 2: // GIRANDO: Gira 90 graus
        var velocidade_giro = 1; // Velocidade do giro por frame
        angulo_base += velocidade_giro * direcao_giro;
        graus_girados += velocidade_giro;

        if (graus_girados >= 45) { // Quando completar 90 graus
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
// Só dá dano nas fases 1 (Parado) e 2 (Girando)
if ((fase == 1 or fase == 2) and instance_exists(obj_nave)) {
    
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

    // Checa se alguma das duas linhas bateu no player
    // Obs: Troque "obj_player" para o nome exato do seu objeto do jogador
    var bateu_linha_1 = collision_line(x1_a, y1_a, x2_a, y2_a, obj_nave, false, true);
    var bateu_linha_2 = collision_line(x1_b, y1_b, x2_b, y2_b, obj_nave, false, true);

    if (bateu_linha_1 or bateu_linha_2) {
        // Coloque seu código de dano aqui!
        // Exemplo: obj_player.vida -= 1;
    }
}