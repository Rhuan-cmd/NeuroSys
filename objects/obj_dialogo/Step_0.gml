// --- Evento Step ---

// 1. Lógica de Animação de Entrada e Saída
if (estado == "abrindo") {
    abertura = lerp(abertura, 1, 0.1);
    if (abertura > 0.99){
		estado = "ativo";
		audio_play_sound(snd_dialogo_fase4, 1, 0);
	}
} else if (estado == "fechando") {
    abertura = lerp(abertura, 0, 0.2);
    if (abertura < 0.05) instance_destroy();
}

// 2. Lógica de Texto (Máquina de escrever)
if (estado == "ativo") {
    if (tamanho_texto < string_length(textos[pagina_atual])) {
        tamanho_texto += velocidade_texto;
    }else{
		audio_stop_sound(snd_dialogo_fase4);
	}
    
    // Avançar diálogo
    if (keyboard_check_pressed(vk_space)) {
        if (tamanho_texto < string_length(textos[pagina_atual])) {
            tamanho_texto = string_length(textos[pagina_atual]);
			audio_stop_sound(snd_dialogo_fase4);
        } else {
            pagina_atual++;
            tamanho_texto = 0;
            if (pagina_atual >= array_length(textos)){
				estado = "fechando";
				audio_play_sound(snd_music_bossfight, 1, 1);
			}else{
				audio_play_sound(snd_dialogo_fase4, 1, 0);
			}
        }
    }
}

// ... (mantenha a lógica de animação e texto igual) ...

// 3. Atualizar as Bordas Irregulares (Movimento mais sutil)
for (var i = 0; i < pontos_borda; i++) {
    // Usamos um valor menor para o tremor ser menos agressivo
    offsets_borda[i] = random_range(-intensidade_glitch, intensidade_glitch); 
}