velocidade_linear = 4;
path_start(pth_f3_vilao, velocidade_linear, path_action_continue, true);

escala = image_xscale;

parar = false;
tremer = false;

pos_base_x = x;
pos_base_y = y;

tempo_cor = 0;

// Tamanho padrão da sua tela (ajuste para a resolução do seu jogo)
largura_base = 960;
altura_base = 540;

// O nível de zoom que queremos (1 = normal, 0.5 = muito perto, 2 = longe)
zoom_alvo = 1;      // 1 = normal, 0.5 = zoom in, 2 = zoom out
zoom_atual = 1;     // Começa no normal
velocidade_zoom = 0.1; // Quão suave é a transição (0.1 a 0.01)

zoom = false;