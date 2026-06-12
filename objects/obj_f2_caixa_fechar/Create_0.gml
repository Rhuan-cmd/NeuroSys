// ===== CONFIGURACAO VISUAL E MOVIMENTO BASE DO X =====
image_speed = 0;
image_xscale = 1;
image_yscale = 1;
depth = -200;
escala_padrao = 1.2;

dificuldade = 0;
velocidade = 5.2;
precisao = 0.055;
raio_fuga = 125;
forca_fuga = 0.55;
vx = 0;
vy = 0;
alvo_x = x;
alvo_y = y;
trocar_alvo_timer = 0;
margem = 36;
modo_intro = false;
intro_timer = 0;
intro_duracao = 20;
intro_x0 = x;
intro_y0 = y;
intro_x1 = x;
intro_y1 = y;
imortal_timer = 16;
// ===== RASTRO VISUAL DO X =====
rastro_indice = 0;
rastro_tick = 0;
rastro_x = [];
rastro_y = [];
rastro_alpha = [];
for (var rastro_i = 0; rastro_i < 3; rastro_i++) {
    rastro_x[rastro_i] = x;
    rastro_y[rastro_i] = y;
    rastro_alpha[rastro_i] = 0;
}

// ===== CURVA DE DIFICULDADE POR QUANTIDADE DE ACERTOS =====
configurar = function(_dificuldade) {
    dificuldade = _dificuldade;
    if (dificuldade < 3) {
        velocidade = 4.55 + dificuldade * 0.22;
        precisao = 0.060 + dificuldade * 0.004;
        raio_fuga = 106 + dificuldade * 5;
        forca_fuga = 0.42 + dificuldade * 0.025;
    } else if (dificuldade < 8) {
        var medio = dificuldade - 3;
        velocidade = 5.28 + medio * 0.27;
        precisao = 0.078 + medio * 0.006;
        raio_fuga = 126 + medio * 6;
        forca_fuga = 0.56 + medio * 0.035;
    } else {
        var dificil = dificuldade - 8;
        velocidade = 6.75 + dificil * 0.38;
        precisao = 0.110 + dificil * 0.010;
        raio_fuga = 158 + dificil * 8;
        forca_fuga = 0.78 + dificil * 0.055;
    }
    if (dificuldade >= 8) {
        var _final = dificuldade - 8;
        velocidade = 7.05 + _final * 0.42;
        precisao = 0.118 + _final * 0.012;
        raio_fuga = 166 + _final * 9;
        forca_fuga = 0.86 + _final * 0.065;
        margem = 48 + _final * 2;
    }
    imortal_timer = dificuldade > 0 ? 18 : 0;
    image_xscale = escala_padrao;
    image_yscale = escala_padrao;
};

// ===== ESCOLHA DE DESTINOS ALEATORIOS NA ROOM =====
novo_alvo = function() {
    alvo_x = random_range(margem, room_width - margem);
    alvo_y = random_range(margem, room_height - margem);
    trocar_alvo_timer = dificuldade >= 8 ? irandom_range(5, 12) : (dificuldade >= 4 ? irandom_range(9, 22) : irandom_range(12, 28));
};

reposicionar = function() {
    x = random_range(margem, room_width - margem);
    y = random_range(margem, room_height - margem);
    vx = random_range(-2, 2);
    vy = random_range(-2, 2);
    novo_alvo();
};

vx = random_range(-2, 2);
vy = random_range(-2, 2);
novo_alvo();
