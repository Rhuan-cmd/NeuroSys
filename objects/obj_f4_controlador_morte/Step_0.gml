if (zoom && camera_morte != -1) {
    zoom_atual = lerp(zoom_atual, zoom_alvo, velocidade_zoom);
    var _nova_largura = largura_base * zoom_atual;
    var _nova_altura = altura_base * zoom_atual;
    var _camera_x = clamp(camera_alvo_x - _nova_largura / 2, 0, room_width - _nova_largura);
    var _camera_y = clamp(camera_alvo_y - _nova_altura * 0.28, 0, room_height - _nova_altura);
    camera_set_view_size(camera_morte, _nova_largura, _nova_altura);
    camera_set_view_pos(
        camera_morte,
        _camera_x,
        _camera_y
    );
}

if (mover) {
    yboss = lerp(yboss, yvilaodestino, 0.1);
    if (yboss >= yvilaodestino - 2 && !ajeitar) {
        mover = false;
        yboss = yvilaodestino;
        alarm[2] = 60;
        ajeitar = true;
    }
}

if (encerrando) {
    if (!audio_fade_iniciado) {
        audio_gain_sfx(snd_f4_chefe_derrotado, 0, 5400);
        audio_gain_music(snd_f4_musica_chefe, 0, 5400);
        audio_fade_iniciado = true;
    }
    timer_encerramento++;
    if (timer_encerramento > espera_fade) {
        fade_saida = min(1, fade_saida + 1 / duracao_fade);
    }
    if (fade_saida >= 1) {
        timer_preto++;
        if (timer_preto >= room_speed * 3) {
            global.fase_liberada = max(variable_global_exists("fase_liberada") ? global.fase_liberada : 1, 4);
            global.fase_concluida = max(variable_global_exists("fase_concluida") ? global.fase_concluida : 0, 4);
            save_marcar_sujo();
            room_goto(rm_creditos);
        }
    }
}
