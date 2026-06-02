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

resultado_ativo = false;
resultado_vitoria = false;
resultado_transicao = 0;
resultado_saida = 0;
resultado_vidas = 0;
resultado_chefe = 0;
resultado_nota = "0/10";

exibir_resultado = function(_vitoria) {
    if (resultado_ativo) return;
    resultado_ativo = true;
    resultado_vitoria = _vitoria;
    resultado_transicao = 0;
    resultado_saida = 0;
    resultado_vidas = instance_exists(obj_f4_nave) ? max(0, obj_f4_nave.vida) : 0;
    resultado_chefe = instance_exists(obj_f4_chefe) ? max(0, round(obj_f4_chefe.vida / obj_f4_chefe.vidaMax * 100)) : 0;
    resultado_nota = _vitoria
        ? string(clamp(round(7 + resultado_vidas * 0.75), 7, 10)) + "/10"
        : string(clamp(round((100 - resultado_chefe) * 0.05), 0, 5)) + "/10";
    if (view_camera[0] != -1) {
        camera_set_view_size(view_camera[0], room_width, room_height);
        camera_set_view_pos(view_camera[0], 0, 0);
    }
    audio_stop_all();
    instance_deactivate_all(true);
    instance_activate_object(obj_controlador_jogo);
};
