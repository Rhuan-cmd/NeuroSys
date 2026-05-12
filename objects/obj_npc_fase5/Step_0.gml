if (zoom){
	// 2. Suavização do valor do Zoom
	// O lerp faz o zoom_atual "caminhar" até o zoom_alvo aos poucos
	zoom_atual = lerp(zoom_atual, zoom_alvo, velocidade_zoom);

	// 3. Calcular o novo tamanho da visão
	var nova_largura = largura_base * zoom_atual;
	var nova_altura = altura_base * zoom_atual;

	// 4. Aplicar o novo tamanho à câmera
	camera_set_view_size(view_camera[0], nova_largura, nova_altura);

	// 5. Reposicionar a câmera para centralizar no alvo
	if (instance_exists(self)) {
	    // Calculamos onde o X e Y devem estar para o alvo ficar no CENTRO
	    var vx = self.x - (nova_largura / 2);
	    var vy = self.y - (nova_altura / 2);

	    // Opcional: Impedir que a câmera mostre o "vazio" fora da sala (bordas)
	    vx = clamp(vx, 0, room_width - nova_largura);
	    vy = clamp(vy, 0, room_height - nova_altura);

	    // Aplica a nova posição
	    camera_set_view_pos(view_camera[0], vx, vy);
	}
}

if (perdeu){
	total_felicidade = lerp(total_felicidade, 0, 0.1);
	zoom = true;
	zoom_alvo = 0.3;
	return;
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
		cor_barra = c_blue;
	}
	if (idbackground){
		switch (estado_felicidade){
			case 0:
				layer_background_sprite(idbackground, spr_fundo_fase5_feliz);
				break;
				
			case 1:
				layer_background_sprite(idbackground, spr_fundo_fase5_serio);
				break;
				
			case 2:
				layer_background_sprite(idbackground, spr_fundo_fase5_triste);
				break;
		}
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
	
	alarm[0] = 120;
	audio_stop_sound(snd_music_fase3);
	audio_play_sound(snd_gameover, 1, 0);
	layer_background_sprite(idbackground, spr_fundo_fase5_morte);
	perdeu = true;
}

image_index = estado_felicidade;