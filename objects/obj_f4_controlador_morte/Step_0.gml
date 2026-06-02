if (zoom) {
    zoom_atual = lerp(zoom_atual, zoom_alvo, velocidade_zoom);
    var _nova_largura = largura_base * zoom_atual;
    var _nova_altura = altura_base * zoom_atual;
    camera_set_view_size(view_camera[0], _nova_largura, _nova_altura);
    camera_set_view_pos(
        view_camera[0],
        clamp(foco_camera_x - _nova_largura / 2, 0, room_width - _nova_largura),
        clamp(foco_y - _nova_altura * 0.36, 0, room_height - _nova_altura)
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
        audio_sound_gain(snd_f4_chefe_derrotado, 0, 5400);
        audio_sound_gain(snd_f4_musica_chefe, 0, 5400);
        audio_fade_iniciado = true;
    }
    timer_encerramento++;
    if (timer_encerramento > espera_fade) {
        fade_saida = min(1, fade_saida + 1 / duracao_fade);
    }
    if (fade_saida >= 1) room_goto(rm_creditos);
}
