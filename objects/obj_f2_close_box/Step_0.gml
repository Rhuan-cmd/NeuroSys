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
    }
    exit;
}

trocar_alvo_timer--;

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
