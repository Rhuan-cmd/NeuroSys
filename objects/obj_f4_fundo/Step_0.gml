// 1. Câmera/Parallax Suave (Sem saltos, sem mod)
if (instance_exists(obj_f4_nave)) {
    var diff = obj_f4_nave.x - (room_width / 2);
    // Move a "câmera" virtual. O 0.1 garante a suavidade absurda.
    camera_offset_x = lerp(camera_offset_x, diff, 0.1); 
}

// 2. Poeira vindo em direção à câmera (Eixo Z)
for (var i = 0; i < num_poeiras; i++) {
    poeira_z[i] -= 0.015; // Velocidade de aproximação
    
    // Se a poeira passou da câmera (Z chegou perto de 0), ela renasce lá no fundo
    if (poeira_z[i] <= 0.05) {
        poeira_z[i] = random_range(1.8, 2);
        poeira_x[i] = random_range(-room_width, room_width * 2);
        poeira_y[i] = random_range(0, horizon_y);
    }
}