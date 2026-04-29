// Trava a mira na posição atual do jogador
if (instance_exists(obj_nave)) {
    x = obj_nave.x;
    y = obj_nave.y;
} else {
    // Caso o player já tenha morrido, vai pro centro da tela
    x = room_width / 2;
    y = room_height / 2; 
}

fase = 0; // 0: Piscando (Aviso), 1: Indo pro Centro (Dano), 2: Girando, 3: Sumindo
timer = 0;

angulo_base = 45; // 45 graus forma um 'X' perfeito
tamanho_linha = 2000; // Valor alto para garantir que as pontas saiam da tela
espessura = 20; // Grossura do ataque (ajuste como quiser)

// Define se vai girar para a direita (-1) ou esquerda (1) aleatoriamente
direcao_giro = choose(1, -1);
graus_girados = 0;

alpha_desenho = 0; // Transparência do ataque