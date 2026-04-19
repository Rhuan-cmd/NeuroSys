vel = 500;

// Limites de Movimentação
// A nave só vai até o meio da tela (room_height / 2) no eixo Y
limit_top = room_height / 2 + 20;
limit_bottom = room_height - 50; // Um pequeno respiro no fundo
limit_left = 50;
limit_right = room_width - 50;

// Profundidade e Escala
min_y = limit_top;
max_y = limit_bottom;
min_scale = 0.8;
max_scale = 1.5;

// Suavização do 3D (Tilt)
tilt_y_current = 1; // Começa na escala normal

rotacao = 0;


pode_atirar = true;
tempo_tiro = 10;