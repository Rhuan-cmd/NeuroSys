// Força atual do tremor
shake_remain = 0;
// Quão rápido o tremor perde força (0.1 a 0.5 é o ideal)
shake_magnitude = 0.5;

estado_felicidade = 0;
total_felicidade = 5;

atualizar_felicidade = total_felicidade;

cor_barra =  make_color_rgb(3, 255, 0);

perdeu = false;

image_speed = 0;

// Tamanho padrão da sua tela (ajuste para a resolução do seu jogo)
largura_base = 960;
altura_base = 540;

// O nível de zoom que queremos (1 = normal, 0.5 = muito perto, 2 = longe)
zoom_alvo = 1;      // 1 = normal, 0.5 = zoom in, 2 = zoom out
zoom_atual = 1;     // Começa no normal
velocidade_zoom = 0.1; // Quão suave é a transição (0.1 a 0.01)

zoom = false;

idbackground = layer_background_get_id("Background");