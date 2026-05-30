image_speed = 0;
image_xscale = 1;
image_yscale = 1;
depth = -200;
escala_padrao = 1.12;

dificuldade = 0;
velocidade = 6.4;
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
rastro_indice = 0;
rastro_tick = 0;
rastro_x = [];
rastro_y = [];
rastro_alpha = [];
for (var rastro_i = 0; rastro_i < 8; rastro_i++) {
    rastro_x[rastro_i] = x;
    rastro_y[rastro_i] = y;
    rastro_alpha[rastro_i] = 0;
}

configurar = function(_dificuldade) {
    dificuldade = _dificuldade;
    if (dificuldade < 3) {
        velocidade = 4.75 + dificuldade * 0.18;
        precisao = 0.058 + dificuldade * 0.004;
        raio_fuga = 102 + dificuldade * 4;
        forca_fuga = 0.42 + dificuldade * 0.025;
    } else if (dificuldade < 8) {
        var medio = dificuldade - 3;
        velocidade = 5.45 + medio * 0.22;
        precisao = 0.074 + medio * 0.006;
        raio_fuga = 116 + medio * 5;
        forca_fuga = 0.52 + medio * 0.035;
    } else {
        var dificil = dificuldade - 8;
        velocidade = 6.75 + dificil * 0.42;
        precisao = 0.112 + dificil * 0.012;
        raio_fuga = 142 + dificil * 7;
        forca_fuga = 0.72 + dificil * 0.055;
    }
    if (dificuldade >= 9) {
        velocidade = 9.2;
        precisao = 0.178;
        raio_fuga = 184;
        forca_fuga = 1.08;
        margem = 42;
    }
    imortal_timer = dificuldade > 0 ? 18 : 0;
    image_xscale = escala_padrao;
    image_yscale = escala_padrao;
};

novo_alvo = function() {
    alvo_x = random_range(margem, room_width - margem);
    alvo_y = random_range(margem, room_height - margem);
    trocar_alvo_timer = irandom_range(14, 32);
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
