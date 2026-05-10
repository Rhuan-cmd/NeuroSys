if (abertura <= 0) return;

// 1. CÁLCULO DA ÁREA
var _L = largura_grade * abertura;
var _A = altura_grade * abertura;
var _x1 = x - (_L / 2);
var _y1 = y - (_A / 2);
var _x2 = x + (_L / 2);
var _y2 = y + (_A / 2);

// 2. FUNDO COM RUÍDO
draw_set_alpha(0.15 * abertura);
draw_set_color(c_black);
draw_rectangle(_x1, _y1, _x2, _y2, false);

for (var i = 0; i < 30; i++) {
    draw_set_color(choose(c_white, cor_base, c_red));
    draw_point(random_range(_x1, _x2), random_range(_y1, _y2));
}
draw_set_alpha(1);

// 3. ESTRUTURA HORIZONTAL (Apenas topo e base para fechar a grade)
draw_set_color(cor_base);
var _g = random_range(-intensidade_glitch, intensidade_glitch);
draw_line_width(_x1, _y1 + _g, _x2, _y1 + _g, espessura_barra); // Topo
draw_line_width(_x1, _y2 + _g, _x2, _y2 + _g, espessura_barra); // Base

// 4. BARRAS VERTICAIS GROSSAS
// Desenhamos as laterais e as do meio
for (var i = 0; i <= _L; i += espacamento) {
    var _bx = _x1 + i;
    var _bg = (random(100) < 10) ? random_range(-4, 4) : 0; // Glitch lateral ocasional
    
    // Sombra de erro (Vermelha) atrás da barra
    draw_set_color(c_red);
    draw_line_width(_bx + _bg - 2, _y1, _bx + _bg - 2, _y2, espessura_barra);
    
    // Barra Principal
    draw_set_color(cor_base);
    draw_line_width(_bx + _bg, _y1, _bx + _bg, _y2, espessura_barra);
}

// 5. SIRENE NO TOPO CENTRAL
if (abertura > 0.8) {
    var _cor_sirene = (floor(timer_sirene) % 2 == 0) ? cor_policia_1 : cor_policia_2;
    draw_set_color(c_dkgray);
    draw_rectangle(x - 30, _y1 - 15, x + 30, _y1, false); // Base
    draw_set_color(_cor_sirene);
    draw_set_alpha(0.4);
    draw_circle(x, _y1 - 8, 20 + random(10), false); // Brilho
    draw_set_alpha(1);
    draw_rectangle(x - 20, _y1 - 12, x + 20, _y1 - 3, false); // Lâmpada
}

// 6. CADEADO TECNOLÓGICO (Canto inferior direito)
// 6. CADEADO TECNOLÓGICO MINI (Canto inferior direito)
if (abertura > 0.9) {
    // Definimos uma escala para o cadeado
    var _escala_cad = 0.6; // 60% do tamanho original
    var _cx = _x2 - 35;    // Ajuste de posição no canto
    var _cy = _y2 - 30;
    var _cg = random_range(-0.5, 0.5); // Tremor reduzido por ser menor
    
    // 6.1 Arco do cadeado (Menor e mais fino)
    draw_set_color(c_silver);
    var _arco_w = 12 * _escala_cad;
    var _arco_h = 15 * _escala_cad;
    
    // Linhas do arco
    draw_line_width(_cx + _cg, _cy, _cx + _cg, _cy - _arco_h, 3); // Lado esquerdo
    draw_line_width(_cx + _arco_w + _cg, _cy, _cx + _arco_w + _cg, _cy - _arco_h, 3); // Lado direito
    draw_line_width(_cx + _cg, _cy - _arco_h, _cx + _arco_w + _cg, _cy - _arco_h, 3); // Topo
    
    // 6.2 Corpo do cadeado (Compacto)
    var _corpo_w = 25 * _escala_cad;
    var _corpo_h = 25 * _escala_cad;
    
    draw_set_color(make_color_rgb(30, 30, 30)); 
    draw_rectangle(_cx - 5 + _cg, _cy, _cx + _arco_w + 5 + _cg, _cy + _corpo_h, false);
    
    // 6.3 Luz de Status (Pequeno LED)
    var _cor_led = (random(100) < 5) ? c_white : c_red;
    draw_set_color(_cor_led);
    draw_circle(_cx + (_arco_w / 2) + _cg, _cy + (_corpo_h / 2), 2, false);
}

draw_set_color(c_white);