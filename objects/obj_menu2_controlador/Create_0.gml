timer = 0;
duracao = room_speed * 2.8;
monitor_x = 443;
monitor_y = 271;
proxima_room = rm_fase1;

if (variable_global_exists("menu_destino_room")) {
    proxima_room = global.menu_destino_room;
}

window_set_cursor(cr_none);
cursor_sprite = cr_none;
