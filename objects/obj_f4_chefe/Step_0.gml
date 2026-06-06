if (instance_exists(obj_f4_barra_vida_chefe)){
	obj_f4_barra_vida_chefe.hp = vida / vidaMax;
}

if (morto){
	
	return;
}

if (vida <= 0) {
	if (instance_exists(obj_f4_controlador_ataque4)){
		instance_destroy(obj_f4_controlador_ataque4);
	}
	instance_create_layer(0, 0, "projeteis_boss", obj_f4_controlador_morte);
	if (instance_exists(obj_f4_nave)){
		obj_f4_nave.vel = 0;
	}
	instance_destroy(obj_f4_barra_vida_chefe);
	audio_stop_all();
	audio_play_sfx(snd_f4_chefe_derrotado, 1, 0);
	morto = true;
}

#region Movimento
// 1. Delta Time e Timer do Loop Vertical (O que já fizemos)
var dt = delta_time / 1000000;
timer += dt * velocidade_loop * pi * 2;
var oscilacao = sin(timer);

// 2. Lógica do Movimento Lateral Reativo
if (instance_exists(obj_f4_nave)) {
    // Calcula a distância entre o objeto e a nave
    // Se a nave está à direita, o valor é positivo. À esquerda, negativo.
    var dist_x = obj_f4_nave.x - x_base;
    
    // Alvo do deslocamento baseado na intensidade
    var alvo_x = dist_x * intensidade_parallax;
    
    // Suaviza o movimento para não ser um teletransporte (Lerp independente de FPS)
    x_offset = lerp(x_offset, alvo_x, 0.1 * (60 * dt));
}

// 3. Aplicar Posição Final
x = x_base + x_offset; // Aplica o movimento lateral
y = y_base + (oscilacao * amplitude_movimento); // Mantém o loop vertical

// 4. Aplicar Escala (Crescimento)
image_xscale = escala_base + (oscilacao * amplitude_escala);
image_yscale = image_xscale;
#endregion

if (danificado){
	tempo_danificado--;
	
	if (tempo_danificado <= 0){
		danificado = false;
	}
}

if (descansar) return;

if (vida <= vidaMax and vida > (vidaMax/4) * 3){
	fase1();
	
}else if (vida <= (vidaMax/4) * 3 and vida > (vidaMax/4) * 2){
	fase2();
	
}else if (vida <= (vidaMax/4) * 2 and vida > (vidaMax/4)){
	fase3();
	
}else{
	fase4();
}