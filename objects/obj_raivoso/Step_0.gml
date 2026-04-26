// Converte microssegundos para segundos (ex: 0.016 em 60 FPS)
var dt = delta_time / 1000000;

// Subtraímos da posição Y para ele subir (em GameMaker, Y diminui para cima)
y += velocidade * dt;
// 2. Calcula a porcentagem da posição (0 no topo, 1 na base)
// A função clamp garante que se o objeto sair da tela, a escala não quebre
var porcentagem = clamp( (y - y_topo) / (y_base - y_topo), 0, 1);

// 3. Aplica a escala baseada na porcentagem
// Se porcentagem é 0 (topo), usa escala_min. Se é 1 (base), usa escala_max.
scale = lerp(escala_min, escala_max, porcentagem);

image_xscale = scale;
image_yscale = scale;