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
	    var vx = pos_base_x - (nova_largura / 2);
	    var vy = pos_base_y - (nova_altura / 2);
		
	    // Opcional: Impedir que a câmera mostre o "vazio" fora da sala (bordas)
	    vx = clamp(vx, 0, room_width - nova_largura);
	    vy = clamp(vy, 0, room_height - nova_altura);

	    // Aplica a nova posição
	    camera_set_view_pos(view_camera[0], vx, vy);
	}
}


if (x < room_width/2){
	image_xscale = -escala;
}else{
	image_xscale = escala;
}

if (parar){
	path_end();
	tremer = true;
	alarm[0] = 120;
	pos_base_x = x;
	pos_base_y = y;
	zoom = true;
	zoom_alvo = 0.3;
	parar = false;
}

if (tremer){
	x = pos_base_x + irandom_range(-2, 2);
	y = pos_base_y + irandom_range(-2, 2);
	
	if (tempo_cor < 1) {
	    tempo_cor += 0.01; 
	}
	
	image_blend = merge_color(c_white, c_red, tempo_cor);
}