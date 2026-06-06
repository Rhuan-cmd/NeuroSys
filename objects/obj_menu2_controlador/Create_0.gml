timer = 0;
duracao = room_speed * 1.72;
monitor_x = 443;
monitor_y = 271;
proxima_room = rm_fase1;
reverso = false;
som_reverso_id = -1;

if (variable_global_exists("menu_destino_room")) {
    proxima_room = global.menu_destino_room;
}
if (variable_global_exists("menu_reverso")) {
    reverso = global.menu_reverso;
}
if (reverso) {
    duracao = room_speed * 1.55;
    if (variable_global_exists("menu_destino_room")) {
        proxima_room = global.menu_destino_room;
    } else {
        proxima_room = rm_menu;
    }
    som_reverso_id = ns_audio_play_sfx(snd_menu_succao_reverso, 1, false, 0.9, 0, 1);
}

window_set_cursor(cr_none);
cursor_sprite = cr_none;
