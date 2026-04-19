horizon_y = room_height / 2;

// --- Variável Global de Câmera/Parallax ---
camera_offset_x = 0; 

// --- 1. Poeiras/Partículas 3D ---
num_poeiras = 80;
for (var i = 0; i < num_poeiras; i++) {
    // Espalhamos a poeira por uma área bem grande
    poeira_x[i] = random_range(-room_width, room_width * 2);
    poeira_y[i] = random_range(0, horizon_y); // Apenas no céu
    poeira_z[i] = random_range(0.1, 2);       // Z = Profundidade (2 é longe, 0 é perto)
}

// --- 2. Equalizador de Áudio (Ondas) ---
num_barras = 80; // Quantidade de barras (quanto mais, mais grudadas)
// A largura total da onda vai ser o DOBRO da tela, para termos sobra nas laterais
barra_w = (room_width * 2) / num_barras;