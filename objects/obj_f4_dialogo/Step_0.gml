entrada_fade = max(0, entrada_fade - 1 / (room_speed * 2.4));

// 1. Lógica de animação de entrada e saída
if (estado == "abrindo") {
    abertura = lerp(abertura, 1, 0.1);
    if (abertura > 0.99) {
        estado = "ativo";
        ns_audio_play_sfx(snd_f4_dialogo, 1, 0, 1, 0, 1);
    }
} else if (estado == "fechando") {
    abertura = lerp(abertura, 0, 0.2);
    troca_audio_timer = max(0, troca_audio_timer - 1);
    if (abertura < 0.05 && troca_audio_timer <= 0) instance_destroy();
} else if (estado == "skip_retry") {
    troca_audio_timer = max(0, troca_audio_timer - 1);
    if (entrada_fade <= 0 && troca_audio_timer <= 0) instance_destroy();
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
                ns_audio_gain_music(cutscene_audio, 0, 900);
                var _musica_fase = ns_audio_play_music(snd_f4_musica_chefe, 1, true, 0, 0, 1);
                ns_audio_gain_music(_musica_fase, 0.82, 900);
                troca_audio_timer = ceil(room_speed * 0.9);
            } else {
                ns_audio_play_sfx(snd_f4_dialogo, 1, 0, 1, 0, 1);
            }
        }
    }
}

// 3. Movimento sutil das bordas irregulares
glitch_timer++;
if (glitch_timer mod 3 == 0) {
    for (var i = 0; i < pontos_borda; i++) {
        offsets_borda[i] = random_range(-intensidade_glitch, intensidade_glitch);
    }
}
