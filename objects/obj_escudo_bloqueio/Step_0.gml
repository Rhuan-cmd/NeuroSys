// 1. Defina quem é o objeto central e o raio da órbita
var objeto_centro = obj_npc_fase4; // Altere para o nome do seu objeto central
var raio = 64;                  // A distância que ele ficará do centro

if (instance_exists(objeto_centro)) {
    // 2. Calcula o ângulo do centro para o mouse
    var angulo = point_direction(objeto_centro.x, objeto_centro.y, mouse_x, mouse_y);

    // 3. Posiciona o objeto no raio definido ao redor do centro
    /*x = objeto_centro.x + lengthdir_x(raio, angulo);
    y = objeto_centro.y + lengthdir_y(raio, angulo);*/
	
	x = lerp(x, objeto_centro.x + lengthdir_x(raio, angulo), 0.3);
    y = lerp(y, objeto_centro.y + lengthdir_y(raio, angulo), 0.3);
	
    // 4. Faz o próprio objeto "olhar" para o mouse (opcional)
    image_angle = angulo;
}

// Faz a escala X e Y voltarem gradualmente para 1
scala_x = lerp(scala_x, escala_alvo, fator_mola);
scala_y = lerp(scala_y, escala_alvo, fator_mola);