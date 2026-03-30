// Força atual do tremor
shake_remain = 0;
// Quão rápido o tremor perde força (0.1 a 0.5 é o ideal)
shake_magnitude = 0.5;

estado_felicidade = 0;
total_felicidade = 5;

atualizar_felicidade = total_felicidade;

cor_barra =  make_color_rgb(3, 255, 0);

// Intensidade do flash (0 = normal, 1 = totalmente vermelho)
flash_vermelho = 0;
// Velocidade do retorno (quanto menor, mais suave/lento)
flash_suave = 0.01;

perdeu = false;