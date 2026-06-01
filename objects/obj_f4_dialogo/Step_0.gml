entrada_fade = max(0, entrada_fade - 0.025);

// 1. Lógica de animação de entrada e saída
if (estado == "abrindo") {
    abertura = lerp(abertura, 1, 0.1);
    if (abertura > 0.99) {
        estado = "ativo";
        audio_play_sound(snd_f4_dialogo, 1, 0);
    }
} else if (estado == "fechando") {
    abertura = lerp(abertura, 0, 0.2);
    if (abertura < 0.05) instance_destroy();
}

// 2. Máquina de escrever e avanço do diálogo
if (estado == "ativo") {
    if (tamanho_texto < string_length(textos[pagina_atual])) {
        tamanho_texto += velocidade_texto;
    } else {
        audio_stop_sound(snd_f4_dialogo);
    }
    
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        if (tamanho_texto < string_length(textos[pagina_atual])) {
            tamanho_texto = string_length(textos[pagina_atual]);
            audio_stop_sound(snd_f4_dialogo);
        } else {
            pagina_atual++;
            tamanho_texto = 0;
            if (pagina_atual >= array_length(textos)) {
                estado = "fechando";
                audio_play_sound(snd_f4_musica_chefe, 1, 1);
            } else {
                audio_play_sound(snd_f4_dialogo, 1, 0);
            }
        }
    }
}

// 3. Movimento sutil das bordas irregulares
for (var i = 0; i < pontos_borda; i++) {
    offsets_borda[i] = random_range(-intensidade_glitch, intensidade_glitch); 
}
