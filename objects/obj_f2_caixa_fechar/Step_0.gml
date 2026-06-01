if (modo_intro) {
    intro_timer++;
    var t_intro = clamp(intro_timer / intro_duracao, 0, 1);
    var t_suave = t_intro * t_intro * (3 - 2 * t_intro);
    x = lerp(intro_x0, intro_x1, t_suave);
    y = lerp(intro_y0, intro_y1, t_suave);
    image_xscale = lerp(0.72, escala_padrao, t_suave);
    image_yscale = image_xscale;
    if (intro_timer >= intro_duracao) {
        modo_intro = false;
        image_xscale = escala_padrao;
        image_yscale = escala_padrao;
        novo_alvo();
        imortal_timer = max(imortal_timer, 14);
    }
    exit;
}

if (imortal_timer > 0) {
    imortal_timer--;
}

trocar_alvo_timer--;
rastro_tick++;
if (rastro_tick >= 2) {
    rastro_tick = 0;
    rastro_indice = (rastro_indice + 1) mod 8;
    rastro_x[rastro_indice] = x;
    rastro_y[rastro_indice] = y;
    rastro_alpha[rastro_indice] = 1;
}
for (var rastro_i = 0; rastro_i < 8; rastro_i++) {
    rastro_alpha[rastro_i] = max(0, rastro_alpha[rastro_i] - 0.085);
}

if (trocar_alvo_timer <= 0 || point_distance(x, y, alvo_x, alvo_y) < 40) {
    novo_alvo();
}

var dir_alvo = point_direction(x, y, alvo_x, alvo_y);
var desejado_x = lengthdir_x(velocidade, dir_alvo);
var desejado_y = lengthdir_y(velocidade, dir_alvo);

var dist_mouse = point_distance(x, y, mouse_x, mouse_y);
if (dist_mouse < raio_fuga) {
    var dir_fuga = point_direction(mouse_x, mouse_y, x, y);
    var intensidade = (1 - dist_mouse / raio_fuga) * velocidade * forca_fuga;
    desejado_x += lengthdir_x(intensidade, dir_fuga);
    desejado_y += lengthdir_y(intensidade, dir_fuga);
}

vx = lerp(vx, desejado_x, precisao);
vy = lerp(vy, desejado_y, precisao);

x += vx;
y += vy;

if (x < margem) {
    x = margem;
    vx = abs(vx);
    novo_alvo();
}
if (x > room_width - margem) {
    x = room_width - margem;
    vx = -abs(vx);
    novo_alvo();
}
if (y < margem) {
    y = margem;
    vy = abs(vy);
    novo_alvo();
}
if (y > room_height - margem) {
    y = room_height - margem;
    vy = -abs(vy);
    novo_alvo();
}
