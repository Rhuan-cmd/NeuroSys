menu_timer += 1;
hover = -1;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

for (var i = 0; i < array_length(fase_nome); i += 1) {
    if (mx >= fase_x - 150 && mx <= fase_x + 150 && my >= fase_y[i] - 26 && my <= fase_y[i] + 26) {
        hover = i;
        break;
    }
}

if (hover != -1 && mouse_check_button_pressed(mb_left)) {
    room_goto(fase_room[hover]);
}

if (keyboard_check_pressed(vk_escape)) {
    room_goto(rm_menu);
}
