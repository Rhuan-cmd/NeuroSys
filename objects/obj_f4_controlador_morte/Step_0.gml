if (zoom) {
    zoom_atual = lerp(zoom_atual, zoom_alvo, velocidade_zoom);
    var _nova_largura = largura_base * zoom_atual;
    var _nova_altura = altura_base * zoom_atual;
    camera_set_view_size(view_camera[0], _nova_largura, _nova_altura);
    camera_set_view_pos(
        view_camera[0],
        clamp(foco_x - _nova_largura / 2, 0, room_width - _nova_largura),
        clamp(foco_y - _nova_altura / 2, 0, room_height - _nova_altura)
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
    timer_encerramento++;
    fade_saida = min(1, fade_saida + 1 / (room_speed * 1.35));
    if (timer_encerramento >= room_speed * 3) room_goto(rm_creditos);
}
