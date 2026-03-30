if (perdeu){
	total_felicidade = lerp(total_felicidade, 0, 0.1);
	return;
}

if (flash_vermelho > 0) {
    var lay_id = layer_get_id("Background"); // Nome da sua camada de fundo
	var back_id = layer_background_get_id(lay_id);

	// Interpola entre o Branco (normal) e Vermelho baseado na nossa variável
	var cor_atual = merge_color(c_white, c_red, flash_vermelho);
	layer_background_blend(back_id, cor_atual);

	// Diminui o flash
	flash_vermelho = max(0, flash_vermelho - flash_suave);
}

// Se ainda houver tremor para processar
if (shake_remain > 0) {
    // Escolhe um valor aleatório entre -shake_remain e +shake_remain
    var _x_shake = random_range(-shake_remain, shake_remain);
    var _y_shake = random_range(-shake_remain, shake_remain);
    
    // Aplica o tremor na câmera principal (view 0)
    camera_set_view_pos(view_camera[0], _x_shake, _y_shake);
    
    // Reduz a força do tremor aos poucos para ele parar suavemente
    shake_remain = max(0, shake_remain - shake_magnitude);
} else {
    // Se não estiver tremendo, garante que a câmera volte para (0,0) 
    // ou siga o jogador se você tiver um código de seguimento.
    camera_set_view_pos(view_camera[0], 0, 0); 
}

if (atualizar_felicidade > 0){
	total_felicidade = lerp(total_felicidade, atualizar_felicidade, 0.1);
	
	if (total_felicidade >= 4){
		estado_felicidade = 0;
		cor_barra = make_color_rgb(3, 255, 0);
	}else if (total_felicidade >= 2){
		estado_felicidade = 1;
		cor_barra = c_yellow;
	}else{
		estado_felicidade = 2;
		cor_barra = c_red;
	}
}else{
	estado_felicidade = 2;
	flash_vermelho = 1;
	cor_barra = c_red;
	with (obj_mensagem_negativa){
		instance_destroy();
	}
	with (obj_controller_mensagem_negativa){
		instance_destroy();
	}
	
	perdeu = true;
}