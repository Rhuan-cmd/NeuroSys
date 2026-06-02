if (instance_exists(obj_f4_nave)){
	vida = obj_f4_nave.vida;
}

frame = clamp(vida, 0, 4);

if (tomou_dano){
	criar_explosao_particulas(40, room_height-20, c_yellow, 10, 0.3);
	tremer = true;
	shake_remain = 10;
	tomou_dano = false;
}

if (tremer){
	var dt = delta_time / 1000000;
	tempo_tremer -= dt;
	
	rotacao = irandom_range(-10, 10);
	
	if (tempo_tremer <= 0){
		tempo_tremer = 0.2;
		rotacao = 0;
		tremer = false;
	}
}

// Se ainda houver tremor para processar
if (instance_exists(obj_f4_controlador_morte)) {
    shake_remain = 0;
} else if (shake_remain > 0) {
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
