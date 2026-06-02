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
resultado_acertos = 0;
resultado_tempo = 0;
resultado_nota = "0/10";
tempo_fase = 0;
corrupt_flash = 0;
shake_fx = 0;

exibir_resultado = function(_vitoria) {
    if (resultado_ativo) return;
    if (_vitoria) {
        audio_stop_all();
        transicao(rm_creditos);
        return;
    }
    resultado_ativo = true;
    resultado_vitoria = false;
    resultado_transicao = 0;
    resultado_saida = 0;
    resultado_acertos = instance_exists(obj_f4_chefe) ? max(0, round((obj_f4_chefe.vidaMax - obj_f4_chefe.vida) / 2)) : 0;
    resultado_tempo = tempo_fase;
    resultado_nota = string(clamp(round((resultado_acertos / 500) * 10), 0, 10)) + "/10";
    with (obj_controlador_jogo) cursor_sprite = spr_ui_cursor;
    if (view_camera[0] != -1) {
        camera_set_view_size(view_camera[0], room_width, room_height);
        camera_set_view_pos(view_camera[0], 0, 0);
    }
    audio_stop_all();
    instance_deactivate_all(true);
    instance_activate_object(obj_controlador_jogo);
};
