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

configurar = function(_dificuldade) {
    dificuldade = _dificuldade;
    velocidade = 5.65 + dificuldade * 1.02;
    precisao = min(0.23, 0.068 + dificuldade * 0.014);
    raio_fuga = 118 + dificuldade * 9;
    forca_fuga = 0.52 + dificuldade * 0.075;
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
