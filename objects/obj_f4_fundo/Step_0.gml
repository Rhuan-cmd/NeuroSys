if (resultado_ativo) {
    resultado_transicao = min(1, resultado_transicao + 0.055);
    var _offset = lerp(36, 0, resultado_transicao);
    var _hover_menu = point_in_rectangle(mouse_x, mouse_y, 302, 382 + _offset, 458, 420 + _offset);
    var _hover_reiniciar = point_in_rectangle(mouse_x, mouse_y, 502, 382 + _offset, 658, 420 + _offset);
    if (resultado_saida == 0 && mouse_check_button_pressed(mb_left)) {
        if (_hover_menu) resultado_saida = 1;
        if (_hover_reiniciar) resultado_saida = 2;
    }
    if (resultado_saida == 0 && keyboard_check_pressed(vk_enter)) resultado_saida = 1;
    if (resultado_saida == 1) game_end();
    if (resultado_saida == 2) transicao(rm_fase4);
    return;
}

if (instance_exists(obj_f4_nave)) {
    var diff = obj_f4_nave.x - (room_width / 2);
    camera_offset_x = lerp(camera_offset_x, diff, 0.1); 
}

for (var i = 0; i < num_poeiras; i++) {
    poeira_z[i] -= 0.015;
    if (poeira_z[i] <= 0.05) {
        poeira_z[i] = random_range(1.8, 2);
        poeira_x[i] = random_range(-room_width, room_width * 2);
        poeira_y[i] = random_range(0, horizon_y);
    }
}
