// 1. Calcula a base da escala pela posição Y (seu código original)
var porcentagem = clamp((y - y_topo) / (y_base - y_topo), 0, 1);
var escala_base = lerp(escala_min, escala_max, porcentagem);

// 2. Calcula a oscilação do pulso
tempo_pulso += velocidade_pulso;
// O abs(sin) faz pulsar sempre para cima, ou use apenas sin para inflar e desinflar
var variacao = abs(sin(tempo_pulso)) * intensidade_pulso;

// 3. Aplica o pulso relativo à escala atual
scale = escala_base + variacao;

image_xscale = scale;
image_yscale = scale;