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
	if (instance_exists(obj_boss)) {
	    // Calculamos onde o X e Y devem estar para o alvo ficar no CENTRO
	    var vx = obj_boss.x - (nova_largura / 2);
	    var vy = obj_boss.y - (nova_altura / 2);

	    // Opcional: Impedir que a câmera mostre o "vazio" fora da sala (bordas)
	    vx = clamp(vx, 0, room_width - nova_largura);
	    vy = clamp(vy, 0, room_height - nova_altura);

	    // Aplica a nova posição
	    camera_set_view_pos(view_camera[0], vx, vy);
	}
}