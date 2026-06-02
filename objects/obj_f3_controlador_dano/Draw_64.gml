if (flash_vermelho > 0) {
    draw_set_alpha(flash_vermelho);
    draw_set_color(c_red);
    
    // Desenha um retângulo que cobre toda a área da sala
    // Usamos room_width e room_height para garantir que cubra o fundo todo
    draw_rectangle(0, 0, room_width, room_height, false);
    
    draw_set_alpha(1);
    draw_set_color(c_white); // Reset padrão
}