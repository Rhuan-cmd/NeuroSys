alarm[0] = 30;

cont = 0;

desenhar = false;
mover = false;
ajeitar = false;

xboss = 0;
yboss = 0;
yvilaodestino = 0;

// Tamanho padrão da sua tela (ajuste para a resolução do seu jogo)
largura_base = 960;
altura_base = 540;

// O nível de zoom que queremos (1 = normal, 0.5 = muito perto, 2 = longe)
zoom_alvo = 0.5;      // 1 = normal, 0.5 = zoom in, 2 = zoom out
zoom_atual = 1;     // Começa no normal
velocidade_zoom = 0.1; // Quão suave é a transição (0.1 a 0.01)

zoom = true;


alpha = 0;