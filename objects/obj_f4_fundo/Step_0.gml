if (resultado_ativo) {
    resultado_transicao = min(1, resultado_transicao + 0.055);
    var _offset = lerp(36, 0, resultado_transicao);
    var _mouse_gui_x = device_mouse_x_to_gui(0);
    var _mouse_gui_y = device_mouse_y_to_gui(0);
    var _hover_menu = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 312, 375 + _offset, 454, 411 + _offset);
    var _hover_reiniciar = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 506, 375 + _offset, 648, 411 + _offset);
    if (resultado_saida == 0 && mouse_check_button_pressed(mb_left)) {
        if (_hover_menu) resultado_saida = 1;
        if (_hover_reiniciar) resultado_saida = 2;
    }
    if (resultado_saida == 0 && keyboard_check_pressed(vk_enter)) resultado_saida = 1;
    if (resultado_saida != 0) {
        window_set_cursor(cr_none);
        cursor_sprite = cr_none;
        resultado_saida_fade = min(1, resultado_saida_fade + 0.065);
        if (resultado_saida_fade >= 1) {
            if (resultado_saida == 1) {
                global.menu_reverso = true;
                global.menu_destino_room = rm_menu;
                room_goto(rm_menu2);
            } else {
                room_goto(rm_fase4);
            }
        }
    }
    return;
}

tempo_fase++;

corrupt_flash = max(0, corrupt_flash - 0.025);
shake_fx = max(0, shake_fx - 0.55);

if (instance_exists(obj_f4_nave)) {
    var diff = obj_f4_nave.x - (room_width / 2);
    camera_offset_x = lerp(camera_offset_x, diff, 0.1); 
}

if (instance_exists(obj_f4_controlador_morte)) {
    shake_fx = 0;
} else if (view_camera[0] != -1 && shake_fx > 0) {
    camera_set_view_pos(view_camera[0], sin(current_time * 0.031) * shake_fx, cos(current_time * 0.027) * shake_fx * 0.62);
} else if (view_camera[0] != -1) {
    camera_set_view_pos(view_camera[0], 0, 0);
}

for (var i = 0; i < num_poeiras; i++) {
    poeira_z[i] -= 0.015;
    if (poeira_z[i] <= 0.05) {
        poeira_z[i] = random_range(1.8, 2);
        poeira_x[i] = random_range(-room_width, room_width * 2);
        poeira_y[i] = random_range(0, horizon_y);
    }
}
