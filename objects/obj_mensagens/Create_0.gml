// --- DEFINIÇÕES VISUAIS ---
sprite_index = spr_mensagem;
image_xscale = 3.429999;
image_yscale = 3.909091;

// --- POSIÇÕES ---
x = 89;
y = 210;
destino_x = 376;
destino_y = 837;

// --- VARIÁVEIS DE CONTROLE ---
proximo_criado = false; 
iniciado = false; // A CHAVE PARA ARRUMAR O BUG ESTÁ AQUI

estado = 0; 
fps_jogo = game_get_speed(gamespeed_fps);
velocidade_descida = 2.5;

// Os timers não são mais definidos aqui para evitar o bug de sobreposição!
timer_inicio = 0;
timer_meio = 0;
timer_cascata = 0;