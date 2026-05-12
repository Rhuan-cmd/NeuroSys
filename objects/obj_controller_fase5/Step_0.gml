if (keyboard_check_pressed(vk_space) && !excluir){
	instance_create_layer(0, 0, layer, obj_controller_mensagem_negativa);
	excluir = true;
}

tempo_oscilacao += frequencia;

y_instrucao1 = y_ancora + dsin(tempo_oscilacao) * amplitude_instrucao1;

var oscilacao_suave = (dsin(tempo_oscilacao) + 1) / 2;
scale_intrucao2 = 2 + (oscilacao_suave * amplitude_instrucao2);

if (excluir){
	alpha = lerp(alpha, 0, 0.1);
	
	if (alpha <= 0.1){
		instance_destroy();
	}
}