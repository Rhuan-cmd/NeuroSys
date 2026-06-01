// 1. Defina quem é o objeto central e o raio da órbita
var objeto_centro = obj_f3_npc; // Altere para o nome do seu objeto central
var raio = 96;                  // A distância que ele ficará do centro

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

if (destruidos >= 50 and !umavez){
	if (instance_exists(obj_f3_controlador_msg)){
		instance_destroy(obj_f3_controlador_msg);
	}
	
	if (instance_exists(obj_f3_msg_negativa)){
		with (obj_f3_msg_negativa){
			instance_destroy()
		}
	}
	ganhou = true;
	audio_stop_all();
	audio_play_sound(snd_f3_vilao_raiva, 1, 0);
	umavez = true;
	destruidos = 50;
}

if (ganhou){
	if (instance_exists(obj_f3_vilao)){
		obj_f3_vilao.parar = true;
	}
	
	ganhou = false;
}