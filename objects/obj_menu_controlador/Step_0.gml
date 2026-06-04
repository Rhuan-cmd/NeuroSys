entrada_bloqueada = max(0, entrada_bloqueada - 1);

if (!clique_iniciado && entrada_bloqueada <= 0) {
    if (mouse_check_button_pressed(mb_left) || keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        clique_iniciado = true;
        room_goto(rm_menu2);
    }
}
