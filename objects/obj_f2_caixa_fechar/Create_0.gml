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
        velocidade = 4.35 + dificuldade * 0.18;
        precisao = 0.056 + dificuldade * 0.003;
        raio_fuga = 100 + dificuldade * 4;
        forca_fuga = 0.38 + dificuldade * 0.02;
    } else if (dificuldade < 8) {
        var medio = dificuldade - 3;
        velocidade = 5.0 + medio * 0.22;
        precisao = 0.070 + medio * 0.005;
        raio_fuga = 116 + medio * 5;
        forca_fuga = 0.49 + medio * 0.03;
    } else {
        var dificil = dificuldade - 8;
        velocidade = 6.05 + dificil * 0.30;
        precisao = 0.090 + dificil * 0.008;
        raio_fuga = 140 + dificil * 6;
        forca_fuga = 0.63 + dificil * 0.045;
    }
    if (dificuldade >= 10) {
        var _final = dificuldade - 10;
        velocidade = 6.8 + _final * 0.32;
        precisao = 0.108 + _final * 0.011;
        raio_fuga = 152 + _final * 8;
        forca_fuga = 0.74 + _final * 0.06;
        margem = 46 + _final * 2;
    }
    imortal_timer = dificuldade > 0 ? 18 : 0;
    image_xscale = escala_padrao;
    image_yscale = escala_padrao;
};

// ===== ESCOLHA DE DESTINOS ALEATORIOS NA ROOM =====
novo_alvo = function() {
    alvo_x = random_range(margem, room_width - margem);
    alvo_y = random_range(margem, room_height - margem);
    trocar_alvo_timer = dificuldade >= 8 ? irandom_range(8, 18) : irandom_range(14, 32);
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
