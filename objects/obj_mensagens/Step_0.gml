// =================================================================
// 0. INICIALIZAÇÃO SEGURA DOS TEMPOS (Roda só no 1º frame do objeto)
// =================================================================
if (!iniciado) {
    if (!variable_instance_exists(id, "indice")) {
        indice = 1; // Se foi você que colocou na room, ele é o 1
    }

    if (indice >= 3) {
        // Do 3 em diante, já sai andando e tem o timer de cascata
        timer_inicio = 0;   
        timer_meio = 0;     
        timer_cascata = fps_jogo * 0.9; // 1.5 SEGUNDOS DE ESPAÇO ENTRE ELES
    } else {
        // Objetos 1 e 2 esperam 3 segundos e não fazem cascata rápida
        timer_inicio = fps_jogo * 3; 
        timer_meio = fps_jogo * 3;   
        timer_cascata = -1; 
    }
    
    iniciado = true; // Trava para não rodar isso de novo
}

// =================================================================
// 1. LÓGICA DE SPAWN (QUEM CRIA O PRÓXIMO?)
// =================================================================
if (!proximo_criado) {
    if (indice < 3) {
        // OBJETOS 1 E 2: Só criam o próximo quando chegam lá embaixo
        if (y >= destino_y) {
            var _inst = instance_create_layer(89, 210, layer, object_index);
            _inst.indice = indice + 1;
            proximo_criado = true;
        }
    } 
    else {
        // OBJETOS 3 EM DIANTE: Criam o próximo após o timer de cascata (1.5s)
        timer_cascata--;
        if (timer_cascata <= 0) {
            var _inst = instance_create_layer(89, 210, layer, object_index);
            _inst.indice = indice + 1;
            proximo_criado = true; 
        }
    }
}

// =================================================================
// 2. MOVIMENTAÇÃO E ANIMAÇÃO
// =================================================================
switch (estado) {
    case 0: // Espera inicial (89x)
        if (timer_inicio > 0) timer_inicio--;
        else estado = 1;
        break;

    case 1: // Indo para o centro (376x) constante, sem lerp pra não atropelar
        x += 10; 
        if (x >= destino_x) {
            x = destino_x;
            estado = 2;
        }
        break;

    case 2: // Espera no centro (376x, 210y)
        if (timer_meio > 0) timer_meio--;
        else estado = 3;
        break;

    case 3: // Descida constante
        y += velocidade_descida;
        break;
}

// =================================================================
// 3. DESTRUIÇÃO
// =================================================================
if (y >= destino_y + 200) { 
    instance_destroy();
}