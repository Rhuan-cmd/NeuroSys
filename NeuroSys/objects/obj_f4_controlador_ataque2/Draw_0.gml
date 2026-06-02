if (perigo_ativo) {
    draw_set_color(c_red);
    draw_set_alpha(0.5); // 50% de transparência para parecer uma área de alerta
    
    // Desenha o retângulo na largura total e no Y "grampeado" do player
    draw_rectangle(0, pos_y, room_width, pos_y + 100, false);
    
    draw_set_alpha(1.0); // Reseta a transparência
    draw_set_color(c_white);
}